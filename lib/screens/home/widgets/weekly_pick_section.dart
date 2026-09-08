import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/home_controller.dart';
import '../../../core/error/error_message.dart';
import '../../../core/theme/app_theme.dart';
import '../../../models/pick_videos.dart';
import '../../../shared/avatar_color.dart';
import '../../../shared/coming_soon.dart';

const _cardWidth = 104.0;
const _thumbnailHeight = 150.0;

/// "이번 주 챌룸 PICK" — 탭하면 그 영상으로 바로 방 만들기를 시작한다(아직 준비 중).
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
          Text(
            '탭하면 이 영상으로 바로 방을 만들어요',
            style: theme.textTheme.bodySmall?.copyWith(fontSize: 11, color: AppColors.inkFaint),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: _thumbnailHeight + 46,
            child: picks.when(
              loading: () => const Center(child: CircularProgressIndicator(strokeWidth: 2)),
              error: (error, _) => Center(
                child: Text(error.toUserMessage(), style: const TextStyle(fontSize: 12, color: AppColors.inkMuted)),
              ),
              data: (list) => list.isEmpty
                  ? const Center(
                      child: Text('이번 주 PICK 영상이 없어요', style: TextStyle(fontSize: 12, color: AppColors.inkMuted)),
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

    return Container(
      width: _cardWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: _thumbnailHeight,
            width: double.infinity,
            color: style.background,
            alignment: Alignment.center,
            child: Icon(Icons.play_arrow_rounded, size: 26, color: style.accent),
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
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.ink),
                  ),
                ),
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: () => showComingSoon(context, '이 영상으로 방 만들기'),
                  child: const CircleAvatar(
                    radius: 9,
                    backgroundColor: AppColors.primary,
                    child: Icon(Icons.add, size: 12, color: AppColors.onBrand),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
