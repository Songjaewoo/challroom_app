import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../controllers/my_rooms_controller.dart';
import '../../core/error/error_message.dart';
import '../../core/router/app_router.dart';
import '../../core/theme/app_theme.dart';
import '../../shared/widgets/empty_view.dart';
import '../../shared/widgets/error_view.dart';
import '../home/widgets/room_list_tile.dart';

/// 바텀 네비게이션 "내 방" 탭 — 로그인한 유저가 속한 방만 모아 보여준다.
class MyRoomsScreen extends ConsumerWidget {
  const MyRoomsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rooms = ref.watch(myRoomsProvider);

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 12, 18, 8),
            child: Row(
              children: [
                Text(
                  '내 방',
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500, color: AppColors.ink),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () => context.push(RoutePath.joinRoom),
                  icon: const Icon(Icons.qr_code_2_outlined, size: 16),
                  label: const Text('코드로 참여'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(myRoomsProvider);
                await ref.read(myRoomsProvider.future);
              },
              child: rooms.when(
                loading: () => const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                error: (error, _) =>
                    ErrorView(message: error.toUserMessage(), onRetry: () => ref.invalidate(myRoomsProvider)),
                data: (list) => list.isEmpty
                    ? const EmptyView(message: '아직 참여 중인 방이 없어요.')
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(14, 4, 14, 14),
                        itemCount: list.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 8),
                        itemBuilder: (_, index) =>
                            RoomListTile(room: list[index], colorIndex: list[index].id, showApplyBadge: false),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
