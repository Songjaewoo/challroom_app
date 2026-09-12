import 'dart:math';

import '../../models/enums.dart';
import '../../models/pick_videos.dart';
import '../../models/rooms.dart';
import '../../models/submissions.dart';
import '../../repositories/room_repository.dart';
import '../../repositories/user_repository.dart';
import '../error/api_exception.dart';

/// `API_BASE_URL` 이 없을 때(지금 상태) 홈 화면을 미리 보기 위한 샘플 데이터.
/// `providers.dart` 가 실제 서버가 붙으면 자동으로 [DioRoomRepository] 로 돌아간다.
///
/// 방 만들기가 실제로 목록에 반영돼야 해서 더 이상 `const`/상태 없음이 아니다 —
/// [roomRepositoryProvider] 가 `keepAlive` 인 이유도 이 상태를 앱이 켜 있는 동안 유지하기
/// 위해서다. 앱을 다시 켜면 초기화된다.
class LocalRoomRepository implements RoomRepository {
  LocalRoomRepository(this._userRepository);

  final UserRepository _userRepository;

  // 실제 영상 데이터가 없어 예시 URL을 돌려 쓴다 — 서버가 붙으면 각자 실제 주소를 준다.
  // 인스타그램·틱톡은 인앱 브라우저로 여는 방식이 유튜브 외 출처에서도 되는지 보는 테스트용.
  static const _youtubeSampleUrl = 'https://youtube.com/shorts/GLKie9yzMdM?si=KsaAlvm5xNG-x7S7';
  static const _instagramSampleUrl = 'https://www.instagram.com/reel/Dc6PZngTm5R/?stkn=MTA2NTZpOW5hbjNkOQ==';
  static const _tiktokSampleUrl = 'https://vt.tiktok.com/ZSqPa4eFC/';

  static const _picks = [
    PickVideo(id: 1, title: '3초 텐션', source: 'YouTube Shorts', videoUrl: _youtubeSampleUrl),
    PickVideo(id: 2, title: '눈빛 승부', source: 'YouTube Shorts', videoUrl: _youtubeSampleUrl),
    PickVideo(id: 3, title: '인스타 테스트', source: 'Instagram Reels', videoUrl: _instagramSampleUrl),
    PickVideo(id: 4, title: '틱톡 테스트', source: 'TikTok', videoUrl: _tiktokSampleUrl),
    // 외부 링크가 아니라 우리가 파일을 갖고 있는 영상 — 네이티브 플레이어로 재생된다.
    PickVideo(id: 5, title: '직접 업로드', source: '직접 업로드', assetPath: 'assets/videos/sample_challenge.mp4'),
  ];

  final _rooms = <Room>[
    const Room(
      id: 1,
      title: '우리끼리 텐션 챌린지',
      hashtags: ['춤', '텐션업'],
      participants: [
        ParticipantInfo(nickname: '민지'),
        ParticipantInfo(nickname: '서준'),
        ParticipantInfo(nickname: '하늘'),
      ],
      participantCount: 4,
      status: RoomStatus.ongoing,
      category: RoomCategory.dance,
    ),
    const Room(
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
    const Room(
      id: 3,
      title: '오늘 기분 한마디',
      hashtags: ['리액션'],
      participants: [ParticipantInfo(nickname: '현우')],
      participantCount: 1,
      status: RoomStatus.open,
    ),
  ];

  final _roomDetails = <int, RoomDetail>{
    1: const RoomDetail(
      id: 1,
      title: '우리끼리 텐션 챌린지',
      hashtags: ['춤', '텐션업'],
      members: [
        ParticipantInfo(nickname: '민지'),
        ParticipantInfo(nickname: '서준'),
        ParticipantInfo(nickname: '하늘'),
        ParticipantInfo(nickname: '지수'),
      ],
      memberCount: 4,
      challenges: [
        RoomChallenge(id: 1, title: '3초 텐션 올리기', source: 'YouTube Shorts', submittedCount: 2, totalCount: 4),
        RoomChallenge(id: 2, title: '눈빛 승부 챌린지', source: 'TikTok', submittedCount: 1, totalCount: 4),
        RoomChallenge(id: 3, title: '오늘 기분 한마디', source: 'Instagram Reels', submittedCount: 0, totalCount: 4),
      ],
    ),
    2: const RoomDetail(
      id: 2,
      title: '눈빛 승부 한판 붙자',
      hashtags: ['운동', '승부욕'],
      members: [
        ParticipantInfo(nickname: '지수'),
        ParticipantInfo(nickname: '유나'),
      ],
      memberCount: 2,
      challenges: [
        RoomChallenge(id: 4, title: '눈빛 안 웃기 버티기', source: 'YouTube Shorts', submittedCount: 1, totalCount: 2),
      ],
    ),
    3: const RoomDetail(
      id: 3,
      title: '오늘 기분 한마디',
      hashtags: ['리액션'],
      members: [ParticipantInfo(nickname: '현우')],
      memberCount: 1,
      challenges: [
        RoomChallenge(id: 5, title: '오늘 기분 한마디로', source: 'Instagram Reels', submittedCount: 0, totalCount: 1),
      ],
    ),
  };

  final _challengeDetails = <int, ChallengeDetail>{
    // 댓글 수(commentCount)는 `LocalCommentRepository` 에 심어둔 샘플 댓글 개수와 맞춰뒀다 —
    // 실제로는 서버가 하나의 값으로 관리할 숫자가, 목업이라 두 저장소로 나뉜 것뿐이다.
    1: const ChallengeDetail(
      id: 1,
      title: '3초 텐션 올리기',
      source: 'YouTube Shorts',
      videoUrl: _youtubeSampleUrl,
      totalCount: 4,
      commentCount: 3,
      submissions: [
        Submission(id: 1, nickname: '민지', videoUrl: _youtubeSampleUrl, commentCount: 2),
        Submission(id: 2, nickname: '서준', videoUrl: _youtubeSampleUrl, commentCount: 1),
      ],
    ),
    2: const ChallengeDetail(
      id: 2,
      title: '눈빛 승부 챌린지',
      source: 'TikTok',
      videoUrl: _tiktokSampleUrl,
      totalCount: 4,
      submissions: [Submission(id: 3, nickname: '하늘', videoUrl: _tiktokSampleUrl, commentCount: 0)],
    ),
    3: const ChallengeDetail(
      id: 3,
      title: '오늘 기분 한마디',
      source: 'Instagram Reels',
      videoUrl: _instagramSampleUrl,
      totalCount: 4,
    ),
    4: const ChallengeDetail(
      id: 4,
      title: '눈빛 안 웃기 버티기',
      source: 'YouTube Shorts',
      videoUrl: _youtubeSampleUrl,
      totalCount: 2,
      submissions: [Submission(id: 4, nickname: '지수', videoUrl: _youtubeSampleUrl, commentCount: 3)],
    ),
    5: const ChallengeDetail(
      id: 5,
      title: '오늘 기분 한마디로',
      source: 'Instagram Reels',
      videoUrl: _instagramSampleUrl,
      totalCount: 1,
    ),
  };

  /// 방 만들기로 새로 생긴 방 id — 데모의 고정 두 방(1, 2)에 더해 "내 방"에 넣는다.
  final _myRoomIds = <int>{1, 2};

  /// 로그인한 유저가 방장인 방 id — 1번은 데모용으로 미리 방장으로 심어뒀고, 방을 직접
  /// 만들면(`createRoom`) 그 방도 여기 추가된다. [fetchRoomDetail] 이 이 값을 보고
  /// `isOwnedByMe`/멤버 목록에 "나"를 채운다.
  final _ownedRoomIds = <int>{1};

  /// 발급된 초대 코드 -> 방 id. [joinRoomByCode] 가 이 맵으로 방을 찾는다.
  final _inviteCodes = <String, int>{};
  final _random = Random();

  var _nextRoomId = 4;
  var _nextChallengeId = 6;

  // 0/O, 1/I 처럼 헷갈리는 글자는 뺐다 — 손으로 옮겨 적어도 헛갈리지 않게.
  static const _inviteCodeChars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';

  String _generateInviteCode() {
    String code;
    do {
      code = List.generate(6, (_) => _inviteCodeChars[_random.nextInt(_inviteCodeChars.length)]).join();
    } while (_inviteCodes.containsKey(code));
    return code;
  }

  @override
  Future<List<PickVideo>> fetchWeeklyPicks() async => _picks;

  @override
  Future<List<Room>> fetchRooms({RoomCategory? category}) async {
    if (category == null) return List.unmodifiable(_rooms);
    return _rooms.where((room) => room.category == category).toList();
  }

  @override
  Future<List<Room>> fetchMyRooms() async => _rooms.where((room) => _myRoomIds.contains(room.id)).toList();

  @override
  Future<RoomDetail> fetchRoomDetail(int roomId) async {
    final detail = _roomDetails[roomId];
    if (detail == null) {
      throw const ApiException(statusCode: 404, code: 'ROOM_NOT_FOUND', message: '방을 찾을 수 없어요.');
    }
    if (!_ownedRoomIds.contains(roomId)) return detail;

    // 방장인 방이면 "나"를 방장으로 표시한다. 직접 만든 방(`createRoom`)은 이미 멤버
    // 목록에 내가 들어있지만, 데모로 미리 방장을 심어둔 1번 방은 시드 데이터라 여기서 채운다
    // — 실제 서버라면 멤버 목록에 애초에 내가 포함돼 있을 값들이다.
    final myNickname = (await _userRepository.fetchMe()).nickname;
    if (myNickname == null) return detail.copyWith(isOwnedByMe: true);

    final myIndex = detail.members.indexWhere((m) => m.nickname == myNickname);
    if (myIndex == -1) {
      return detail.copyWith(
        isOwnedByMe: true,
        members: [ParticipantInfo(nickname: myNickname, isOwner: true), ...detail.members],
        memberCount: detail.memberCount + 1,
      );
    }

    // 이미 목록에 있는 내 자리를 방장으로 표시한다(새로 추가하지 않는다 — 인원수가 그대로여야 한다).
    final members = [...detail.members];
    members[myIndex] = members[myIndex].copyWith(isOwner: true);
    return detail.copyWith(isOwnedByMe: true, members: members);
  }

  @override
  Future<ChallengeDetail> fetchChallengeDetail(int challengeId) async {
    final detail = _challengeDetails[challengeId];
    if (detail == null) {
      throw const ApiException(statusCode: 404, code: 'CHALLENGE_NOT_FOUND', message: '챌린지를 찾을 수 없어요.');
    }
    return detail;
  }

  @override
  Future<Room> createRoom(RoomCreateReq req) async {
    final roomId = _nextRoomId++;
    final pickVideo = req.pickVideoId == null ? null : _picks.where((p) => p.id == req.pickVideoId).firstOrNull;
    final myNickname = (await _userRepository.fetchMe()).nickname ?? '나';

    final room = Room(
      id: roomId,
      title: req.title,
      hashtags: req.hashtags,
      participantCount: 1,
      status: RoomStatus.open,
    );
    _rooms.add(room);
    _myRoomIds.add(roomId);
    _ownedRoomIds.add(roomId); // 방을 만든 사람이 방장이다.

    _roomDetails[roomId] = RoomDetail(
      id: roomId,
      title: req.title,
      hashtags: req.hashtags,
      isPublic: req.isPublic,
      members: [ParticipantInfo(nickname: myNickname, isOwner: true)],
      memberCount: 1,
      challenges: pickVideo == null
          ? const []
          : [
              RoomChallenge(
                id: _nextChallengeId++,
                title: pickVideo.title,
                source: pickVideo.source,
                submittedCount: 0,
                totalCount: 1,
              ),
            ],
    );

    return room;
  }

  @override
  Future<RoomDetail> removeMember(int roomId, String nickname) async {
    final detail = _roomDetails[roomId];
    if (detail == null) {
      throw const ApiException(statusCode: 404, code: 'ROOM_NOT_FOUND', message: '방을 찾을 수 없어요.');
    }
    if (!_ownedRoomIds.contains(roomId)) {
      throw const ApiException(statusCode: 403, code: 'NOT_ROOM_OWNER', message: '방장만 멤버를 내보낼 수 있어요.');
    }

    final updated = detail.copyWith(
      members: detail.members.where((m) => m.nickname != nickname).toList(),
      memberCount: detail.memberCount - 1,
    );
    _roomDetails[roomId] = updated;
    return fetchRoomDetail(roomId);
  }

  @override
  Future<RoomDetail> updateRoom(int roomId, RoomUpdateReq req) async {
    final detail = _roomDetails[roomId];
    if (detail == null) {
      throw const ApiException(statusCode: 404, code: 'ROOM_NOT_FOUND', message: '방을 찾을 수 없어요.');
    }
    if (!_ownedRoomIds.contains(roomId)) {
      throw const ApiException(statusCode: 403, code: 'NOT_ROOM_OWNER', message: '방장만 방 정보를 수정할 수 있어요.');
    }

    _roomDetails[roomId] = detail.copyWith(title: req.title, hashtags: req.hashtags, isPublic: req.isPublic);

    // 홈/내 방 목록의 카드([Room])도 같은 제목·해시태그를 보여주니 같이 맞춘다.
    final roomIndex = _rooms.indexWhere((r) => r.id == roomId);
    if (roomIndex != -1) {
      _rooms[roomIndex] = _rooms[roomIndex].copyWith(title: req.title, hashtags: req.hashtags);
    }

    return fetchRoomDetail(roomId);
  }

  @override
  Future<RoomDetail> createInviteCode(int roomId) async {
    final detail = _roomDetails[roomId];
    if (detail == null) {
      throw const ApiException(statusCode: 404, code: 'ROOM_NOT_FOUND', message: '방을 찾을 수 없어요.');
    }
    if (!_ownedRoomIds.contains(roomId)) {
      throw const ApiException(statusCode: 403, code: 'NOT_ROOM_OWNER', message: '방장만 초대 코드를 만들 수 있어요.');
    }

    // 이전 코드가 있었으면 더는 못 쓰게 지운다 — 한 방에 유효한 코드는 늘 하나다.
    final oldCode = detail.inviteCode;
    if (oldCode != null) _inviteCodes.remove(oldCode);

    final code = _generateInviteCode();
    _inviteCodes[code] = roomId;
    _roomDetails[roomId] = detail.copyWith(inviteCode: code);

    return fetchRoomDetail(roomId);
  }

  @override
  Future<Room> joinRoomByCode(String code) async {
    final roomId = _inviteCodes[code.trim().toUpperCase()];
    if (roomId == null) {
      throw const ApiException(statusCode: 404, code: 'INVITE_CODE_NOT_FOUND', message: '유효하지 않은 초대 코드예요.');
    }

    final detail = _roomDetails[roomId]!;
    final myNickname = (await _userRepository.fetchMe()).nickname ?? '나';

    // 이미 멤버면 다시 추가하지 않는다 — 같은 코드로 여러 번 눌러도 인원수가 늘지 않게.
    if (!detail.members.any((m) => m.nickname == myNickname)) {
      _roomDetails[roomId] = detail.copyWith(
        members: [...detail.members, ParticipantInfo(nickname: myNickname)],
        memberCount: detail.memberCount + 1,
      );

      final roomIndex = _rooms.indexWhere((r) => r.id == roomId);
      if (roomIndex != -1) {
        _rooms[roomIndex] = _rooms[roomIndex].copyWith(participantCount: _rooms[roomIndex].participantCount + 1);
      }
    }

    _myRoomIds.add(roomId);
    return _rooms.firstWhere((r) => r.id == roomId);
  }
}
