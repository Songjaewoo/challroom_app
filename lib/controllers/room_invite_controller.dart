import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../providers.dart';
import 'room_detail_controller.dart';

part 'room_invite_controller.g.dart';

/// 초대 코드 "생성해줘" 요청 상태. 코드 값 자체는 [roomDetailProvider] 의
/// `inviteCode` 에서 본다 — 이 컨트롤러는 생성 액션과 로딩/에러만 다룬다.
@riverpod
class RoomInvite extends _$RoomInvite {
  @override
  Future<void> build(int roomId) async {}

  Future<void> generate() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(roomRepositoryProvider).createInviteCode(roomId));

    if (state.hasError) return;
    ref.invalidate(roomDetailProvider(roomId));
  }
}
