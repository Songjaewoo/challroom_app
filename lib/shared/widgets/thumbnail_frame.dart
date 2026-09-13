import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

/// 영상 썸네일이 들어가는 자리를 감싸는 얇은 로고색 링. 안쪽(`child`)은 절대 브랜드 색으로
/// 칠하지 않는다 — 실제 영상 썸네일 이미지가 들어올 자리라, 색을 칠하면 이미지를 가리게 된다.
/// "Bold Social" 톤에서 브랜드 색은 이 링 하나로만 존재감을 낸다.
///
/// 전체 크기(`width`/`height`)는 프레임이 갖고, 안쪽 `child`는 그 크기를 그대로 채운다 —
/// 기존 썸네일 컨테이너에서 크기 지정만 이쪽으로 옮기면 된다.
class ThumbnailFrame extends StatelessWidget {
  const ThumbnailFrame({required this.child, this.width, this.height, this.radius = 12, this.ringWidth = 2, super.key});

  final Widget child;
  final double? width;
  final double? height;
  final double radius;
  final double ringWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(ringWidth),
      decoration: BoxDecoration(gradient: AppColors.logoGradient, borderRadius: BorderRadius.circular(radius)),
      child: ClipRRect(borderRadius: BorderRadius.circular(radius - ringWidth), child: child),
    );
  }
}
