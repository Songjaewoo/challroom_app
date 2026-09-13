import 'package:freezed_annotation/freezed_annotation.dart';

part 'notifications.freezed.dart';
part 'notifications.g.dart';

/// 알림함에 뜨는 케이스 — 종류마다 아이콘·톤·문구가 다르다. 새 케이스가 생기면 여기 추가하고
/// [NotificationsScreen] 의 아이콘/색 매핑에도 짝을 맞춰준다.
@JsonEnum(alwaysCreate: true)
enum NotificationKind {
  /// 남이 내 방에 참가 신청을 보냈을 때(방장 시점). "OO님이 'X' 방에 참가 신청을 보냈어요."
  @JsonValue('applicant_received')
  applicantReceived,

  /// 내가 보낸 신청이 수락됐을 때(신청자 시점). "'X' 방장이 참가 신청을 수락했어요. 함께해요!"
  @JsonValue('application_accepted')
  applicationAccepted,

  /// 내가 보낸 신청이 거절됐을 때(신청자 시점). "'X' 방장이 참가 신청을 거절했어요."
  @JsonValue('application_rejected')
  applicationRejected,

  /// 내가 올린 영상에 댓글이 달렸을 때. "OO님이 내 영상에 댓글을 남겼어요: "..."
  @JsonValue('comment')
  comment,

  /// 내 방에 새 멤버가 들어왔을 때(초대 코드로 참여, 신청 수락 등). "OO님이 'X' 방에 들어왔어요."
  @JsonValue('member_joined')
  memberJoined,

  /// 내가 속한 방에 새 챌린지 영상이 올라왔을 때. "'X'에 새 챌린지가 추가됐어요."
  @JsonValue('challenge_added')
  challengeAdded,
}

/// 알림함 항목 하나.
@freezed
abstract class AppNotification with _$AppNotification {
  const factory AppNotification({
    required int id,
    required NotificationKind kind,
    required String message,
    required DateTime createdAt,
    @Default(false) bool isRead,

    /// 탭했을 때 이동할 방 — 없으면(예: 시스템 공지성 알림) 탭해도 안 움직인다.
    int? roomId,
  }) = _AppNotification;

  factory AppNotification.fromJson(Map<String, dynamic> json) => _$AppNotificationFromJson(json);
}
