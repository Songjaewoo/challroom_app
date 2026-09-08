import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

/// 닉네임마다 안정적으로 같은 색이 나오게 — 실제 유저 색상 데이터가 없을 때 쓴다.
Color avatarColorFor(String seed) {
  const palette = AppColors.avatarPalette;
  return palette[seed.hashCode.abs() % palette.length];
}

/// 실제 썸네일이 없을 때 목록 카드마다 순환해 쓰는 배경/강조 색.
({Color background, Color accent}) thumbnailStyleFor(int seed) {
  const backgrounds = AppColors.thumbnailBackgrounds;
  const accents = AppColors.thumbnailAccents;
  final index = seed % backgrounds.length;
  return (background: backgrounds[index], accent: accents[index]);
}
