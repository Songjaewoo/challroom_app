import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_theme.dart';
import '../../../models/enums.dart';

/// 소셜 로그인 버튼 하나. 브랜드 규정 색·마크라 테마 색을 쓰지 않고 고정값을 쓴다.
///
/// 마크는 `assets/icons/{provider.name}.svg` 를 그대로 그린다 — 브랜드 아이콘은
/// 색을 덧입히면 안 되므로(구글 로고는 4색) SVG 자체 색을 그대로 쓴다.
class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({required this.provider, required this.onPressed, this.isLoading = false, super.key});

  final SocialProvider provider;

  /// `null` 이면 비활성 — 다른 로그인이 진행 중일 때 넘긴다.
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final style = _Style.of(provider);

    return SizedBox(
      height: 52,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: style.background,
          foregroundColor: style.foreground,
          disabledBackgroundColor: style.background.withValues(alpha: 0.4),
          disabledForegroundColor: style.foreground.withValues(alpha: 0.4),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
            side: style.border == null ? BorderSide.none : BorderSide(color: style.border!),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 21,
              height: 21,
              child: isLoading
                  ? CircularProgressIndicator(strokeWidth: 2, color: style.foreground)
                  : SvgPicture.asset('assets/icons/${provider.name}.svg'),
            ),
            const SizedBox(width: 8),
            Text(provider.buttonLabel),
          ],
        ),
      ),
    );
  }
}

class _Style {
  const _Style({required this.background, required this.foreground, this.border});

  final Color background;
  final Color foreground;
  final Color? border;

  static _Style of(SocialProvider provider) => switch (provider) {
    SocialProvider.kakao => const _Style(background: AppColors.kakao, foreground: AppColors.kakaoInk),
    SocialProvider.naver => const _Style(background: AppColors.naver, foreground: AppColors.onBrand),
    SocialProvider.google => const _Style(
      background: AppColors.surface,
      foreground: AppColors.ink,
      border: AppColors.border,
    ),
    // 다크 배경(#171310)과 애플 브랜드 검정이 거의 붙어 경계가 안 보인다 — 얇은 테두리로 나눈다.
    SocialProvider.apple => const _Style(
      background: AppColors.apple,
      foreground: AppColors.onBrand,
      border: AppColors.border,
    ),
  };
}
