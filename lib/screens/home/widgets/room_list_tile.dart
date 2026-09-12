import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../models/enums.dart';
import '../../../models/rooms.dart';
import '../../../shared/avatar_color.dart';
import '../../../shared/widgets/participant_avatar_stack.dart';

/// 방 목록 카드 한 줄. 모집 중([RoomStatus.open])이면 오른쪽에 "신청" 배지를 붙인다.
/// 이미 속한 방 목록("내 방")에서는 신청할 필요가 없으니 [showApplyBadge] 로 끈다.
class RoomListTile extends StatelessWidget {
  const RoomListTile({required this.room, required this.colorIndex, this.showApplyBadge = true, super.key});

  final Room room;
  final int colorIndex;
  final bool showApplyBadge;

  @override
  Widget build(BuildContext context) {
    final style = thumbnailStyleFor(colorIndex);

    return InkWell(
      onTap: () => context.push(RoutePath.roomDetailOf(room.id)),
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
              width: 42,
              height: 72,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: style.background, borderRadius: BorderRadius.circular(8)),
              child: Icon(Icons.play_arrow_rounded, size: 18, color: style.accent),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    room.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.ink),
                  ),
                  if (room.hashtags.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      room.hashtags.map((tag) => '#$tag').join(' '),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 11, color: AppColors.inkFaint),
                    ),
                  ],
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      ParticipantAvatarStack(participants: room.participants),
                      const SizedBox(width: 6),
                      Text(
                        '${room.participantCount}명 참여 중',
                        style: const TextStyle(fontSize: 11, color: AppColors.inkMuted),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (showApplyBadge && room.status == RoomStatus.open) ...[const SizedBox(width: 8), const _ApplyBadge()],
          ],
        ),
      ),
    );
  }
}

class _ApplyBadge extends StatelessWidget {
  const _ApplyBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: AppColors.successSoft, borderRadius: BorderRadius.circular(8)),
      child: const Text(
        '신청',
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.successDark),
      ),
    );
  }
}
