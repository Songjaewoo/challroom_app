import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/enums.dart';
import '../models/pick_videos.dart';
import '../models/rooms.dart';
import '../providers.dart';

part 'home_controller.g.dart';

@riverpod
Future<List<PickVideo>> weeklyPicks(Ref ref) {
  return ref.watch(roomRepositoryProvider).fetchWeeklyPicks();
}

/// 카테고리 칩 선택 상태. `null` 은 "전체". [roomListProvider] 가 이 값을 보고 다시 조회한다.
@riverpod
class SelectedRoomCategory extends _$SelectedRoomCategory {
  @override
  RoomCategory? build() => null;

  void select(RoomCategory? category) => state = category;
}

@riverpod
Future<List<Room>> roomList(Ref ref) {
  final category = ref.watch(selectedRoomCategoryProvider);
  return ref.watch(roomRepositoryProvider).fetchRooms(category: category);
}
