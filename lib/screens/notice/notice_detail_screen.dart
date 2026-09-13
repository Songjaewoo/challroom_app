import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../models/notices.dart';

/// 공지사항 상세 — 목록에서 이미 불러온 [notice] 를 그대로 받아 보여준다(다시 조회하지 않는다).
class NoticeDetailScreen extends StatelessWidget {
  const NoticeDetailScreen({required this.notice, super.key});

  final Notice notice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (notice.isPinned) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: AppColors.primarySoft, borderRadius: BorderRadius.circular(6)),
                  child: const Text('공지', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppColors.primary)),
                ),
                const SizedBox(height: 10),
              ],
              Text(
                notice.title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.ink, height: 1.35),
              ),
              const SizedBox(height: 8),
              Text(_formatDate(notice.createdAt), style: const TextStyle(fontSize: 13.5, color: AppColors.inkFaint)),
              const SizedBox(height: 20),
              const Divider(height: 1, color: AppColors.border),
              const SizedBox(height: 20),
              Text(
                notice.content,
                style: const TextStyle(fontSize: 15.5, color: AppColors.ink, height: 1.6),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) =>
      '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';
}
