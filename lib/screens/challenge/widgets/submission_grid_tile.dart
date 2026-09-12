import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../models/enums.dart';
import '../../../models/submissions.dart';
import '../../../shared/avatar_color.dart';
import '../../../shared/video_launcher.dart';
import '../../comments/comments_sheet.dart';

/// 제출된 영상 그리드 한 칸 — 세로 영상 비율(9:16), 제출자 닉네임 + 댓글 수 배지.
///
/// 탭 영역이 둘로 나뉜다 — 썸네일(재생 아이콘) 쪽은 영상을 재생하고, 댓글 배지는 재생 없이
/// 바로 댓글 시트를 연다. 영상이 브라우저로 열리든 네이티브로 열리든 댓글 배지의 동작은 같다.
class SubmissionGridTile extends StatelessWidget {
  const SubmissionGridTile({required this.submission, required this.colorIndex, super.key});

  final Submission submission;
  final int colorIndex;

  @override
  Widget build(BuildContext context) {
    final style = thumbnailStyleFor(colorIndex);

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: style.background, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => _play(context),
                child: Icon(Icons.play_arrow_rounded, size: 22, color: style.accent),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _Badge(text: submission.nickname, bold: true),
                InkWell(
                  borderRadius: BorderRadius.circular(6),
                  onTap: () => showCommentsSheet(
                    context,
                    target: (type: CommentTargetType.submission, id: submission.id),
                    title: '${submission.nickname}님 영상',
                  ),
                  child: _Badge(icon: Icons.chat_bubble_outline, text: '${submission.commentCount}'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _play(BuildContext context) {
    final assetPath = submission.assetPath;
    if (assetPath != null) {
      context.push(RoutePath.assetVideoPlayer, extra: (title: submission.nickname, assetPath: assetPath));
      return;
    }
    final url = submission.videoUrl;
    if (url != null) {
      unawaited(openVideoInAppBrowser(context, url));
    }
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.text, this.icon, this.bold = false});

  final String text;
  final IconData? icon;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[Icon(icon, size: 10, color: AppColors.ink), const SizedBox(width: 2)],
          Text(
            text,
            style: TextStyle(
              fontSize: icon == null ? 11 : 10,
              fontWeight: bold ? FontWeight.w500 : FontWeight.normal,
              color: AppColors.ink,
            ),
          ),
        ],
      ),
    );
  }
}
