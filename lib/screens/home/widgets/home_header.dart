import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../shared/coming_soon.dart';
import '../../../shared/widgets/app_logo_mark.dart';

/// 로고 · 앱 이름 · 알림/검색. 홈 탭 전용이라 Scaffold 의 AppBar 대신 콘텐츠 맨 위에 둔다.
class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 12, 10, 6),
      child: Row(
        children: [
          const AppLogoMark(size: 30),
          const SizedBox(width: 8),
          Text(
            '챌룸',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500, color: AppColors.ink),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => showComingSoon(context, '알림'),
            icon: const Icon(Icons.notifications_outlined, color: AppColors.inkMuted),
          ),
          IconButton(
            onPressed: () => showComingSoon(context, '검색'),
            icon: const Icon(Icons.search, color: AppColors.inkMuted),
          ),
        ],
      ),
    );
  }
}
