import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../controllers/auth_controller.dart';
import '../../screens/auth/login_screen.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/profile/profile_setup_screen.dart';
import '../../screens/splash/splash_screen.dart';

part 'app_router.g.dart';

/// 경로 문자열은 전부 여기 모은다. 화면에서 `'/rooms/3'` 처럼 직접 쓰지 않는다.
abstract final class RoutePath {
  static const splash = '/splash';
  static const login = '/login';
  static const profileSetup = '/profile-setup';
  static const home = '/';
}

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  // 로그인 상태가 바뀔 때마다 redirect 를 다시 태운다.
  // 라우터 자체를 다시 만들면 내비게이션 스택이 날아가므로 watch 로 재생성하지 않는다.
  final refresh = ValueNotifier(0);
  ref.listen(authProvider, (_, _) => refresh.value++);
  ref.onDispose(refresh.dispose);

  return GoRouter(
    initialLocation: RoutePath.splash,
    refreshListenable: refresh,
    // 인증 분기는 여기 한 곳에서만 한다. 화면마다 로그인 체크를 넣지 않는다.
    redirect: (context, state) {
      final auth = ref.read(authProvider);
      final location = state.matchedLocation;

      // 저장된 토큰을 확인하는 중 — 스플래시에 머문다.
      if (auth.isLoading) return location == RoutePath.splash ? null : RoutePath.splash;

      // Riverpod 3 에서 nullable 접근자는 `value` 다 (`valueOrNull` 은 없어졌다).
      final user = auth.value;
      if (user == null) return location == RoutePath.login ? null : RoutePath.login;

      // 닉네임이 없는 신규 유저는 프로필부터 채운다.
      final needsProfile = user.nickname == null || user.nickname!.isEmpty;
      if (needsProfile) return location == RoutePath.profileSetup ? null : RoutePath.profileSetup;

      final atEntry = location == RoutePath.login || location == RoutePath.splash || location == RoutePath.profileSetup;
      return atEntry ? RoutePath.home : null;
    },
    routes: [
      GoRoute(path: RoutePath.splash, builder: (_, _) => const SplashScreen()),
      GoRoute(path: RoutePath.login, builder: (_, _) => const LoginScreen()),
      GoRoute(path: RoutePath.profileSetup, builder: (_, _) => const ProfileSetupScreen()),
      GoRoute(path: RoutePath.home, builder: (_, _) => const HomeScreen()),
    ],
  );
}
