import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/error/api_exception.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

void main() {
  // 앱 전체가 다크 테마 하나다. AppBar 가 없는 화면(로그인·스플래시)도 있어서
  // 상태 표시줄 아이콘 밝기를 여기서 한 번에 고정한다 — 화면마다 따로 안 챙긴다.
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

  runApp(
    ProviderScope(
      // Riverpod 3 은 초기화에 실패한 프로바이더를 지수 백오프로 무한 재시도한다.
      // 여기서 막지 않으면 영구히 실패하는 요청을 계속 두드린다.
      retry: (retryCount, error) {
        if (error is ApiException && error.statusCode < 500) return null;
        if (error is NetworkException) return null;
        if (retryCount >= 3) return null;
        return Duration(milliseconds: 200 * (1 << retryCount));
      },
      child: const App(),
    ),
  );
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(title: '챌룸', theme: AppTheme.dark, routerConfig: ref.watch(appRouterProvider));
  }
}
