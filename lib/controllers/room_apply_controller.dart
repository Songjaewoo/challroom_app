import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'home_controller.dart';
import 'my_rooms_controller.dart';
import '../providers.dart';

part 'room_apply_controller.g.dart';

/// "신청"/"신청취소" 배지의 액션 상태 — 방 하나당 하나. 성공하면 홈 목록과 "내 방" 목록을
/// 둘 다 다시 불러와 배지가 즉시 바뀌도록 한다.
@riverpod
class RoomApply extends _$RoomApply {
  @override
  Future<void> build(int roomId) async {}

  Future<void> apply() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(roomRepositoryProvider).applyToRoom(roomId));
    if (state.hasError) return;
    _refreshRoomLists();
  }

  Future<void> cancel() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(roomRepositoryProvider).cancelApplication(roomId));
    if (state.hasError) return;
    _refreshRoomLists();
  }

  void _refreshRoomLists() {
    ref.invalidate(roomListProvider);
    ref.invalidate(myRoomsProvider);
  }
}
