/// 신고 대상 — 챌린지 원본 영상이든 누가 제출한 영상이든 신고 흐름은 똑같다.
/// [CommentTargetType] 과 모양은 같지만, 이 앱에서 신고는 그 어떤 모델에도 저장돼 보이지
/// 않는 "보내고 끝"인 값이라(json_serializable 이 필요한 freezed 필드가 없다) 평범한
/// enum 으로 둔다 — 앞으로 신고 대상이 늘어날 수도 있어(방, 유저 등) 따로 정의한다.
enum ReportTargetType {
  challenge,
  submission;

  /// `POST /reports` 바디에 그대로 실린다.
  String get apiValue => name;
}

/// [ReportScreen] 을 열 때 넘기는 값 — 대상과 화면에 보여줄 이름만 있으면 된다.
typedef ReportTarget = ({ReportTargetType type, int id});

/// 신고 사유 — 목록에서 하나만 고른다.
enum ReportReason {
  spam,
  violence,
  sexual,
  copyright,
  misinformation,
  other;

  /// `POST /reports` 바디에 그대로 실린다.
  String get apiValue => name;

  String get label => switch (this) {
    ReportReason.spam => '스팸 또는 광고',
    ReportReason.violence => '폭력적이거나 혐오스러운 콘텐츠',
    ReportReason.sexual => '성적인 콘텐츠',
    ReportReason.copyright => '저작권 침해',
    ReportReason.misinformation => '허위 정보',
    ReportReason.other => '기타',
  };
}
