import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/notifications.dart';
import '../providers.dart';

part 'notifications_controller.g.dart';

@riverpod
Future<List<AppNotification>> notifications(Ref ref) {
  return ref.watch(notificationRepositoryProvider).fetchNotifications();
}

/// 벨 아이콘 배지 숫자 — [notificationsProvider] 를 그대로 보고 안 읽은 것만 센다.
/// 화면 하나만을 위한 값이라 따로 조회하지 않는다.
@riverpod
Future<int> unreadNotificationCount(Ref ref) async {
  final list = await ref.watch(notificationsProvider.future);
  return list.where((n) => !n.isRead).length;
}

/// 알림함 화면에 들어가면 전부 읽음 처리한다.
@riverpod
class NotificationsRead extends _$NotificationsRead {
  @override
  Future<void> build() async {}

  Future<void> markAllRead() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(notificationRepositoryProvider).markAllRead());

    if (state.hasError) return;
    ref.invalidate(notificationsProvider);
    ref.invalidate(unreadNotificationCountProvider);
  }
}
