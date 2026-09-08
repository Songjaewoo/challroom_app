import '../../models/enums.dart';
import '../../models/pick_videos.dart';
import '../../models/rooms.dart';
import '../../repositories/room_repository.dart';

/// `API_BASE_URL` 이 없을 때(지금 상태) 홈 화면을 미리 보기 위한 고정 샘플 데이터.
/// `providers.dart` 가 실제 서버가 붙으면 자동으로 [DioRoomRepository] 로 돌아간다.
class LocalRoomRepository implements RoomRepository {
  const LocalRoomRepository();

  static const _picks = [
    PickVideo(id: 1, title: '3초 텐션', source: 'YouTube Shorts'),
    PickVideo(id: 2, title: '눈빛 승부', source: 'YouTube Shorts'),
  ];

  static const _rooms = [
    Room(
      id: 1,
      title: '우리끼리 텐션 챌린지',
      hashtags: ['춤', '텐션업'],
      participants: [
        ParticipantInfo(nickname: '민지'),
        ParticipantInfo(nickname: '서준'),
        ParticipantInfo(nickname: '하늘'),
      ],
      participantCount: 3,
      status: RoomStatus.ongoing,
      category: RoomCategory.dance,
    ),
    Room(
      id: 2,
      title: '눈빛 승부 한판 붙자',
      hashtags: ['운동', '승부욕'],
      participants: [
        ParticipantInfo(nickname: '지수'),
        ParticipantInfo(nickname: '유나'),
      ],
      participantCount: 2,
      status: RoomStatus.open,
      category: RoomCategory.workout,
    ),
    Room(
      id: 3,
      title: '오늘 기분 한마디',
      hashtags: ['리액션'],
      participants: [ParticipantInfo(nickname: '현우')],
      participantCount: 1,
      status: RoomStatus.open,
    ),
  ];

  @override
  Future<List<PickVideo>> fetchWeeklyPicks() async => _picks;

  @override
  Future<List<Room>> fetchRooms({RoomCategory? category}) async {
    if (category == null) return _rooms;
    return _rooms.where((room) => room.category == category).toList();
  }
}
