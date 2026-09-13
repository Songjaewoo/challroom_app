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

  /// 로그인한 유저가 속한 방만 — 바텀 네비게이션 "내 방" 탭이 쓴다.
  Future<List<Room>> fetchMyRooms();

  Future<RoomDetail> fetchRoomDetail(int roomId);

  Future<ChallengeDetail> fetchChallengeDetail(int challengeId);

  Future<Room> createRoom(RoomCreateReq req);

  /// 방장만 할 수 있다 — 서버가 권한을 검사하고, 방장이 아니면 거절한다.
  Future<RoomDetail> removeMember(int roomId, String nickname);

  /// 방장만 할 수 있다 — 제목/해시태그/공개 여부를 바꾼다.
  Future<RoomDetail> updateRoom(int roomId, RoomUpdateReq req);

  /// 방장만 할 수 있다 — 새 초대 코드를 만든다(이미 있으면 새 코드로 바뀐다).
  Future<RoomDetail> createInviteCode(int roomId);

  /// 초대 코드로 방에 들어간다. 코드가 유효하지 않으면 실패한다.
  Future<Room> joinRoomByCode(String code);

  /// 모집 중인 방에 참가 신청을 보낸다 — 방장이 수락하기 전까지는 멤버가 아니다.
  /// 신청한 방은 "내 방" 목록에도 [Room.isApplied] 가 `true` 인 채로 같이 보인다.
  Future<void> applyToRoom(int roomId);

  /// 보낸 참가 신청을 취소한다.
  Future<void> cancelApplication(int roomId);

  /// 방장만 할 수 있다 — 신청자를 수락해 멤버로 편입한다.
  Future<RoomDetail> acceptApplicant(int roomId, String nickname);

  /// 방장만 할 수 있다 — 신청을 거절한다(멤버가 되지 않는다).
  Future<RoomDetail> rejectApplicant(int roomId, String nickname);

  /// 챌린지 원본 영상 좋아요를 껐다 켰다 한다.
  Future<ChallengeDetail> toggleChallengeLike(int challengeId);

  /// 제출 영상 하나의 좋아요를 껐다 켰다 한다.
  Future<ChallengeDetail> toggleSubmissionLike(int challengeId, int submissionId);
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

  @override
  Future<List<Room>> fetchMyRooms() async {
    final res = await _dio.get<List<dynamic>>('/rooms/mine');
    return (res.data ?? const []).map((e) => Room.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<RoomDetail> fetchRoomDetail(int roomId) async {
    final res = await _dio.get<Map<String, dynamic>>('/rooms/$roomId');
    return RoomDetail.fromJson(res.data!);
  }

  @override
  Future<ChallengeDetail> fetchChallengeDetail(int challengeId) async {
    final res = await _dio.get<Map<String, dynamic>>('/challenges/$challengeId');
    return ChallengeDetail.fromJson(res.data!);
  }

  @override
  Future<Room> createRoom(RoomCreateReq req) async {
    final res = await _dio.post<Map<String, dynamic>>('/rooms', data: req.toJson());
    return Room.fromJson(res.data!);
  }

  @override
  Future<RoomDetail> removeMember(int roomId, String nickname) async {
    final res = await _dio.delete<Map<String, dynamic>>('/rooms/$roomId/members/$nickname');
    return RoomDetail.fromJson(res.data!);
  }

  @override
  Future<RoomDetail> updateRoom(int roomId, RoomUpdateReq req) async {
    final res = await _dio.patch<Map<String, dynamic>>('/rooms/$roomId', data: req.toJson());
    return RoomDetail.fromJson(res.data!);
  }

  @override
  Future<RoomDetail> createInviteCode(int roomId) async {
    final res = await _dio.post<Map<String, dynamic>>('/rooms/$roomId/invite-code');
    return RoomDetail.fromJson(res.data!);
  }

  @override
  Future<Room> joinRoomByCode(String code) async {
    final res = await _dio.post<Map<String, dynamic>>('/rooms/join', data: {'code': code});
    return Room.fromJson(res.data!);
  }

  @override
  Future<void> applyToRoom(int roomId) async {
    await _dio.post<void>('/rooms/$roomId/apply');
  }

  @override
  Future<void> cancelApplication(int roomId) async {
    await _dio.delete<void>('/rooms/$roomId/apply');
  }

  @override
  Future<RoomDetail> acceptApplicant(int roomId, String nickname) async {
    final res = await _dio.post<Map<String, dynamic>>('/rooms/$roomId/applicants/$nickname/accept');
    return RoomDetail.fromJson(res.data!);
  }

  @override
  Future<RoomDetail> rejectApplicant(int roomId, String nickname) async {
    final res = await _dio.delete<Map<String, dynamic>>('/rooms/$roomId/applicants/$nickname');
    return RoomDetail.fromJson(res.data!);
  }

  @override
  Future<ChallengeDetail> toggleChallengeLike(int challengeId) async {
    final res = await _dio.post<Map<String, dynamic>>('/challenges/$challengeId/like');
    return ChallengeDetail.fromJson(res.data!);
  }

  @override
  Future<ChallengeDetail> toggleSubmissionLike(int challengeId, int submissionId) async {
    final res = await _dio.post<Map<String, dynamic>>('/challenges/$challengeId/submissions/$submissionId/like');
    return ChallengeDetail.fromJson(res.data!);
  }
}
