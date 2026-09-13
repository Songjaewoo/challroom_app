import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/auths.dart';
import '../models/enums.dart';
import '../models/users.dart';
import '../providers.dart';

part 'auth_controller.g.dart';

/// 로그인 상태. `null` 이면 로그아웃, 값이 있으면 로그인된 유저다.
///
/// 라우터가 이 상태를 보고 로그인 화면과 홈을 가른다 — 화면마다 로그인 체크를 넣지 않는다.
@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  @override
  Future<User?> build() async {
    final token = await ref.watch(tokenStorageProvider).readAccessToken();
    if (token == null) return null;

    return ref.watch(userRepositoryProvider).fetchMe();
  }

  /// 서버에서 유저 정보를 다시 불러온다. 프로필 수정처럼 다른 화면에서 유저가
  /// 바뀐 뒤 이 상태를 최신으로 맞출 때 쓴다 — 로컬에서 손으로 값을 채우지 않는다.
  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }

  /// 소셜 SDK 로 토큰을 받아 서버에 넘기고, 받은 앱 토큰을 저장한다.
  Future<void> signIn(SocialProvider provider) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final socialToken = await ref.read(socialAuthServiceProvider).obtainAccessToken(provider);

      final result = await ref.read(authRepositoryProvider).signIn(provider, SocialLoginReq(accessToken: socialToken));

      await ref
          .read(tokenStorageProvider)
          .saveTokens(accessToken: result.accessToken, refreshToken: result.refreshToken);

      return result.user;
    });
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      try {
        await ref.read(authRepositoryProvider).signOut();
      } finally {
        // 서버 호출이 실패해도 기기에서는 반드시 지운다.
        await ref.read(tokenStorageProvider).clear();
      }
      return null;
    });
  }
}
