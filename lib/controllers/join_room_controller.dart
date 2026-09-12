import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/rooms.dart';
import '../providers.dart';
import 'my_rooms_controller.dart';

part 'join_room_controller.g.dart';

/// 초대 코드 입력 화면의 제출 상태. 성공하면 들어간 [Room] 을 들고 있다 — 화면이 이 값(널
/// 아님)으로 방 상세 이동을 판단한다. `build()` 가 처음에도 `null` 을 내놓으니, 화면은
/// "값이 있을 때" 만 이동으로 본다 — 열리자마자 이동해버리는 걸 막는다.
@riverpod
class JoinRoom extends _$JoinRoom {
  @override
  Future<Room?> build() async => null;

  Future<void> submit(String code) async {
    final trimmed = code.trim();
    if (trimmed.isEmpty) return;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(roomRepositoryProvider).joinRoomByCode(trimmed));

    if (state.hasValue) {
      // 새로 들어간 방이 "내 방" 목록에 바로 보여야 한다.
      ref.invalidate(myRoomsProvider);
    }
  }
}
