import '../../models/notifications.dart';
import '../../repositories/notification_repository.dart';

/// `API_BASE_URL` 이 없을 때(지금 상태) 알림함을 미리 보기 위한 샘플 데이터 — 케이스마다
/// 하나씩 심어뒀다. 방장 신청 수락([RoomApplicantsController.accept])처럼 이 세션 안에서
/// 실제로 일어난 일은 [add] 로 그 위에 새로 쌓인다.
///
/// 방 만들기와 마찬가지로 상태가 있어서 `keepAlive` 로 등록한다(`providers.dart` 참고).
class LocalNotificationRepository implements NotificationRepository {
  LocalNotificationRepository() : _notifications = _seed();

  final List<AppNotification> _notifications;
  var _nextId = 100;

  static List<AppNotification> _seed() {
    final now = DateTime.now();
    return [
      AppNotification(
        id: 1,
        kind: NotificationKind.applicantReceived,
        message: '유진님이 \'우리끼리 텐션 챌린지\' 방에 참가 신청을 보냈어요.',
        createdAt: now.subtract(const Duration(minutes: 20)),
        roomId: -1,
      ),
      AppNotification(
        id: 2,
        kind: NotificationKind.comment,
        message: '민지님이 내 영상에 댓글을 남겼어요: "완전 웃기다 ㅋㅋ 나도 찍어볼래"',
        createdAt: now.subtract(const Duration(hours: 3)),
        roomId: -1,
      ),
      AppNotification(
        id: 3,
        kind: NotificationKind.memberJoined,
        message: '지수님이 \'눈빛 승부 한판 붙자\' 방에 들어왔어요.',
        createdAt: now.subtract(const Duration(hours: 6)),
        roomId: -2,
        isRead: true,
      ),
      AppNotification(
        id: 4,
        kind: NotificationKind.applicationAccepted,
        message: '\'오늘 기분 한마디\' 방장이 참가 신청을 수락했어요. 함께해요!',
        createdAt: now.subtract(const Duration(days: 1)),
        roomId: -3,
        isRead: true,
      ),
      AppNotification(
        id: 5,
        kind: NotificationKind.applicationRejected,
        message: '\'눈빛 승부 한판 붙자\' 방장이 참가 신청을 거절했어요.',
        createdAt: now.subtract(const Duration(days: 1, hours: 4)),
        roomId: -2,
        isRead: true,
      ),
      AppNotification(
        id: 6,
        kind: NotificationKind.challengeAdded,
        message: '\'우리끼리 텐션 챌린지\'에 새 챌린지가 추가됐어요: 오늘 기분 한마디',
        createdAt: now.subtract(const Duration(days: 3)),
        roomId: -1,
        isRead: true,
      ),
    ];
  }

  @override
  Future<List<AppNotification>> fetchNotifications() async =>
      [..._notifications]..sort((a, b) => b.createdAt.compareTo(a.createdAt));

  @override
  Future<void> markAllRead() async {
    for (var i = 0; i < _notifications.length; i++) {
      _notifications[i] = _notifications[i].copyWith(isRead: true);
    }
  }

  @override
  Future<void> add({required NotificationKind kind, required String message, int? roomId}) async {
    _notifications.add(
      AppNotification(id: _nextId++, kind: kind, message: message, createdAt: DateTime.now(), roomId: roomId),
    );
  }
}
