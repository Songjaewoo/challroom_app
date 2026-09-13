import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../controllers/home_controller.dart';
import '../../../core/error/error_message.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../models/pick_videos.dart';
import '../../../shared/avatar_color.dart';
import '../../../shared/video_launcher.dart';
import '../../../shared/widgets/thumbnail_frame.dart';

const _cardWidth = 128.0;
const _thumbnailHeight = 168.0;

/// "이번 주 챌룸 PICK" — 카드를 탭하면 영상을 보여주고(번들 파일은 네이티브 플레이어,
/// 외부 링크는 인앱 브라우저), "+" 를 누르면 이 영상으로 방 만들기를 시작한다(아직 준비 중).
class WeeklyPickSection extends ConsumerWidget {
  const WeeklyPickSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final picks = ref.watch(weeklyPicksProvider);
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 6, 18, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '이번 주 챌룸 PICK',
            style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500, color: AppColors.ink),
          ),
          const SizedBox(height: 2),
          Text('탭하면 영상을 볼 수 있어요', style: theme.textTheme.bodySmall?.copyWith(fontSize: 12.5, color: AppColors.inkFaint)),
          const SizedBox(height: 10),
          SizedBox(
            height: _thumbnailHeight + 56,
            child: picks.when(
              loading: () => const Center(child: CircularProgressIndicator(strokeWidth: 2)),
              error: (error, _) => Center(
                child: Text(error.toUserMessage(), style: const TextStyle(fontSize: 13.5, color: AppColors.inkMuted)),
              ),
              data: (list) => list.isEmpty
                  ? const Center(
                      child: Text('이번 주 PICK 영상이 없어요', style: TextStyle(fontSize: 13.5, color: AppColors.inkMuted)),
                    )
                  : ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: list.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 10),
                      itemBuilder: (_, index) => _PickCard(video: list[index], colorIndex: index),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PickCard extends StatelessWidget {
  const _PickCard({required this.video, required this.colorIndex});

  final PickVideo video;
  final int colorIndex;

  @override
  Widget build(BuildContext context) {
    final style = thumbnailStyleFor(colorIndex);

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () => _open(context),
      child: Container(
        width: _cardWidth,
        decoration: BoxDecoration(color: AppColors.accentSoft, borderRadius: BorderRadius.circular(14)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ThumbnailFrame(
              width: double.infinity,
              height: _thumbnailHeight,
              radius: 12,
              child: Container(
                color: style.background,
                alignment: Alignment.center,
                child: Icon(Icons.play_arrow_rounded, size: 27, color: style.accent),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      video.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w500, color: AppColors.ink),
                    ),
                  ),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () => context.push(RoutePath.createRoom, extra: video),
                    // 이 영상으로 "새 방을 만드는" 생성 액션이라, 진행형 CTA(핑크)와 구분해서
                    // 코랄(logoMid)을 쓴다 — 방 추가/영상 추가처럼 "만들기" 계열 버튼은 전부 이 색.
                    child: const CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.logoMid,
                      child: Icon(Icons.add, size: 20, color: AppColors.onBrand),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _open(BuildContext context) {
    final assetPath = video.assetPath;
    if (assetPath != null) {
      // 우리가 실제로 파일을 갖고 있는 영상 — 네이티브 플레이어로 재생한다.
      // 큐레이션한 PICK 영상이라(누가 올린 콘텐츠가 아니라) 신고 메뉴는 안 띄운다.
      context.push(RoutePath.assetVideoPlayer, extra: (title: video.title, assetPath: assetPath, reportTarget: null));
      return;
    }

    final url = video.videoUrl;
    if (url != null) {
      unawaited(openVideoInAppBrowser(context, url));
    }
  }
}
