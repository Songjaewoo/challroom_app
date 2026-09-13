import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../controllers/challenge_detail_controller.dart';
import '../../controllers/challenge_like_controller.dart';
import '../../core/error/error_message.dart';
import '../../core/router/app_router.dart';
import '../../core/theme/app_theme.dart';
import '../../models/enums.dart';
import '../../models/reports.dart';
import '../../models/rooms.dart';
import '../../shared/avatar_color.dart';
import '../../shared/coming_soon.dart';
import '../../shared/video_launcher.dart';
import '../../shared/widgets/error_view.dart';
import '../../shared/widgets/participant_avatar_stack.dart';
import '../comments/comments_sheet.dart';
import 'widgets/submission_grid_tile.dart';

/// 방 안 챌린지 영상 하나의 상세 — 원본 영상 + 친구들이 제출한 영상 목록.
/// 방 상세에서 챌린지 카드를 탭하면 (재생이 아니라) 이 화면으로 온다.
class ChallengeDetailScreen extends ConsumerWidget {
  const ChallengeDetailScreen({required this.challengeId, super.key});

  final int challengeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(challengeDetailProvider(challengeId));

    return Scaffold(
      appBar: AppBar(
        title: detail.whenOrNull(data: (c) => Text(c.title, maxLines: 1, overflow: TextOverflow.ellipsis)),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            color: AppColors.surface,
            surfaceTintColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: AppColors.border),
            ),
            onSelected: (_) => detail.whenOrNull(
              data: (c) => context.push(
                RoutePath.report,
                extra: (target: (type: ReportTargetType.challenge, id: c.id), targetLabel: c.title),
              ),
            ),
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 'report',
                child: Text('원본 영상 신고', style: TextStyle(fontSize: 15, color: AppColors.danger)),
              ),
            ],
          ),
        ],
      ),
      body: detail.when(
        loading: () => const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        error: (error, _) => ErrorView(
          message: error.toUserMessage(),
          onRetry: () => ref.invalidate(challengeDetailProvider(challengeId)),
        ),
        data: (challenge) => _ChallengeDetailBody(challenge: challenge),
      ),
    );
  }
}

class _ChallengeDetailBody extends ConsumerWidget {
  const _ChallengeDetailBody({required this.challenge});

  final ChallengeDetail challenge;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = thumbnailStyleFor(challenge.id);
    final submittedCount = challenge.submissions.length;
    final submitters = [for (final submission in challenge.submissions) ParticipantInfo(nickname: submission.nickname)];

    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _OriginalVideoThumbnail(challenge: challenge, style: style),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 156,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$submittedCount/${challenge.totalCount}명 제출 완료',
                            style: const TextStyle(fontSize: 12.5, color: AppColors.inkMuted),
                          ),
                          const SizedBox(height: 8),
                          if (submitters.isNotEmpty)
                            ParticipantAvatarStack(participants: submitters, max: submitters.length),
                        ],
                      ),
                      FilledButton.icon(
                        onPressed: () => showComingSoon(context, '따라 찍기'),
                        icon: const Icon(Icons.videocam_outlined, size: 17),
                        label: const Text('따라 찍기'),
                        style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(40)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.only(bottom: 12),
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
            child: Row(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(6),
                  onTap: () => ref.read(challengeLikeProvider(challenge.id).notifier).toggleChallenge(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          challenge.isLikedByMe ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                          size: 18,
                          color: challenge.isLikedByMe ? AppColors.primary : AppColors.inkMuted,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '${challenge.likeCount}',
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w600,
                            color: challenge.isLikedByMe ? AppColors.primary : AppColors.inkMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(6),
                    onTap: () => showCommentsSheet(
                      context,
                      target: (type: CommentTargetType.challenge, id: challenge.id),
                      title: challenge.title,
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.chat_bubble_outline, size: 18, color: AppColors.inkMuted),
                        const SizedBox(width: 6),
                        Text(
                          '이 영상에 댓글',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.inkMuted),
                        ),
                        const Spacer(),
                        Text(
                          '${challenge.commentCount}',
                          style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: AppColors.primary),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            '제출된 영상',
            style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w500, color: AppColors.ink),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: challenge.submissions.isEmpty
                ? const Center(
                    child: Text('아직 제출된 영상이 없어요.', style: TextStyle(fontSize: 14.5, color: AppColors.inkMuted)),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.only(bottom: 16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 9 / 16,
                    ),
                    itemCount: challenge.submissions.length,
                    itemBuilder: (_, index) => SubmissionGridTile(
                      submission: challenge.submissions[index],
                      colorIndex: index,
                      challengeId: challenge.id,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _OriginalVideoThumbnail extends StatelessWidget {
  const _OriginalVideoThumbnail({required this.challenge, required this.style});

  final ChallengeDetail challenge;
  final ({Color background, Color accent}) style;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _open(context),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: 88,
        height: 156,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: style.background, borderRadius: BorderRadius.circular(14)),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(Icons.play_arrow_rounded, size: 30, color: style.accent),
            Positioned(
              left: 6,
              top: 6,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.55),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(challenge.source, style: const TextStyle(fontSize: 10.5, color: AppColors.onBrand)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _open(BuildContext context) {
    final assetPath = challenge.assetPath;
    if (assetPath != null) {
      context.push(
        RoutePath.assetVideoPlayer,
        extra: (
          title: challenge.title,
          assetPath: assetPath,
          reportTarget: (type: ReportTargetType.challenge, id: challenge.id),
        ),
      );
      return;
    }
    final url = challenge.videoUrl;
    if (url != null) {
      unawaited(openVideoInAppBrowser(context, url));
    }
  }
}
