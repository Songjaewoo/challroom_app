import 'package:dio/dio.dart';

import '../models/enums.dart';
import '../models/pick_videos.dart';
import '../models/rooms.dart';

/// 인터페이스인 이유는 하나 — 백엔드가 없을 때 `LocalRoomRepository` 로 갈아끼워
/// 홈 화면을 기기에서 미리 볼 수 있게 하기 위해서다. (`core/dev/local_room_repository.dart` 참고)
abstract interface class RoomRepository {
  Future<List<PickVideo>> fetchWeeklyPicks();

  /// `category` 가 `null` 이면 "전체" — 필터 없이 다 가져온다.
  Future<List<Room>> fetchRooms({RoomCategory? category});
}

class DioRoomRepository implements RoomRepository {
  DioRoomRepository(this._dio);

  final Dio _dio;

  @override
  Future<List<PickVideo>> fetchWeeklyPicks() async {
    final res = await _dio.get<List<dynamic>>('/pick-videos/weekly');
    return (res.data ?? const []).map((e) => PickVideo.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<List<Room>> fetchRooms({RoomCategory? category}) async {
    final res = await _dio.get<List<dynamic>>(
      '/rooms',
      queryParameters: category == null ? null : {'category': category.queryValue},
    );
    return (res.data ?? const []).map((e) => Room.fromJson(e as Map<String, dynamic>)).toList();
  }
}
