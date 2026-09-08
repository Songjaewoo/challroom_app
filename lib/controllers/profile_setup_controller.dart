import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/users.dart';
import '../providers.dart';
import 'auth_controller.dart';

part 'profile_setup_controller.g.dart';

/// 최초 온보딩에서 닉네임·프로필 사진을 저장하는 액션 전용 Controller.
/// 조회할 초기 상태가 없어 `build()` 는 아무것도 하지 않는다 — 진행 상태만 [AsyncValue] 로 본다.
@riverpod
class ProfileSetup extends _$ProfileSetup {
  @override
  Future<void> build() async {}

  Future<void> submit({required String nickname, XFile? avatar}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      String? imageUrl;
      if (avatar != null) {
        imageUrl = await ref.read(userRepositoryProvider).uploadAvatar(avatar);
      }

      await ref
          .read(userRepositoryProvider)
          .updateProfile(ProfileUpdateReq(nickname: nickname, profileImageUrl: imageUrl));

      // authProvider 가 라우터의 판단 기준이다 — 여기서 갱신해야 화면 전환(redirect)이 따라온다.
      await ref.read(authProvider.notifier).refresh();
    });
  }
}
