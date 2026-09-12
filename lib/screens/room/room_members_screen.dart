import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/room_detail_controller.dart';
import '../../controllers/room_invite_controller.dart';
import '../../controllers/room_members_controller.dart';
import '../../core/error/error_message.dart';
import '../../core/theme/app_theme.dart';
import '../../models/rooms.dart';
import '../../shared/avatar_color.dart';
import '../../shared/widgets/error_view.dart';

/// 방 멤버 목록 — 방장이면 이 화면 안에서 바로 내보내기까지 한다("멤버 N명" 을 탭하면
/// 온다). 방장이 아니면 읽기 전용 목록으로만 보인다.
class RoomMembersScreen extends ConsumerWidget {
  const RoomMembersScreen({required this.roomId, super.key});

  final int roomId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(roomDetailProvider(roomId));

    ref.listen(roomMembersProvider(roomId), (previous, next) {
      if (next case AsyncError(:final error)) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(error.toUserMessage())));
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('멤버')),
      body: detail.when(
        loading: () => const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        error: (error, _) =>
            ErrorView(message: error.toUserMessage(), onRetry: () => ref.invalidate(roomDetailProvider(roomId))),
        data: (room) => _MemberList(roomId: roomId, room: room),
      ),
    );
  }
}

class _MemberList extends ConsumerWidget {
  const _MemberList({required this.roomId, required this.room});

  final int roomId;
  final RoomDetail room;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final removing = ref.watch(roomMembersProvider(roomId)).isLoading;

    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 24),
      children: [
        Text('${room.title} · 멤버 ${room.memberCount}명', style: const TextStyle(fontSize: 13, color: AppColors.inkMuted)),
        const SizedBox(height: 14),
        if (room.isOwnedByMe) ...[_InviteCodeSection(roomId: roomId, room: room), const SizedBox(height: 20)],
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(14),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Column(
              children: [
                for (var i = 0; i < room.members.length; i++) ...[
                  _MemberRow(
                    member: room.members[i],
                    // 방장은 스스로를 내보낼 수 없다 — 다른 멤버한테만 내보내기가 보인다.
                    canRemove: room.isOwnedByMe && !room.members[i].isOwner,
                    busy: removing,
                    onRemove: () => _confirmRemove(context, ref, room.members[i].nickname),
                  ),
                  if (i != room.members.length - 1)
                    const Divider(height: 0.5, thickness: 0.5, color: AppColors.border),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _confirmRemove(BuildContext context, WidgetRef ref, String nickname) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('멤버 내보내기'),
        content: Text('$nickname님을 이 방에서 내보낼까요?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: const Text('취소')),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('내보내기', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    await ref.read(roomMembersProvider(roomId).notifier).removeMember(nickname);
  }
}

/// 초대 코드 생성/표시 — 예전엔 별도 화면이었지만, 뎁스를 줄이려고 멤버 화면 맨 위에
/// 그대로 얹었다.
class _InviteCodeSection extends ConsumerWidget {
  const _InviteCodeSection({required this.roomId, required this.room});

  final int roomId;
  final RoomDetail room;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final generating = ref.watch(roomInviteProvider(roomId)).isLoading;

    ref.listen(roomInviteProvider(roomId), (previous, next) {
      if (next case AsyncError(:final error)) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(error.toUserMessage())));
      }
    });

    final code = room.inviteCode;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: code == null ? AppColors.accentSoft : AppColors.primarySoft,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: code == null ? AppColors.border : AppColors.primary.withValues(alpha: 0.3)),
      ),
      child: code == null
          ? Row(
              children: [
                const Expanded(
                  child: Text('초대 코드가 아직 없어요', style: TextStyle(fontSize: 13, color: AppColors.inkMuted)),
                ),
                FilledButton(
                  onPressed: generating ? null : () => ref.read(roomInviteProvider(roomId).notifier).generate(),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(0, 38),
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                  ),
                  child: generating
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.onBrand),
                        )
                      : const Text('코드 만들기', style: TextStyle(fontSize: 12.5)),
                ),
              ],
            )
          : Row(
              children: [
                Text(
                  code,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                    letterSpacing: 4,
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    '이 코드로 초대하세요',
                    style: TextStyle(fontSize: 11.5, color: AppColors.inkMuted),
                  ),
                ),
                IconButton(
                  onPressed: () => _copy(context, code),
                  icon: const Icon(Icons.copy_outlined, size: 18, color: AppColors.inkMuted),
                  tooltip: '복사하기',
                  visualDensity: VisualDensity.compact,
                ),
                IconButton(
                  onPressed: generating ? null : () => ref.read(roomInviteProvider(roomId).notifier).generate(),
                  icon: generating
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.inkMuted),
                        )
                      : const Icon(Icons.refresh, size: 18, color: AppColors.inkMuted),
                  tooltip: '새 코드 발급',
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
    );
  }

  void _copy(BuildContext context, String code) {
    unawaited(Clipboard.setData(ClipboardData(text: code)));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('코드를 복사했어요.')));
  }
}

class _MemberRow extends StatelessWidget {
  const _MemberRow({required this.member, required this.canRemove, required this.busy, required this.onRemove});

  final ParticipantInfo member;
  final bool canRemove;
  final bool busy;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: avatarColorFor(member.nickname),
            child: Text(
              member.nickname.substring(0, 1),
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.onBrand),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Row(
              children: [
                Text(
                  member.nickname,
                  style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w500, color: AppColors.ink),
                ),
                if (member.isOwner) ...[
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: AppColors.primarySoft, borderRadius: BorderRadius.circular(6)),
                    child: const Text('방장', style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600, color: AppColors.primary)),
                  ),
                ],
              ],
            ),
          ),
          if (canRemove)
            TextButton(
              onPressed: busy ? null : onRemove,
              style: TextButton.styleFrom(minimumSize: Size.zero, padding: const EdgeInsets.symmetric(horizontal: 8)),
              child: const Text('내보내기', style: TextStyle(fontSize: 12.5, color: AppColors.inkMuted)),
            ),
        ],
      ),
    );
  }
}
