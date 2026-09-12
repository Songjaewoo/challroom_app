import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/rooms.dart';
import '../providers.dart';
import 'room_detail_controller.dart';

part 'room_edit_controller.g.dart';

/// 방 정보 수정 화면의 저장 상태. 화면 자체는 [RoomEditScreen] 에 넘어온 [RoomDetail] 값으로
/// 미리 채워지니, 여기선 조회 없이 제출만 다룬다.
@riverpod
class RoomEdit extends _$RoomEdit {
  @override
  Future<void> build(int roomId) async {}

  Future<void> submit(RoomUpdateReq req) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(roomRepositoryProvider).updateRoom(roomId, req));

    if (state.hasError) return;
    // 방 상세(그리고 그 화면이 보여주는 제목/해시태그)를 다시 불러와 반영한다.
    ref.invalidate(roomDetailProvider(roomId));
  }
}
