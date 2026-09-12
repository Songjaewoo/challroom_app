import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/rooms.dart';
import '../providers.dart';
import 'home_controller.dart';
import 'my_rooms_controller.dart';

part 'create_room_controller.g.dart';

/// 방 만들기 화면의 제출 상태. 성공하면 만들어진 [Room] 을 들고 있다 — 화면이 이 값으로
/// 상세 화면 이동을 판단한다.
@riverpod
class CreateRoom extends _$CreateRoom {
  @override
  Future<Room?> build() async => null;

  Future<void> submit(RoomCreateReq req) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(roomRepositoryProvider).createRoom(req));

    if (state.hasValue) {
      // 새 방이 목록에 바로 보여야 한다 — 손으로 끼워 넣지 않고 다시 조회한다.
      ref.invalidate(roomListProvider);
      ref.invalidate(myRoomsProvider);
    }
  }
}
