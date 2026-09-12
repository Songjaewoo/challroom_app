import 'package:json_annotation/json_annotation.dart';

part 'enums.g.dart';

// 앱 전체가 쓰는 Enum 은 이 파일 하나에 모은다.
// 한글 라벨은 `label` 게터로 Enum 안에 응집시킨다 — 화면마다 switch 를 다시 쓰지 않는다.
//
// 서버가 앱이 모르는 값을 보낼 수 있으면, Enum 이 아니라 그 값을 쓰는 **모델 필드**에
// fallback 을 준다 — 값 하나 추가됐다고 앱이 죽지 않게:
//
//   @JsonKey(unknownEnumValue: RoomStatus.open) required RoomStatus status,

@JsonEnum(alwaysCreate: true)
enum RoomStatus {
  @JsonValue('open')
  open,
  @JsonValue('ongoing')
  ongoing,
  @JsonValue('closed')
  closed;

  String get label => switch (this) {
    RoomStatus.open => '모집 중',
    RoomStatus.ongoing => '진행 중',
    RoomStatus.closed => '종료',
  };
}

/// 지원하는 소셜 로그인 제공자. 서버 경로(`apiPath`)와 버튼 문구를 여기 응집시킨다.
/// 브랜드 색은 UI 관심사라 `AppColors` 에 둔다 — 모델은 색을 모른다.
@JsonEnum(alwaysCreate: true)
enum SocialProvider {
  @JsonValue('kakao')
  kakao,
  @JsonValue('naver')
  naver,
  @JsonValue('google')
  google,
  @JsonValue('apple')
  apple;

  /// `POST /auth/{apiPath}` 로 쓰인다.
  String get apiPath => name;

  String get label => switch (this) {
    SocialProvider.kakao => '카카오',
    SocialProvider.naver => '네이버',
    SocialProvider.google => 'Google',
    SocialProvider.apple => 'Apple',
  };

  String get buttonLabel => switch (this) {
    SocialProvider.kakao => '카카오로 시작하기',
    SocialProvider.naver => '네이버로 시작하기',
    SocialProvider.google => 'Google로 시작하기',
    SocialProvider.apple => 'Apple로 시작하기',
  };
}

/// 홈 화면 카테고리 칩. 방의 [RoomCategory] 가 `null` 이면 "전체"에서만 보인다.
@JsonEnum(alwaysCreate: true)
enum RoomCategory {
  @JsonValue('dance')
  dance,
  @JsonValue('workout')
  workout,
  @JsonValue('swim')
  swim;

  /// `GET /rooms?category={queryValue}` 로 쓰인다. "전체" 는 이 값 자체가 없는 상태로 표현한다
  /// (칩 목록엔 "전체" 가 맨 앞에 따로 붙는다 — Enum 멤버로 두면 서버로 보낼 값이 애매해진다).
  String get queryValue => name;

  String get label => switch (this) {
    RoomCategory.dance => '춤',
    RoomCategory.workout => '운동',
    RoomCategory.swim => '수영',
  };
}

/// 댓글이 달리는 대상 — 챌린지 원본 영상이거나 특정 제출 영상. 두 진입점(챌린지 상세의
/// "이 영상에 댓글" 행, 제출 영상 그리드의 댓글 배지)이 같은 댓글 바텀시트를 이 구분 하나로 공유한다.
@JsonEnum(alwaysCreate: true)
enum CommentTargetType {
  @JsonValue('challenge')
  challenge,
  @JsonValue('submission')
  submission;

  /// `/challenges/{id}/comments` 또는 `/submissions/{id}/comments` 조립에 쓴다.
  String get apiSegment => switch (this) {
    CommentTargetType.challenge => 'challenges',
    CommentTargetType.submission => 'submissions',
  };
}
