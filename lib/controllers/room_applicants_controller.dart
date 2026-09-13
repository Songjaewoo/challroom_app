import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/notifications.dart';
import '../providers.dart';
import 'notifications_controller.dart';
import 'room_detail_controller.dart';

part 'room_applicants_controller.g.dart';

/// 신청 수락/거절 액션 상태 — 신청자 목록 자체는 [roomDetailProvider] 의
/// `pendingApplicants` 를 그대로 본다. [RoomMembersController] 와 같은 패턴.
@riverpod
class RoomApplicants extends _$RoomApplicants {
  @override
  Future<void> build(int roomId) async {}

  Future<void> accept(String nickname) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(roomRepositoryProvider).acceptApplicant(roomId, nickname);
    });

    if (state.hasError) return;

    // 방금 실제로 일어난 일이니 알림함에도 남긴다 — "OO님이 'X' 방에 들어왔어요" 케이스.
    final roomTitle = ref.read(roomDetailProvider(roomId)).value?.title;
    if (roomTitle != null) {
      await ref.read(notificationRepositoryProvider)
          .add(kind: NotificationKind.memberJoined, message: "$nickname님이 '$roomTitle' 방에 들어왔어요.", roomId: roomId);
      ref.invalidate(notificationsProvider);
      ref.invalidate(unreadNotificationCountProvider);
    }

    ref.invalidate(roomDetailProvider(roomId));
  }

  Future<void> reject(String nickname) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(roomRepositoryProvider).rejectApplicant(roomId, nickname);
    });

    if (state.hasError) return;
    ref.invalidate(roomDetailProvider(roomId));
  }
}
