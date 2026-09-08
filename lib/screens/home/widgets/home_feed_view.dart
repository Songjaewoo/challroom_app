import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/home_controller.dart';
import 'category_chip_row.dart';
import 'home_header.dart';
import 'room_list_section.dart';
import 'weekly_pick_section.dart';

/// 바텀 네비게이션 "홈" 탭 본문 — PICK 영상 · 카테고리 칩 · 방 목록.
class HomeFeedView extends ConsumerWidget {
  const HomeFeedView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const HomeHeader(),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(weeklyPicksProvider);
              ref.invalidate(roomListProvider);
              await Future.wait([ref.read(weeklyPicksProvider.future), ref.read(roomListProvider.future)]);
            },
            child: ListView(
              padding: const EdgeInsets.only(bottom: 16),
              children: const [WeeklyPickSection(), CategoryChipRow(), RoomListSection()],
            ),
          ),
        ),
      ],
    );
  }
}
