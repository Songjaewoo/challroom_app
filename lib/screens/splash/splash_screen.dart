import 'package:flutter/material.dart';

import '../../shared/widgets/app_logo_mark.dart';

/// 저장된 토큰으로 로그인 상태를 확인하는 동안 잠깐 보이는 화면.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppLogoMark(),
            SizedBox(height: 32),
            SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2)),
          ],
        ),
      ),
    );
  }
}
