import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../models/rooms.dart';
import '../../../shared/avatar_color.dart';
import '../../../shared/coming_soon.dart';
import '../../../shared/widgets/thumbnail_frame.dart';
import '../../../shared/widgets/video_thumbnail.dart';

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
        decoration: BoxDecoration(color: AppColors.accentSoft, borderRadius: BorderRadius.circular(14)),
        child: Row(
          children: [
            ThumbnailFrame(
              width: 54,
              height: 92,
              radius: 8,
              child: VideoThumbnail(url: challenge.thumbnailUrl, style: style, iconSize: 22),
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
                    style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w500, color: AppColors.ink),
                  ),
                  const SizedBox(height: 3),
                  Text(challenge.source, style: const TextStyle(fontSize: 12.5, color: AppColors.inkFaint)),
                  const SizedBox(height: 6),
                  Text.rich(
                    TextSpan(
                      style: const TextStyle(fontSize: 12.5, color: AppColors.inkMuted),
                      children: [
                        TextSpan(
                          text: '${challenge.submittedCount}',
                          style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.ink, fontSize: 13.5),
                        ),
                        TextSpan(text: '/${challenge.totalCount}명 제출 완료'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => showComingSoon(context, '"${challenge.title}" 에 제출하기'),
              // 새 영상을 "제출/추가"하는 액션이라 진행형 CTA(핑크)와 구분해서 코랄(logoMid)을 쓴다.
              child: const CircleAvatar(
                radius: 19,
                backgroundColor: AppColors.logoMid,
                child: Icon(Icons.videocam_outlined, size: 21, color: AppColors.onBrand),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
