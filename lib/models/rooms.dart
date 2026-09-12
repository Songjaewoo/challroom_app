import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';
import 'submissions.dart';

part 'rooms.freezed.dart';
part 'rooms.g.dart';

@freezed
abstract class Room with _$Room {
  const factory Room({
    required int id,
    required String title,
    @Default(<String>[]) List<String> hashtags,

    /// 목록 카드에 겹쳐 보여줄 몇 명 — 전체 참여자가 아니다. 인원수는 [participantCount] 를 본다.
    @Default(<ParticipantInfo>[]) List<ParticipantInfo> participants,
    required int participantCount,
    required RoomStatus status,

    /// 어느 칩에도 안 묶이는 방일 수 있다 — 그러면 "전체"에서만 보인다.
    RoomCategory? category,
    String? thumbnailUrl,
  }) = _Room;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
}

/// 방 만들기 화면에서 서버로 보내는 값.
@freezed
abstract class RoomCreateReq with _$RoomCreateReq {
  const factory RoomCreateReq({
    required String title,
    @Default(<String>[]) List<String> hashtags,
    @Default(true) bool isPublic,

    /// "이번 주 챌룸 PICK" 에서 골라 시작한 경우 그 영상 id — 직접 만들면 `null`.
    int? pickVideoId,
  }) = _RoomCreateReq;

  factory RoomCreateReq.fromJson(Map<String, dynamic> json) => _$RoomCreateReqFromJson(json);
}

/// 방 정보 수정 화면에서 서버로 보내는 값 — [RoomCreateReq] 와 필드는 같지만 영상은 나중에
/// 바꿀 수 없어 `pickVideoId` 가 없다.
@freezed
abstract class RoomUpdateReq with _$RoomUpdateReq {
  const factory RoomUpdateReq({
    required String title,
    @Default(<String>[]) List<String> hashtags,
    @Default(true) bool isPublic,
  }) = _RoomUpdateReq;

  factory RoomUpdateReq.fromJson(Map<String, dynamic> json) => _$RoomUpdateReqFromJson(json);
}

@freezed
abstract class ParticipantInfo with _$ParticipantInfo {
  const factory ParticipantInfo({
    required String nickname,
    String? profileImageUrl,

    /// 이 방의 방장이면 `true`. [RoomMembersScreen] 이 "방장" 배지를 붙이는 데 쓴다.
    @Default(false) bool isOwner,
  }) = _ParticipantInfo;

  factory ParticipantInfo.fromJson(Map<String, dynamic> json) => _$ParticipantInfoFromJson(json);
}

/// 방 상세 화면 전용 — 목록 카드([Room])보다 무거운 정보(멤버 전원, 챌린지 영상들)를 담는다.
@freezed
abstract class RoomDetail with _$RoomDetail {
  const factory RoomDetail({
    required int id,
    required String title,
    @Default(<String>[]) List<String> hashtags,
    @Default(true) bool isPublic,
    @Default(<ParticipantInfo>[]) List<ParticipantInfo> members,
    required int memberCount,
    @Default(<RoomChallenge>[]) List<RoomChallenge> challenges,

    /// 로그인한 유저가 이 방의 방장이면 `true` — 멤버 관리(내보내기 등) UI 노출 여부를 가른다.
    @Default(false) bool isOwnedByMe,

    /// 방장이 발급한 초대 코드 — 아직 안 만들었으면 `null`. [RoomInviteScreen] 이 보여준다.
    String? inviteCode,
  }) = _RoomDetail;

  factory RoomDetail.fromJson(Map<String, dynamic> json) => _$RoomDetailFromJson(json);
}

/// 방 안에 올라온 챌린지 영상 하나 — 제출 현황을 함께 들고 있다.
@freezed
abstract class RoomChallenge with _$RoomChallenge {
  const factory RoomChallenge({
    required int id,
    required String title,

    /// "YouTube Shorts" 같은 출처 표기.
    required String source,
    required int submittedCount,
    required int totalCount,
    String? thumbnailUrl,
  }) = _RoomChallenge;

  factory RoomChallenge.fromJson(Map<String, dynamic> json) => _$RoomChallengeFromJson(json);
}

/// 챌린지 영상 상세 — 원본 영상 + 그 영상에 달린 [Submission] 목록.
/// 목록 카드([RoomChallenge])를 탭하면 재생이 아니라 이 화면으로 간다.
@freezed
abstract class ChallengeDetail with _$ChallengeDetail {
  const factory ChallengeDetail({
    required int id,
    required String title,

    /// "YouTube Shorts" 같은 출처 표기.
    required String source,

    /// 방장이 처음 올린 원본(대표) 영상 — 있으면 재생할 수 있다.
    String? videoUrl,
    String? assetPath,
    required int totalCount,
    @Default(<Submission>[]) List<Submission> submissions,

    /// 원본 영상에 달린 댓글 수. 제출 영상 각각의 댓글 수는 [Submission.commentCount] 를 본다.
    @Default(0) int commentCount,
  }) = _ChallengeDetail;

  factory ChallengeDetail.fromJson(Map<String, dynamic> json) => _$ChallengeDetailFromJson(json);
}
