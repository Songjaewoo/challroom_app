import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/home_controller.dart';
import '../../../core/error/error_message.dart';
import '../../../shared/widgets/empty_view.dart';
import '../../../shared/widgets/error_view.dart';
import 'room_list_tile.dart';

class RoomListSection extends ConsumerWidget {
  const RoomListSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rooms = ref.watch(roomListProvider);

    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
      child: rooms.when(
        loading: () => const Padding(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
        ),
        error: (error, _) => ErrorView(message: error.toUserMessage(), onRetry: () => ref.invalidate(roomListProvider)),
        data: (list) => list.isEmpty
            ? const EmptyView(message: '이 카테고리엔 아직 방이 없어요.')
            : Column(
                children: [
                  for (final room in list) ...[
                    RoomListTile(room: room, colorIndex: room.id),
                    const SizedBox(height: 8),
                  ],
                ],
              ),
      ),
    );
  }
}
