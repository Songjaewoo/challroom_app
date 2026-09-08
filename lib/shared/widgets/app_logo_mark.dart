import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

/// 겹친 카드 3장으로 된 앱 로고. 로그인·스플래시가 함께 쓴다.
class AppLogoMark extends StatelessWidget {
  const AppLogoMark({this.size = 110, super.key});

  /// 마크의 가로 크기. 세로는 비율(76:60)로 따라간다.
  final double size;

  @override
  Widget build(BuildContext context) {
    final unit = size / 76; // 디자인 원본 폭이 76 이다.

    return SizedBox(
      width: size,
      height: 60 * unit,
      child: Stack(
        children: [
          _card(unit, left: 0, top: 6, height: 46, color: AppColors.logoBack),
          _card(unit, left: 21, top: 0, height: 52, color: AppColors.logoMid),
          _card(unit, left: 42, top: 3, height: 48, color: AppColors.logoFront),
        ],
      ),
    );
  }

  Widget _card(double unit, {required double left, required double top, required double height, required Color color}) {
    return Positioned(
      left: left * unit,
      top: top * unit,
      child: Container(
        width: 34 * unit,
        height: height * unit,
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10 * unit)),
      ),
    );
  }
}
