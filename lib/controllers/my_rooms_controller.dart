import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/rooms.dart';
import '../providers.dart';

part 'my_rooms_controller.g.dart';

@riverpod
Future<List<Room>> myRooms(Ref ref) {
  return ref.watch(roomRepositoryProvider).fetchMyRooms();
}
