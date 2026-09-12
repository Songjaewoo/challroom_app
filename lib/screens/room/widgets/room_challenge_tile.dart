import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../models/rooms.dart';
import '../../../shared/avatar_color.dart';
import '../../../shared/coming_soon.dart';

/// 방 안의 챌린지 영상 한 줄. 탭하면 원본 재생이 아니라 친구들이 제출한 영상을 모아 보는
/// 챌린지 상세 화면으로 간다. 오른쪽 원형 버튼을 누르면 이 챌린지에 영상을 제출한다.
class RoomChallengeTile extends StatelessWidget {
  const RoomChallengeTile({required this.challenge, required this.colorIndex, super.key});

  final RoomChallenge challenge;
  final int colorIndex;

  @override
  Widget build(BuildContext context) {
    final style = thumbnailStyleFor(colorIndex);

    return InkWell(
      onTap: () => context.push(RoutePath.challengeDetailOf(challenge.id)),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 80,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: style.background, borderRadius: BorderRadius.circular(8)),
              child: Icon(Icons.play_arrow_rounded, size: 20, color: style.accent),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    challenge.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.ink),
                  ),
                  const SizedBox(height: 3),
                  Text(challenge.source, style: const TextStyle(fontSize: 11, color: AppColors.inkFaint)),
                  const SizedBox(height: 6),
                  Text(
                    '${challenge.submittedCount}/${challenge.totalCount}명 제출 완료',
                    style: const TextStyle(fontSize: 11, color: AppColors.inkMuted),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => showComingSoon(context, '"${challenge.title}" 에 제출하기'),
              child: const CircleAvatar(
                radius: 15,
                backgroundColor: AppColors.primary,
                child: Icon(Icons.videocam_outlined, size: 15, color: AppColors.onBrand),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
