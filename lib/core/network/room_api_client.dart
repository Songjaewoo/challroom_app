import 'package:dio/dio.dart';

import '../../models/enums.dart';
import '../../models/pick_videos.dart';
import '../../models/rooms.dart';
import '../../models/submissions.dart';

/// 방을 실제로 만들면 서버가 돌려주는 값 — [LocalRoomRepository] 가 로컬 방 id 를 서버
/// id 와 맞추는 데 [id] 를 쓴다(그래야 방금 만든 방을 "홈"의 실서버 목록에서 다시
/// 찾았을 때도 같은 id 로 상세를 찾을 수 있다).
class RoomApiCreateResult {
  const RoomApiCreateResult({required this.id, required this.inviteCode, this.thumbnailUrl});

  final int id;
  final String inviteCode;

  /// 서버가 만들면서 바로 채워준 썸네일(유튜브·틱톡은 생성 중에 oEmbed 로 즉시 조회한다).
  /// 인스타그램은 서버에 oEmbed 연동이 없어 항상 `null` — 백엔드 쪽 작업이 별도로 필요하다.
  final String? thumbnailUrl;
}

/// 방 상세(`GET /room/{id}`) 를 앱 모양으로 변환한 결과.
///
/// [RoomDetail] 자체엔 없는 [isMember] 를 따로 들고 있다 — 방장이 아니어도 멤버면
/// [LocalRoomRepository] 가 "내 방" 로컬 상태(`_myRoomIds`)에 반영해야 하는데, 그 판단에
/// 필요한 값이라서다.
class RoomApiDetailResult {
  const RoomApiDetailResult({required this.detail, required this.challengeDetails, required this.isMember});

  final RoomDetail detail;
  final List<ChallengeDetail> challengeDetails;
  final bool isMember;
}

/// 입장 신청 하나(`GET /room/{id}/join-requests` 의 항목). [requestId] 가 있어야
/// 승인/거절(`PATCH .../join-requests/{id}`) 을 호출할 수 있다 — [LocalRoomRepository] 가
/// 닉네임으로 이 id 를 다시 찾을 수 있게 따로 들고 있는다.
class RoomApiJoinRequest {
  const RoomApiJoinRequest({required this.requestId, required this.applicant});

  final int requestId;
  final ParticipantInfo applicant;
}

/// 실제 서버(`challroom_api`)의 방 생성/목록/상세·입장 신청 API만 얇게 감싼 클라이언트.
///
/// [RoomRepository] 전체를 실서버로 옮기기엔 서버 쪽 모양이 앱이 기대하는 것과 많이
/// 다르다(해시태그·카테고리·진행상태 없음 등 — `providers.dart` 의 설명 참고). 그래서
/// 지금은 방 생성·목록·상세·입장 신청만 이 클라이언트로 붙이고, 나머지(멤버 강퇴·방
/// 수정·댓글·좋아요 등)는 여전히 [LocalRoomRepository] 의 로컬 상태를 쓴다.
/// 실패하면 그대로 위로 던진다(로그인 실패를 그대로 보여준 것과 같은 원칙).
class RoomApiClient {
  RoomApiClient(this._dio);

  final Dio _dio;

  /// 서버가 이해하는 영상 출처 셋 — 이 중 하나로 못 정하면(예: 직접 업로드, 알 수 없는
  /// 링크) 애초에 [createRoom] 을 호출하지 않아야 한다([resolveVideoSource] 참고).
  static const supportedVideoSources = {'youtube', 'instagram', 'tiktok'};

  /// URL 을 보고 서버가 받는 `video_source` 값을 추론한다. 못 알아보면 `null` —
  /// 호출하는 쪽이 이 경우 실제 API 호출 자체를 건너뛴다.
  static String? resolveVideoSource(String url) {
    final lower = url.toLowerCase();
    if (lower.contains('youtube') || lower.contains('youtu.be')) return 'youtube';
    if (lower.contains('instagram')) return 'instagram';
    if (lower.contains('tiktok')) return 'tiktok';
    return null;
  }

  /// 방을 만들고 서버가 매긴 방 id 와 초대 코드를 돌려준다.
  Future<RoomApiCreateResult> createRoom({
    required String name,
    String? description,
    required bool isPublic,
    required String videoUrl,
    required String videoSource,
  }) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/room',
      data: {
        'name': name,
        'description': description,
        'isPublic': isPublic,
        'videoUrl': videoUrl,
        'videoSource': videoSource,
      },
    );
    final data = res.data!;
    final videos = (data['videos'] as List?)?.cast<Map<String, dynamic>>() ?? const [];
    return RoomApiCreateResult(
      id: (data['id'] as num).toInt(),
      inviteCode: data['inviteCode'] as String,
      thumbnailUrl: videos.isEmpty ? null : videos.first['thumbnailUrl'] as String?,
    );
  }

  /// 공개방 목록(`GET /room/public`) 을 홈 화면 카드 모양([Room])으로 바로 변환해 돌려준다.
  ///
  /// 서버엔 카테고리·해시태그·진행상태·"내가 신청/가입했는지" 개념이 없어서 그 자리는
  /// 기본값(카테고리 없음, 해시태그 없음, 모집중)으로 채운다 — 호출하는 쪽(로컬 저장소)이
  /// 자기가 아는 멤버십 정보로 [Room.isMember]/[Room.isApplied] 만 덧씌운다.
  Future<List<Room>> fetchPublicRooms({int page = 1, int limit = 50}) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/room/public',
      queryParameters: {'page': page, 'limit': limit},
    );
    final items = (res.data!['items'] as List).cast<Map<String, dynamic>>();
    return items
        .map(
          (item) => Room(
            id: (item['id'] as num).toInt(),
            title: item['name'] as String,
            participantCount: (item['memberCount'] as num).toInt(),
            status: RoomStatus.open,
            thumbnailUrl: item['thumbnailUrl'] as String?,
          ),
        )
        .toList();
  }

  /// 방 상세(`GET /room/{id}`) — 멤버 목록과 챌린지(원본 영상 + 따라찍기 응답)를 앱이 쓰는
  /// [RoomDetail]/[ChallengeDetail] 모양으로 바로 바꿔서 돌려준다.
  ///
  /// 서버엔 댓글 수·좋아요 개념이 아직 없어서 그 자리는 0/false 로 채운다 — 실제로 눌러도
  /// 서버에 반영되진 않는다(로컬 상태에서만 토글된다).
  Future<RoomApiDetailResult> fetchRoomDetail(int roomId) async {
    final res = await _dio.get<Map<String, dynamic>>('/room/$roomId');
    final data = res.data!;

    final memberRows = (data['members'] as List).cast<Map<String, dynamic>>();
    final members = memberRows.map((row) {
      final user = row['user'] as Map<String, dynamic>;
      return ParticipantInfo(
        nickname: (user['nickname'] as String?) ?? '익명',
        profileImageUrl: user['profileImageUrl'] as String?,
        isOwner: row['role'] == 'host',
      );
    }).toList();

    final challengeRows = (data['challenges'] as List).cast<Map<String, dynamic>>();
    final challenges = <RoomChallenge>[];
    final challengeDetails = <ChallengeDetail>[];
    for (final row in challengeRows) {
      final id = (row['id'] as num).toInt();
      final title = (row['title'] as String?) ?? (data['name'] as String);
      final source = _sourceLabel(row['source'] as String);
      final responseRows = (row['responses'] as List).cast<Map<String, dynamic>>();

      challenges.add(
        RoomChallenge(
          id: id,
          title: title,
          source: source,
          submittedCount: responseRows.length,
          totalCount: members.length,
          thumbnailUrl: row['thumbnailUrl'] as String?,
        ),
      );
      challengeDetails.add(
        ChallengeDetail(
          id: id,
          title: title,
          source: source,
          videoUrl: row['videoUrl'] as String?,
          totalCount: members.length,
          submissions: responseRows.map((r) {
            final uploader = r['uploader'] as Map<String, dynamic>;
            return Submission(
              id: (r['id'] as num).toInt(),
              nickname: (uploader['nickname'] as String?) ?? '익명',
              videoUrl: r['videoUrl'] as String?,
              thumbnailUrl: r['thumbnailUrl'] as String?,
            );
          }).toList(),
        ),
      );
    }

    final detail = RoomDetail(
      id: (data['id'] as num).toInt(),
      title: data['name'] as String,
      description: data['description'] as String?,
      isPublic: data['isPublic'] as bool,
      members: members,
      memberCount: (data['memberCount'] as num).toInt(),
      challenges: challenges,
      isOwnedByMe: data['myRole'] == 'host',
      inviteCode: data['inviteCode'] as String?,
    );

    return RoomApiDetailResult(detail: detail, challengeDetails: challengeDetails, isMember: data['isMember'] as bool);
  }

  /// 방에 입장 신청을 보낸다(`POST /room/{id}/join-request`). 이미 멤버거나 이미 대기 중인
  /// 신청이 있으면 서버가 409 로 거절한다 — 그대로 위로 던진다.
  Future<void> applyToRoom(int roomId) async {
    await _dio.post<void>('/room/$roomId/join-request');
  }

  /// 대기 중인 입장 신청 목록(`GET /room/{id}/join-requests`) — 방장만 부를 수 있다.
  Future<List<RoomApiJoinRequest>> fetchJoinRequests(int roomId) async {
    final res = await _dio.get<List<dynamic>>('/room/$roomId/join-requests');
    final items = (res.data ?? const []).cast<Map<String, dynamic>>();
    return items.map((item) {
      final applicant = item['applicant'] as Map<String, dynamic>;
      return RoomApiJoinRequest(
        requestId: (item['id'] as num).toInt(),
        applicant: ParticipantInfo(
          nickname: (applicant['nickname'] as String?) ?? '익명',
          profileImageUrl: applicant['profileImageUrl'] as String?,
        ),
      );
    }).toList();
  }

  /// 입장 신청을 승인/거절한다(`PATCH /room/{id}/join-requests/{requestId}`) — 방장만.
  Future<void> decideJoinRequest(int roomId, int requestId, {required bool approve}) async {
    await _dio.patch<void>('/room/$roomId/join-requests/$requestId', data: {'action': approve ? 'approve' : 'reject'});
  }

  static String _sourceLabel(String videoSource) => switch (videoSource) {
    'youtube' => 'YouTube',
    'instagram' => 'Instagram',
    'tiktok' => 'TikTok',
    'upload' => '직접 업로드',
    _ => '링크',
  };

  /// "이번 주 챌룸 PICK" 목록(`GET /pick-video/weekly`).
  ///
  /// `source` 가 `upload` 면 `videoUrl` 이 서버가 호스팅하는 실제 영상 파일 주소다 —
  /// 유튜브 등과 달리 임베드/인앱 브라우저로 열면 안 되고 네이티브 플레이어로 재생해야
  /// 해서, 그 신호로 [PickVideo.videoUrl] 대신 [PickVideo.assetPath] 에 담는다
  /// ([AssetVideoPlayerScreen] 이 `http(s)://` 로 시작하는 [PickVideo.assetPath] 를
  /// 원격 영상으로 재생할 줄 안다).
  Future<List<PickVideo>> fetchWeeklyPicks() async {
    final res = await _dio.get<List<dynamic>>('/pick-video/weekly');
    final items = (res.data ?? const []).cast<Map<String, dynamic>>();
    return items.map((item) {
      final source = item['source'] as String;
      final url = item['videoUrl'] as String;
      final isUpload = source == 'upload';
      return PickVideo(
        id: (item['id'] as num).toInt(),
        title: item['title'] as String,
        source: _sourceLabel(source),
        videoUrl: isUpload ? null : url,
        assetPath: isUpload ? url : null,
        thumbnailUrl: item['thumbnailUrl'] as String?,
      );
    }).toList();
  }
}
