import 'dart:math';

import '../../models/enums.dart';
import '../../models/pick_videos.dart';
import '../../models/rooms.dart';
import '../../models/submissions.dart';
import '../../repositories/room_repository.dart';
import '../../repositories/user_repository.dart';
import '../error/api_exception.dart';
import '../network/room_api_client.dart';

/// `API_BASE_URL` 이 없을 때(지금 상태) 홈 화면을 미리 보기 위한 샘플 데이터.
/// `providers.dart` 가 실제 서버가 붙으면 자동으로 [DioRoomRepository] 로 돌아간다.
///
/// 방 만들기가 실제로 목록에 반영돼야 해서 더 이상 `const`/상태 없음이 아니다 —
/// [roomRepositoryProvider] 가 `keepAlive` 인 이유도 이 상태를 앱이 켜 있는 동안 유지하기
/// 위해서다. 앱을 다시 켜면 초기화된다.
class LocalRoomRepository implements RoomRepository {
  LocalRoomRepository(this._userRepository, {RoomApiClient? apiClient}) : _apiClient = apiClient;

  final UserRepository _userRepository;

  /// 실제 서버 연결이 있을 때만 채워진다(`providers.dart`). 있으면 [createRoom] 이 로컬
  /// 상태는 그대로 유지하면서 "곁다리로" 진짜 방도 하나 만들어본다 — 영상이 서버가 아는
  /// 출처(유튜브/인스타/틱톡)일 때만. 실패하면 그대로 예외를 던진다(조용히 무시하지 않는다).
  final RoomApiClient? _apiClient;

  // 실제 영상 데이터가 없어 예시 URL을 돌려 쓴다 — 서버가 붙으면 각자 실제 주소를 준다.
  // 인스타그램·틱톡은 인앱 브라우저로 여는 방식이 유튜브 외 출처에서도 되는지 보는 테스트용.
  static const _youtubeSampleUrl = 'https://youtube.com/shorts/GLKie9yzMdM?si=KsaAlvm5xNG-x7S7';
  static const _instagramSampleUrl = 'https://www.instagram.com/reel/Dc6PZngTm5R/?stkn=MTA2NTZpOW5hbjNkOQ==';
  static const _tiktokSampleUrl = 'https://vt.tiktok.com/ZSqPa4eFC/';

  // 데모 데이터 id 는 전부 음수를 쓴다 — 실서버 id(방/PICK/영상 전부 1부터 자동증가)와
  // 절대 안 겹치게 하려는 의도적인 선택이다. 예전엔 데모도 1부터 썼는데, 실제로 만든 방이
  // 우연히 같은 번호를 받으면서 "내가 이미 멤버인 방"으로 잘못 겹쳐 보이는 버그가 실제로
  // 났다(신청 배지가 안 뜸) — 그 뒤로 이 규칙을 못 박았다.
  static const _picks = [
    PickVideo(id: -1, title: '3초 텐션', source: 'YouTube Shorts', videoUrl: _youtubeSampleUrl),
    PickVideo(id: -2, title: '눈빛 승부', source: 'YouTube Shorts', videoUrl: _youtubeSampleUrl),
    PickVideo(id: -3, title: '인스타 테스트', source: 'Instagram Reels', videoUrl: _instagramSampleUrl),
    PickVideo(id: -4, title: '틱톡 테스트', source: 'TikTok', videoUrl: _tiktokSampleUrl),
    // 외부 링크가 아니라 우리가 파일을 갖고 있는 영상 — 네이티브 플레이어로 재생된다.
    PickVideo(id: -5, title: '직접 업로드', source: '직접 업로드', assetPath: 'assets/videos/sample_challenge.mp4'),
  ];

  final _rooms = <Room>[
    const Room(
      id: -1,
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
      id: -2,
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
      id: -3,
      title: '오늘 기분 한마디',
      hashtags: ['리액션'],
      participants: [ParticipantInfo(nickname: '현우')],
      participantCount: 1,
      status: RoomStatus.open,
    ),
  ];

  final _roomDetails = <int, RoomDetail>{
    -1: const RoomDetail(
      id: -1,
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
        RoomChallenge(id: -1, title: '3초 텐션 올리기', source: 'YouTube Shorts', submittedCount: 2, totalCount: 4),
        RoomChallenge(id: -2, title: '눈빛 승부 챌린지', source: 'TikTok', submittedCount: 1, totalCount: 4),
        RoomChallenge(id: -3, title: '오늘 기분 한마디', source: 'Instagram Reels', submittedCount: 0, totalCount: 4),
      ],
    ),
    -2: const RoomDetail(
      id: -2,
      title: '눈빛 승부 한판 붙자',
      hashtags: ['운동', '승부욕'],
      members: [
        ParticipantInfo(nickname: '지수'),
        ParticipantInfo(nickname: '유나'),
      ],
      memberCount: 2,
      challenges: [
        RoomChallenge(id: -4, title: '눈빛 안 웃기 버티기', source: 'YouTube Shorts', submittedCount: 1, totalCount: 2),
      ],
    ),
    -3: const RoomDetail(
      id: -3,
      title: '오늘 기분 한마디',
      hashtags: ['리액션'],
      members: [ParticipantInfo(nickname: '현우')],
      memberCount: 1,
      challenges: [
        RoomChallenge(id: -5, title: '오늘 기분 한마디로', source: 'Instagram Reels', submittedCount: 0, totalCount: 1),
      ],
    ),
  };

  final _challengeDetails = <int, ChallengeDetail>{
    // 댓글 수(commentCount)는 `LocalCommentRepository` 에 심어둔 샘플 댓글 개수와 맞춰뒀다 —
    // 실제로는 서버가 하나의 값으로 관리할 숫자가, 목업이라 두 저장소로 나뉜 것뿐이다.
    -1: const ChallengeDetail(
      id: -1,
      title: '3초 텐션 올리기',
      source: 'YouTube Shorts',
      videoUrl: _youtubeSampleUrl,
      totalCount: 4,
      commentCount: 3,
      likeCount: 12,
      submissions: [
        Submission(id: -1, nickname: '민지', videoUrl: _youtubeSampleUrl, commentCount: 2, likeCount: 5),
        Submission(id: -2, nickname: '서준', videoUrl: _youtubeSampleUrl, commentCount: 1, likeCount: 2, isLikedByMe: true),
      ],
    ),
    -2: const ChallengeDetail(
      id: -2,
      title: '눈빛 승부 챌린지',
      source: 'TikTok',
      videoUrl: _tiktokSampleUrl,
      totalCount: 4,
      likeCount: 4,
      submissions: [Submission(id: -3, nickname: '하늘', videoUrl: _tiktokSampleUrl, commentCount: 0, likeCount: 1)],
    ),
    -3: const ChallengeDetail(
      id: -3,
      title: '오늘 기분 한마디',
      source: 'Instagram Reels',
      videoUrl: _instagramSampleUrl,
      totalCount: 4,
    ),
    -4: const ChallengeDetail(
      id: -4,
      title: '눈빛 안 웃기 버티기',
      source: 'YouTube Shorts',
      videoUrl: _youtubeSampleUrl,
      totalCount: 2,
      likeCount: 7,
      submissions: [
        Submission(id: -4, nickname: '지수', videoUrl: _youtubeSampleUrl, commentCount: 3, likeCount: 3),
      ],
    ),
    -5: const ChallengeDetail(
      id: -5,
      title: '오늘 기분 한마디로',
      source: 'Instagram Reels',
      videoUrl: _instagramSampleUrl,
      totalCount: 1,
    ),
  };

  /// 방 만들기로 새로 생긴 방 id — 데모의 고정 두 방(-1, -2)에 더해 "내 방"에 넣는다.
  final _myRoomIds = <int>{-1, -2};

  /// 로그인한 유저가 방장인 방 id — -1번은 데모용으로 미리 방장으로 심어뒀고, 방을 직접
  /// 만들면(`createRoom`) 그 방도 여기 추가된다. [fetchRoomDetail] 이 이 값을 보고
  /// `isOwnedByMe`/멤버 목록에 "나"를 채운다.
  final _ownedRoomIds = <int>{-1};

  /// 발급된 초대 코드 -> 방 id. [joinRoomByCode] 가 이 맵으로 방을 찾는다.
  final _inviteCodes = <String, int>{};
  final _random = Random();

  /// 참가 신청을 보내놓고 아직 방장 수락 전인 방 id. 멤버가 되면([joinRoomByCode] 등) 이
  /// 목록에서 의미가 없어지지만, 굳이 지우지 않아도 [_withApplied] 가 `_myRoomIds` 를 먼저
  /// 확인해 `isApplied` 를 `false` 로 돌려준다.
  final _appliedRoomIds = <int>{};

  /// 남이 내 방에 신청해놓고 아직 내가 수락/거절하지 않은 목록 — 방 id -> 신청자들.
  /// -1번 방(내가 방장)에 데모용으로 두 명 미리 심어뒀다.
  final _pendingApplicants = <int, List<ParticipantInfo>>{
    // 수락/거절이 이 리스트를 직접 지운다(`removeWhere`) — `const` 로 두면 그때 터진다.
    -1: [const ParticipantInfo(nickname: '유진'), const ParticipantInfo(nickname: '태호')],
  };

  /// 실서버 방의 대기 중인 입장 신청 id — 방 id -> (신청자 닉네임 -> 신청 id).
  /// [acceptApplicant]/[rejectApplicant] 는 닉네임만 받는데 실제 승인/거절 API
  /// (`PATCH .../join-requests/{id}`) 는 신청 id 가 필요해서, [fetchRoomDetail] 이 신청
  /// 목록을 받아올 때마다 여기 채워둔다.
  final _realJoinRequestIds = <int, Map<String, int>>{};

  // 로컬 전용으로(실서버 호출 없이) 새로 생기는 방/챌린지 id 도 데모와 같은 이유로 음수를
  // 계속 쓴다 — 데모 상수(-1~-5)와 안 겹치게 훨씬 더 작은 값에서 시작해 올라간다.
  var _nextRoomId = -1000;
  var _nextChallengeId = -1000;

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
  Future<List<PickVideo>> fetchWeeklyPicks() async {
    // 실서버가 붙어 있으면 "이번 주 챌룸 PICK" 도 통째로 실제 데이터로 바꾼다 — 방 목록과
    // 같은 원칙(전체 교체). 지금은 편집자가 DB에 직접 심는 방식이라 비어있을 수도 있다.
    final apiClient = _apiClient;
    if (apiClient != null) return apiClient.fetchWeeklyPicks();

    return _picks;
  }

  @override
  Future<List<Room>> fetchRooms({RoomCategory? category}) async {
    // 실서버가 붙어 있으면 홈 목록은 통째로 실제 공개방으로 바꾼다 — 서버엔 카테고리
    // 개념이 없어 필터는 무시된다(칩을 눌러도 같은 결과). 로컬 데모/생성 방은 "내 방"
    // 탭([fetchMyRooms])에서만 보인다.
    final apiClient = _apiClient;
    if (apiClient != null) {
      final rooms = await apiClient.fetchPublicRooms();
      return rooms.map(_withApplied).toList();
    }

    final list = category == null ? _rooms : _rooms.where((room) => room.category == category);
    return list.map(_withApplied).toList();
  }

  @override
  Future<List<Room>> fetchMyRooms() async {
    // 이미 멤버인 방 + 아직 수락 전이라 신청만 해둔 방 — 둘 다 "내 방"에 같이 보인다.
    final joined = _rooms.where((room) => _myRoomIds.contains(room.id));
    final appliedOnly = _rooms.where((room) => _appliedRoomIds.contains(room.id) && !_myRoomIds.contains(room.id));
    return [...joined, ...appliedOnly].map(_withApplied).toList();
  }

  Room _withApplied(Room room) {
    final isMember = _myRoomIds.contains(room.id);
    return room.copyWith(isMember: isMember, isApplied: _appliedRoomIds.contains(room.id) && !isMember);
  }

  @override
  Future<void> applyToRoom(int roomId) async {
    final apiClient = _apiClient;
    if (apiClient != null) {
      try {
        await apiClient.applyToRoom(roomId);
        // "신청" 배지는 서버 데이터가 아니라 이 로컬 상태로 그리니, 실제 신청이 성공해도
        // 여기 반영을 안 하면 화면엔 안 뜬다.
        _appliedRoomIds.add(roomId);
        return;
      } on ApiException catch (e) {
        // 로컬 데모 방(1~3번)은 서버에 없어 404 가 난다 — 그때만 로컬로 폴백한다.
        // 이미 멤버·이미 신청 중 같은 진짜 에러(409)는 그대로 위로 던진다.
        if (e.statusCode != 404) rethrow;
      }
    }

    if (!_rooms.any((r) => r.id == roomId)) {
      throw const ApiException(statusCode: 404, code: 'ROOM_NOT_FOUND', message: '방을 찾을 수 없어요.');
    }
    if (_myRoomIds.contains(roomId)) return; // 이미 멤버면 신청할 필요가 없다.
    _appliedRoomIds.add(roomId);
  }

  @override
  Future<void> cancelApplication(int roomId) async {
    // 서버엔 "내 신청 취소하기" 엔드포인트가 아직 없다(방장의 승인/거절만 있다) — 로컬
    // 배지만 지운다. 실서버 방에 낸 신청은 이걸로는 안 지워지고, 서버 쪽에 방장이 거절
    // 처리해야 실제로 사라진다.
    _appliedRoomIds.remove(roomId);
  }

  @override
  Future<RoomDetail> fetchRoomDetail(int roomId) async {
    final apiClient = _apiClient;
    if (apiClient != null) {
      try {
        final result = await apiClient.fetchRoomDetail(roomId);
        var detail = result.detail;

        // 방장인 방이면 대기 중인 입장 신청도 같이 받아온다 — 남이 보는 상세엔 필요 없어서
        // 위에서 걸러진다(서버도 방장 아니면 403 으로 막는다).
        if (detail.isOwnedByMe) {
          final joinRequests = await apiClient.fetchJoinRequests(roomId);
          _realJoinRequestIds[roomId] = {for (final r in joinRequests) r.applicant.nickname: r.requestId};
          detail = detail.copyWith(pendingApplicants: joinRequests.map((r) => r.applicant).toList());
        }

        _cacheRealDetail(detail, result.challengeDetails, result.isMember);
        return detail;
      } on ApiException catch (e) {
        // 로컬 데모 방(1~3번)은 서버에 없어 404 가 난다 — 그때만 로컬로 폴백한다.
        // 그 외(비공개 방 접근 거부 등)는 진짜 에러니 그대로 위로 던진다.
        if (e.statusCode != 404) rethrow;
      }
    }

    final detail = _roomDetails[roomId];
    if (detail == null) {
      throw const ApiException(statusCode: 404, code: 'ROOM_NOT_FOUND', message: '방을 찾을 수 없어요.');
    }
    if (!_ownedRoomIds.contains(roomId)) return detail;

    // 방장인 방이면 신청 대기 목록도 같이 채운다 — 남이 보는 화면에는 필요 없으니 위에서
    // 걸러진다.
    final pending = _pendingApplicants[roomId] ?? const [];

    // 방장인 방이면 "나"를 방장으로 표시한다. 직접 만든 방(`createRoom`)은 이미 멤버
    // 목록에 내가 들어있지만, 데모로 미리 방장을 심어둔 1번 방은 시드 데이터라 여기서 채운다
    // — 실제 서버라면 멤버 목록에 애초에 내가 포함돼 있을 값들이다.
    final myNickname = (await _userRepository.fetchMe()).nickname;
    if (myNickname == null) return detail.copyWith(isOwnedByMe: true, pendingApplicants: pending);

    final myIndex = detail.members.indexWhere((m) => m.nickname == myNickname);
    if (myIndex == -1) {
      return detail.copyWith(
        isOwnedByMe: true,
        members: [ParticipantInfo(nickname: myNickname, isOwner: true), ...detail.members],
        memberCount: detail.memberCount + 1,
        pendingApplicants: pending,
      );
    }

    // 이미 목록에 있는 내 자리를 방장으로 표시한다(새로 추가하지 않는다 — 인원수가 그대로여야 한다).
    final members = [...detail.members];
    members[myIndex] = members[myIndex].copyWith(isOwner: true);
    return detail.copyWith(isOwnedByMe: true, members: members, pendingApplicants: pending);
  }

  @override
  Future<RoomDetail> acceptApplicant(int roomId, String nickname) async {
    final requestId = _realJoinRequestIds[roomId]?[nickname];
    final apiClient = _apiClient;
    if (apiClient != null && requestId != null) {
      await apiClient.decideJoinRequest(roomId, requestId, approve: true);
      _realJoinRequestIds[roomId]?.remove(nickname);
      return fetchRoomDetail(roomId);
    }

    _requireOwner(roomId, action: '신청을 수락');
    final detail = _roomDetails[roomId];
    if (detail == null) {
      throw const ApiException(statusCode: 404, code: 'ROOM_NOT_FOUND', message: '방을 찾을 수 없어요.');
    }

    final pending = _pendingApplicants[roomId];
    final applicant = pending?.where((a) => a.nickname == nickname).firstOrNull;
    if (pending == null || applicant == null) {
      throw const ApiException(statusCode: 404, code: 'APPLICANT_NOT_FOUND', message: '신청자를 찾을 수 없어요.');
    }

    pending.removeWhere((a) => a.nickname == nickname);
    _roomDetails[roomId] = detail.copyWith(
      members: [...detail.members, applicant],
      memberCount: detail.memberCount + 1,
    );

    final roomIndex = _rooms.indexWhere((r) => r.id == roomId);
    if (roomIndex != -1) {
      _rooms[roomIndex] = _rooms[roomIndex].copyWith(participantCount: _rooms[roomIndex].participantCount + 1);
    }

    return fetchRoomDetail(roomId);
  }

  @override
  Future<RoomDetail> rejectApplicant(int roomId, String nickname) async {
    final requestId = _realJoinRequestIds[roomId]?[nickname];
    final apiClient = _apiClient;
    if (apiClient != null && requestId != null) {
      await apiClient.decideJoinRequest(roomId, requestId, approve: false);
      _realJoinRequestIds[roomId]?.remove(nickname);
      return fetchRoomDetail(roomId);
    }

    _requireOwner(roomId, action: '신청을 거절');
    if (!_roomDetails.containsKey(roomId)) {
      throw const ApiException(statusCode: 404, code: 'ROOM_NOT_FOUND', message: '방을 찾을 수 없어요.');
    }

    _pendingApplicants[roomId]?.removeWhere((a) => a.nickname == nickname);
    return fetchRoomDetail(roomId);
  }

  /// 실서버에서 받아온 방 상세를 로컬 상태에도 반영한다 — 그래야 챌린지 상세로 더
  /// 들어가거나("이 방장이 아닌 방금 서버에서 본 방") 다음에 또 이 방을 조회할 때도
  /// 계속 앞뒤가 맞는다. "홈" 목록을 거쳐 처음 보는 실서버 방일 수도 있어서, 로컬
  /// [_rooms]/[_myRoomIds]/[_ownedRoomIds] 에 없으면 여기서 새로 채워 넣는다.
  void _cacheRealDetail(RoomDetail detail, List<ChallengeDetail> challengeDetails, bool isMember) {
    _roomDetails[detail.id] = detail;
    for (final challengeDetail in challengeDetails) {
      _challengeDetails[challengeDetail.id] = challengeDetail;
    }

    if (!_rooms.any((r) => r.id == detail.id)) {
      _rooms.add(
        Room(id: detail.id, title: detail.title, participantCount: detail.memberCount, status: RoomStatus.open),
      );
    }
    if (isMember) _myRoomIds.add(detail.id);
    if (detail.isOwnedByMe) _ownedRoomIds.add(detail.id);
  }

  void _requireOwner(int roomId, {required String action}) {
    if (!_ownedRoomIds.contains(roomId)) {
      throw ApiException(statusCode: 403, code: 'NOT_ROOM_OWNER', message: '방장만 $action할 수 있어요.');
    }
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
  Future<ChallengeDetail> toggleChallengeLike(int challengeId) async {
    final detail = await fetchChallengeDetail(challengeId);
    final liked = !detail.isLikedByMe;
    final updated = detail.copyWith(isLikedByMe: liked, likeCount: detail.likeCount + (liked ? 1 : -1));
    _challengeDetails[challengeId] = updated;
    return updated;
  }

  @override
  Future<ChallengeDetail> toggleSubmissionLike(int challengeId, int submissionId) async {
    final detail = await fetchChallengeDetail(challengeId);
    final index = detail.submissions.indexWhere((s) => s.id == submissionId);
    if (index == -1) {
      throw const ApiException(statusCode: 404, code: 'SUBMISSION_NOT_FOUND', message: '제출 영상을 찾을 수 없어요.');
    }

    final submission = detail.submissions[index];
    final liked = !submission.isLikedByMe;
    final submissions = [...detail.submissions];
    submissions[index] = submission.copyWith(isLikedByMe: liked, likeCount: submission.likeCount + (liked ? 1 : -1));

    final updated = detail.copyWith(submissions: submissions);
    _challengeDetails[challengeId] = updated;
    return updated;
  }

  @override
  Future<Room> createRoom(RoomCreateReq req) async {
    // req.videoUrl/req.assetPath 를 항상 우선한다 — 화면(create_room_screen.dart)이 PICK 을
    // 골랐든 직접 입력했든 항상 같이 보내준다. `_picks` 로 다시 찾는 건 그 PICK 이 이 로컬
    // 고정 목록에 있을 때 "출처 표기"(source) 만 더 좋게 채우는 보너스다 — 실서버 PICK 은
    // id 공간이 달라서 여기서 못 찾아도(= null) 정상이고, 그래도 영상 자체는 위 값으로
    // 이미 정확하다.
    final pickVideo = req.pickVideoId == null ? null : _picks.where((p) => p.id == req.pickVideoId).firstOrNull;
    final myNickname = (await _userRepository.fetchMe()).nickname ?? '나';

    final videoUrl = req.videoUrl;
    final assetPath = req.assetPath;
    final hasVideo = videoUrl != null || assetPath != null;
    final source = pickVideo?.source ?? (assetPath != null ? '직접 업로드' : '링크');

    // 서버가 아는 출처(유튜브/인스타/틱톡)의 링크일 때만 실제 방도 만들어본다 — 직접 업로드한
    // 파일은 서버에 올릴 방법이 아직 없어(프로필 사진과 같은 사정) 건너뛴다.
    // 성공하면 로컬 방 id 로 서버가 매긴 id 를 그대로 쓴다 — 그래야 "홈"의 실서버 목록에서
    // 이 방을 다시 봤을 때도 같은 id 로 상세를 찾을 수 있다(방 만들기 직후엔 로컬 상세를,
    // 나중엔 실서버 목록 카드를 거쳐도 같은 방으로 이어진다).
    String? inviteCode;
    int roomId;
    final apiClient = _apiClient;
    RoomApiCreateResult? apiResult;
    if (apiClient != null && videoUrl != null) {
      final videoSource = RoomApiClient.resolveVideoSource(videoUrl);
      if (videoSource != null) {
        apiResult = await apiClient.createRoom(
          name: req.title,
          description: req.description,
          isPublic: req.isPublic,
          videoUrl: videoUrl,
          videoSource: videoSource,
        );
      }
    }
    if (apiResult != null) {
      roomId = apiResult.id;
      inviteCode = apiResult.inviteCode;
    } else {
      roomId = _nextRoomId++; // 로컬 전용 — 서버 id 가 없으니 로컬 시퀀스를 쓴다.
    }

    final room = Room(
      id: roomId,
      title: req.title,
      hashtags: req.hashtags,
      participantCount: 1,
      status: RoomStatus.open,
      // 서버가 방금 만들면서 바로 채워준 썸네일이 있으면 쓴다(유튜브·틱톡은 즉시 채워지고,
      // 인스타그램은 서버에 oEmbed 연동이 없어 여기서도 계속 `null` 이다).
      thumbnailUrl: apiResult?.thumbnailUrl,
    );
    _rooms.add(room);
    _myRoomIds.add(roomId);
    _ownedRoomIds.add(roomId); // 방을 만든 사람이 방장이다.

    var challenges = const <RoomChallenge>[];
    if (hasVideo) {
      final challengeId = _nextChallengeId++;
      challenges = [
        RoomChallenge(
          id: challengeId,
          title: req.title,
          source: source,
          submittedCount: 0,
          totalCount: 1,
          thumbnailUrl: apiResult?.thumbnailUrl,
        ),
      ];
      // 목록 카드([RoomChallenge])만 만들고 상세를 안 채우면 탭했을 때 404 가 난다 — 같이 채운다.
      _challengeDetails[challengeId] = ChallengeDetail(
        id: challengeId,
        title: req.title,
        source: source,
        videoUrl: videoUrl,
        assetPath: assetPath,
        totalCount: 1,
      );
    }

    _roomDetails[roomId] = RoomDetail(
      id: roomId,
      title: req.title,
      description: req.description,
      hashtags: req.hashtags,
      isPublic: req.isPublic,
      members: [ParticipantInfo(nickname: myNickname, isOwner: true)],
      memberCount: 1,
      challenges: challenges,
      inviteCode: inviteCode,
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

    _roomDetails[roomId] = detail.copyWith(
      title: req.title,
      description: req.description,
      hashtags: req.hashtags,
      isPublic: req.isPublic,
    );

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
