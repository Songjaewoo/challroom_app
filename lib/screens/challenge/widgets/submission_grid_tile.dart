import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../controllers/challenge_like_controller.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../models/enums.dart';
import '../../../models/reports.dart';
import '../../../models/submissions.dart';
import '../../../shared/avatar_color.dart';
import '../../../shared/video_launcher.dart';
import '../../../shared/widgets/thumbnail_frame.dart';
import '../../comments/comments_sheet.dart';

/// 제출된 영상 그리드 한 칸 — 세로 영상 비율(9:16), 제출자 닉네임 + 좋아요/댓글 수 배지.
///
/// 탭 영역이 여럿으로 나뉜다 — 썸네일(재생 아이콘) 쪽은 영상을 재생하고, 좋아요 배지는
/// 그 자리에서 토글하고, 댓글 배지는 재생 없이 바로 댓글 시트를 연다.
class SubmissionGridTile extends ConsumerWidget {
  const SubmissionGridTile({required this.submission, required this.colorIndex, required this.challengeId, super.key});

  final Submission submission;
  final int colorIndex;
  final int challengeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = thumbnailStyleFor(colorIndex);

    return ThumbnailFrame(
      radius: 12,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            color: style.background,
            child: Column(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => _play(context),
                    child: Icon(Icons.play_arrow_rounded, size: 23, color: style.accent),
                  ),
                ),
                Row(
                  children: [
                    _Badge(text: submission.nickname, bold: true),
                    const Spacer(),
                    InkWell(
                      borderRadius: BorderRadius.circular(6),
                      onTap: () =>
                          ref.read(challengeLikeProvider(challengeId).notifier).toggleSubmission(submission.id),
                      child: _Badge(
                        icon: submission.isLikedByMe ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                        iconColor: submission.isLikedByMe ? AppColors.primary : null,
                        text: '${submission.likeCount}',
                      ),
                    ),
                    const SizedBox(width: 4),
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
          // 영상이 외부 링크로 열리는 경우(인앱 브라우저)엔 그 안에 신고 메뉴를 못 넣으니,
          // 재생 방식과 무관하게 여기 하나로 신고 진입점을 통일한다.
          Positioned(
            right: 0,
            top: 0,
            child: PopupMenuButton<String>(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.more_vert, size: 16, color: AppColors.ink),
              color: AppColors.surface,
              surfaceTintColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: AppColors.border),
              ),
              onSelected: (_) => _report(context),
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: 'report',
                  child: Text('신고하기', style: TextStyle(fontSize: 15, color: AppColors.danger)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _play(BuildContext context) {
    final reportTarget = (type: ReportTargetType.submission, id: submission.id);
    final assetPath = submission.assetPath;
    if (assetPath != null) {
      context.push(
        RoutePath.assetVideoPlayer,
        extra: (title: submission.nickname, assetPath: assetPath, reportTarget: reportTarget),
      );
      return;
    }
    final url = submission.videoUrl;
    if (url != null) {
      unawaited(openVideoInAppBrowser(context, url));
    }
  }

  void _report(BuildContext context) {
    context.push(
      RoutePath.report,
      extra: (
        target: (type: ReportTargetType.submission, id: submission.id),
        targetLabel: '${submission.nickname}님 영상',
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.text, this.icon, this.iconColor, this.bold = false});

  final String text;
  final IconData? icon;
  final Color? iconColor;
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
          if (icon != null) ...[Icon(icon, size: 12, color: iconColor ?? AppColors.ink), const SizedBox(width: 2)],
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
