import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 앱 색·타이포. 화면에서 색을 직접 만들지 않고 `Theme.of(context)` 로 받아 쓴다.
///
/// 이 앱은 다크 테마 하나만 쓴다 — 라이트/다크를 오가지 않는다.
/// `front_design/` 목업의 `--surface-1` 등 CSS 변수는 정의가 이 저장소에 없어(공용
/// 디자인 시스템에만 존재) 그대로 옮길 수 없었다. 대신 브랜드 색(`primary` `#FF4470`,
/// `success` `#00B894`)은 유지하고 중립색만 다크로 새로 짰다.
abstract final class AppColors {
  static const primary = Color(0xFFFF4470);
  static const primaryDark = Color(0xFFD62E56);
  static const primarySoft = Color(0xFF3A1B24);
  static const success = Color(0xFF00B894);
  static const successDark = Color(0xFF0F6E56);
  static const successSoft = Color(0xFF12271F);

  /// 카드·인풋 등 배경보다 한 단 올라온 면.
  static const accentSoft = Color(0xFF241C18);

  static const ink = Color(0xFFF5F1EC);
  static const inkMuted = Color(0xFF9C948A);
  static const inkFaint = Color(0xFF6E665E);

  /// 화면 배경 · AppBar · 카드 기본면.
  static const surface = Color(0xFF171310);
  static const border = Color(0xFF33291F);

  /// 브랜드 배경(카카오 노랑, 네이버 초록, 애플 검정) 위에 얹는 흰 글자·아이콘.
  /// `surface` 는 이제 어둡기 때문에 이 용도로는 쓸 수 없다 — 항상 고정 흰색이다.
  static const onBrand = Color(0xFFFFFFFF);

  // 로고 마크 — 겹친 카드 3장. 밝은 색이라 다크 배경에서도 그대로 쓴다.
  static const logoBack = Color(0xFFF5C4B3);
  static const logoMid = Color(0xFFF0997B);
  static const logoFront = primary;

  // 소셜 브랜드 색. 규정 색이라 테마와 무관하게 고정이다.
  static const kakao = Color(0xFFFEE500);
  static const kakaoInk = Color(0xFF3C1E1E);
  static const naver = Color(0xFF03C75A);
  static const apple = Color(0xFF000000);

  /// 실제 썸네일이 없을 때(홈 목록) 항목마다 순환해 쓰는 배경/강조 색 쌍.
  static const thumbnailBackgrounds = [Color(0xFF2A1D16), Color(0xFF12241D), Color(0xFF2A1620)];
  static const thumbnailAccents = [logoMid, success, Color(0xFFE88AA6)];

  /// 참여자 아바타 배지에 순환해 쓰는 색.
  static const avatarPalette = [primary, success, inkMuted, primaryDark, successDark];
}

abstract final class AppTheme {
  static ThemeData get dark {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
      primary: AppColors.primary,
      surface: AppColors.surface,
    );

    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.surface,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.ink,
        elevation: 0,
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.accentSoft,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
      ),
    );
  }
}
