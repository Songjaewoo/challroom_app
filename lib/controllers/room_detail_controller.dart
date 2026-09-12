import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/rooms.dart';
import '../providers.dart';

part 'room_detail_controller.g.dart';

@riverpod
Future<RoomDetail> roomDetail(Ref ref, int roomId) {
  return ref.watch(roomRepositoryProvider).fetchRoomDetail(roomId);
}
