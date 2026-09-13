import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../controllers/room_detail_controller.dart';
import '../../core/error/error_message.dart';
import '../../core/router/app_router.dart';
import '../../core/theme/app_theme.dart';
import '../../models/rooms.dart';
import '../../shared/coming_soon.dart';
import '../../shared/widgets/error_view.dart';
import '../../shared/widgets/participant_avatar_stack.dart';
import 'widgets/room_challenge_tile.dart';
import 'widgets/room_settings_menu.dart';

class RoomDetailScreen extends ConsumerWidget {
  const RoomDetailScreen({required this.roomId, super.key});

  final int roomId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(roomDetailProvider(roomId));

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.of(context).maybePop()),
        actions: [
          RoomSettingsMenuButton(
            room: detail.value,
            onSelected: (action) => _handleSettingsAction(context, detail.value!, action),
          ),
          IconButton(onPressed: () => showComingSoon(context, '공유'), icon: const Icon(Icons.ios_share)),
        ],
      ),
      body: detail.when(
        loading: () => const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        error: (error, _) =>
            ErrorView(message: error.toUserMessage(), onRetry: () => ref.invalidate(roomDetailProvider(roomId))),
        data: (room) => Padding(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                room.title,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500, color: AppColors.ink),
              ),
              if (room.description case final description? when description.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(description, style: const TextStyle(fontSize: 14.5, color: AppColors.inkMuted, height: 1.4)),
              ],
              const SizedBox(height: 8),
              InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () => context.push(RoutePath.roomMembersOf(roomId)),
                child: Row(
                  children: [
                    ParticipantAvatarStack(participants: room.members, max: room.members.length),
                    const SizedBox(width: 8),
                    Text('멤버 ${room.memberCount}명', style: const TextStyle(fontSize: 12.5, color: AppColors.inkMuted)),
                    const SizedBox(width: 2),
                    const Icon(Icons.chevron_right_rounded, size: 16, color: AppColors.inkFaint),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '챌린지 영상 ${room.challenges.length}개',
                    style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w500, color: AppColors.ink),
                  ),
                  GestureDetector(
                    onTap: () => showComingSoon(context, '영상 추가'),
                    // "추가" 액션이라 진행형 CTA(핑크)와 구분해서 코랄(logoMid)을 쓴다.
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add, size: 16, color: AppColors.logoMid),
                        SizedBox(width: 2),
                        Text('영상 추가', style: TextStyle(fontSize: 13.5, color: AppColors.logoMid)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: room.challenges.isEmpty
                    ? const Center(
                        child: Text('아직 등록된 챌린지 영상이 없어요.', style: TextStyle(fontSize: 14.5, color: AppColors.inkMuted)),
                      )
                    : ListView.separated(
                        itemCount: room.challenges.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 10),
                        itemBuilder: (_, index) =>
                            RoomChallengeTile(challenge: room.challenges[index], colorIndex: index),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSettingsAction(BuildContext context, RoomDetail room, RoomSettingsAction action) {
    if (action == RoomSettingsAction.editRoom) {
      unawaited(context.push(RoutePath.roomEditOf(room.id), extra: room));
      return;
    }
    showComingSoon(context, action.label);
  }
}
