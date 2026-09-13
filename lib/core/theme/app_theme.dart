import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 앱 색·타이포. 화면에서 색을 직접 만들지 않고 `Theme.of(context)` 로 받아 쓴다.
///
/// 이 앱은 다크 테마 하나만 쓴다 — 라이트/다크를 오가지 않는다.
///
/// "Bold Social" 톤 — 배경을 순수 블랙에 가깝게 낮추고, 카드는 테두리 대신 한 단 밝은
/// 면 색(`accentSoft`)으로만 구분한다. 브랜드 색은 로고 3색(살구 `logoBack` · 코랄
/// `logoMid` · 핑크 `logoFront`=`primary`)을 그대로 쓴다 — 새 포인트 색을 더하지 않았다.
abstract final class AppColors {
  static const primary = Color(0xFFFF4470);
  static const primaryDark = Color(0xFFD62E56);
  static const primarySoft = Color(0xFF3A1B24);
  static const success = Color(0xFF00B894);
  static const successDark = Color(0xFF0F6E56);
  static const successSoft = Color(0xFF12271F);

  /// 되돌리기 애매한 부정적 액션(내보내기, 신청 거절 등) 확인 버튼 전용 — 브랜드 핑크는
  /// "진행형 CTA" 로 자리가 정해져 있어서, 남에게 영향을 주는 거절/제거 액션에 그대로 쓰면
  /// "좋은 일이 벌어진다"는 신호처럼 헷갈린다. 로고 계열과 구분되는 레드 계열을 따로 둔다.
  static const danger = Color(0xFFFF5252);

  /// 카드·칩·인풋 등 배경보다 한 단 올라온 면 — 카드 테두리 대신 이 색으로 배경과 구분한다.
  static const accentSoft = Color(0xFF18181D);

  static const ink = Color(0xFFFFFFFF);
  static const inkMuted = Color(0xFF9A9AA5);
  static const inkFaint = Color(0xFF5C5C66);

  /// 화면 배경 · AppBar 기본면 — 카드가 도드라지도록 순수 블랙에 가깝게.
  static const surface = Color(0xFF0A0A0D);

  /// 꼭 필요한 구분선(칩 사이 divider 등)에만 쓴다 — 카드 테두리에는 안 쓴다.
  static const border = Color(0xFF232329);

  /// 브랜드 배경(카카오 노랑, 네이버 초록, 애플 검정) 위에 얹는 흰 글자·아이콘.
  /// `surface` 는 이제 어둡기 때문에 이 용도로는 쓸 수 없다 — 항상 고정 흰색이다.
  static const onBrand = Color(0xFFFFFFFF);

  // 로고 마크 — 겹친 카드 3장. 밝은 색이라 다크 배경에서도 그대로 쓴다.
  //
  // 카테고리 구분색으로는 안 쓴다(방/칩마다 색이 다르면 오히려 헷갈린다는 피드백이 있었다) —
  // 대신 "버튼의 역할"을 셋으로 나눠 쓴다:
  //   - logoFront(핑크, `primary`) : 진행형 CTA — 다음/저장/방 만들기/입장하기/신청.
  //   - logoMid(코랄)              : 생성·추가 액션 — PICK "+", 영상 추가, 제출, 코드 만들기.
  //   - logoBack(살구)             : 가벼운 보조 액션 — 복사하기, 새로고침류.
  static const logoBack = Color(0xFFF5C4B3);
  static const logoMid = Color(0xFFF0997B);
  static const logoFront = primary;

  /// 로고 3색 대각선 그라데이션 — [ThumbnailFrame] 이 영상 썸네일 자리를 감싸는 링에 쓴다.
  /// 썸네일 안쪽(실제 이미지가 들어갈 자리)은 이 색을 쓰지 않는다 — 이미지를 가리면 안 되니까.
  static const logoGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [logoFront, logoMid, logoBack],
  );

  // 소셜 브랜드 색. 규정 색이라 테마와 무관하게 고정이다.
  static const kakao = Color(0xFFFEE500);
  static const kakaoInk = Color(0xFF3C1E1E);
  static const naver = Color(0xFF03C75A);
  static const apple = Color(0xFF000000);

  /// 실제 썸네일 이미지가 없을 때(지금은 항상) 쓰는 자리 표시자 색 — 중립 톤이다.
  /// 예전엔 이 자리에 브랜드 색을 칠했지만, 실제 영상 썸네일이 들어갈 자리라 브랜드
  /// 색은 [ThumbnailFrame] 의 링으로 옮기고 안쪽은 항상 중립으로 둔다.
  static const thumbnailBackgrounds = [Color(0xFF2A2A31), Color(0xFF232329), Color(0xFF2C2C33)];
  static const thumbnailAccents = [Color(0x99FFFFFF), Color(0x99FFFFFF), Color(0x99FFFFFF)];

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
      // Material 기본 리플(탭 지점에서 번지는 원형 물결)을 끈다 — 버튼 누를 때 그 효과가
      // "머티리얼 느낌"의 대표 격이라 뺐다. 살짝 어두워지는 오버레이 정도만 남는다.
      splashFactory: NoSplash.splashFactory,
      // 한글·영문·숫자 전부 프리텐다드로 — 시스템 기본 서체 대신 앱 전체에 하나로 적용한다.
      fontFamily: 'Pretendard',
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
          // `ColorScheme.fromSeed` 가 이 핑크에 맞춰 자동으로 고른 onPrimary 가 흰색이 아니라
          // 탁한 색이라 글자가 어색해 보였다 — 다른 곳처럼 고정 흰색을 명시한다.
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onBrand,
          disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.4),
          disabledForegroundColor: AppColors.onBrand.withValues(alpha: 0.7),
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.accentSoft,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
        // 힌트 텍스트 기본색 — 지정 안 하면 컬러스킴이 골라주는 색이 너무 밝아 입력 글자와
        // 잘 구분이 안 됐다. 필드별로 따로 정해둔 곳(해시태그 입력 등)은 이 값을 그대로 덮는다.
        hintStyle: const TextStyle(color: AppColors.inkFaint),
      ),
      // 기본 스낵바(화면 폭 꽉 채운 회색 막대)는 안 쓴다 — 카드 한 장처럼 살짝 띄워서 보여준다.
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.accentSoft,
        contentTextStyle: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w500, color: AppColors.ink),
        behavior: SnackBarBehavior.floating,
        elevation: 6,
        insetPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        actionTextColor: AppColors.logoMid,
      ),
    );
  }
}
