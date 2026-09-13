import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../models/enums.dart';
import '../../../models/rooms.dart';
import '../../../shared/avatar_color.dart';
import '../../../shared/widgets/participant_avatar_stack.dart';
import '../../../shared/widgets/thumbnail_frame.dart';
import '../../../shared/widgets/video_thumbnail.dart';
import 'apply_confirm_dialog.dart';

/// 방 목록 카드 한 줄. 모집 중([RoomStatus.open])이고 아직 멤버가 아니면 오른쪽에 "신청"
/// 배지를 붙인다 — 이미 멤버([Room.isMember])면 신청해봐야 아무 일도 안 일어나니 안 보여준다.
/// 이미 속한 방 목록("내 방")에서는 신청할 필요가 없으니 [showApplyBadge] 로 끈다 — 다만
/// 신청까지만 해두고 아직 수락 전인 방([Room.isApplied])은 이 값과 무관하게 "신청취소"
/// 배지를 보여준다.
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
        decoration: BoxDecoration(color: AppColors.accentSoft, borderRadius: BorderRadius.circular(14)),
        child: Row(
          children: [
            ThumbnailFrame(
              width: 50,
              height: 84,
              radius: 8,
              child: VideoThumbnail(url: room.thumbnailUrl, style: style),
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
                    style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w500, color: AppColors.ink),
                  ),
                  if (room.hashtags.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      room.hashtags.map((tag) => '#$tag').join(' '),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12.5, color: AppColors.inkFaint),
                    ),
                  ],
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      ParticipantAvatarStack(participants: room.participants),
                      const SizedBox(width: 6),
                      Text(
                        '${room.participantCount}명 참여 중',
                        style: const TextStyle(fontSize: 12.5, color: AppColors.inkMuted),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (room.isApplied || (!room.isMember && showApplyBadge && room.status == RoomStatus.open)) ...[
              const SizedBox(width: 8),
              _ApplyBadge(room: room),
            ],
          ],
        ),
      ),
    );
  }
}

class _ApplyBadge extends StatelessWidget {
  const _ApplyBadge({required this.room});

  final Room room;

  @override
  Widget build(BuildContext context) {
    final applied = room.isApplied;
    return GestureDetector(
      // 카드 전체에도 탭(방 상세 이동)이 걸려있는데, 이 배지 위에서 탭하면 이쪽이 먼저
      // 받는다 — 안쪽 제스처가 우선이라 굳이 막지 않아도 카드 쪽 onTap 은 안 불린다.
      onTap: () => applied
          ? showCancelApplicationDialog(context, roomId: room.id, roomTitle: room.title)
          : showApplyConfirmDialog(context, roomId: room.id, roomTitle: room.title),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          // 신청 중인 방은 눌러도 되는(하지만 진행형 CTA는 아닌) 액션이라, 브랜드 핑크 대신
          // 카드보다 한 단 낮은 중립색으로 눈에 띄되 차분하게 둔다.
          color: applied ? AppColors.surface : AppColors.primary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          applied ? '신청취소' : '신청',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: applied ? AppColors.inkMuted : AppColors.onBrand,
          ),
        ),
      ),
    );
  }
}
