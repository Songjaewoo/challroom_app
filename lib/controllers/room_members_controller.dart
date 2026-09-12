import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../providers.dart';
import 'room_detail_controller.dart';

part 'room_members_controller.g.dart';

/// 멤버 내보내기 액션 상태. 멤버 목록 자체는 [roomDetailProvider] 를 그대로 본다 —
/// 이 화면만을 위한 별도 조회는 두지 않는다.
@riverpod
class RoomMembers extends _$RoomMembers {
  @override
  Future<void> build(int roomId) async {}

  Future<void> removeMember(String nickname) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(roomRepositoryProvider).removeMember(roomId, nickname);
    });

    if (state.hasError) return;
    // 목록이 이 값을 그대로 보고 있으니, 내보낸 결과를 반영하려면 다시 불러와야 한다.
    ref.invalidate(roomDetailProvider(roomId));
  }
}
