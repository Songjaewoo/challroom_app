import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';

import 'core/error/api_exception.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 카카오 로그인(kakao_flutter_sdk_user) — 네이티브 앱 키는 카카오 디벨로퍼스 콘솔에서
  // 발급받은 값. 네이버와 달리 이 키는 Info.plist 가 아니라 Dart 쪽 초기화 호출로 넘긴다.
  await KakaoSdk.init(nativeAppKey: '8813953927571385b7c30e936fbdec01');

  // 구글 로그인(google_sign_in) — iOS 클라이언트 ID. `initialize` 가 끝나기 전에 다른
  // GoogleSignIn 메서드를 부르면 안 된다는 게 패키지 쪽 요구사항이라 여기서 await 한다.
  await GoogleSignIn.instance.initialize(
    clientId: '603788464132-d7fdoeg75a5ih3nu4ipgk0okd10jie5s.apps.googleusercontent.com',
  );

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
