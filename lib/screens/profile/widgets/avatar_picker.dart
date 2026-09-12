import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/theme/app_theme.dart';

/// 프로필 사진 원형 미리보기 + 카메라 배지. 순수 표시용 — 고르는 동작은 부모가 넘긴다.
class AvatarPicker extends StatelessWidget {
  const AvatarPicker({required this.image, this.existingImageUrl, required this.onTap, super.key});

  /// 로컬에서 새로 고른 파일. 아직 서버에 올리기 전이라 화면 로컬 상태로 들고 있는다.
  final XFile? image;

  /// [image] 를 새로 고르기 전까지 보여줄 기존 프로필 사진(편집 화면 전용). 온보딩에는 없다.
  final String? existingImageUrl;
  final VoidCallback? onTap;

  static const _size = 84.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: _size,
        height: _size + 4,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            ClipOval(
              child: Container(
                width: _size,
                height: _size,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  border: Border.all(color: AppColors.border),
                ),
                child: _buildImage(),
              ),
            ),
            Positioned(
              right: -2,
              bottom: -2,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.surface, width: 2),
                ),
                child: const Icon(Icons.camera_alt, size: 14, color: AppColors.onBrand),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (image != null) return Image.file(File(image!.path), fit: BoxFit.cover);
    if (existingImageUrl != null) return Image.network(existingImageUrl!, fit: BoxFit.cover);
    return const Icon(Icons.person_outline, size: 32, color: AppColors.inkMuted);
  }
}
