import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../shared/avatar_color.dart';

/// 설정 화면 맨 위 — 닉네임/프로필 사진 요약. 탭하면 프로필 편집으로 들어간다.
class SettingsProfileCard extends StatelessWidget {
  const SettingsProfileCard({required this.nickname, required this.onTap, super.key});

  final String nickname;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: AppColors.accentSoft, borderRadius: BorderRadius.circular(14)),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: avatarColorFor(nickname),
              child: Text(
                nickname.substring(0, 1),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.onBrand),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nickname,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.ink),
                  ),
                  const SizedBox(height: 2),
                  const Text('닉네임 · 프로필 사진 변경', style: TextStyle(fontSize: 13.5, color: AppColors.inkMuted)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, size: 20, color: AppColors.inkFaint),
          ],
        ),
      ),
    );
  }
}
