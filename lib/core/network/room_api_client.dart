import 'package:dio/dio.dart';

import '../../models/enums.dart';
import '../../models/rooms.dart';

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

/// 실제 서버(`challroom_api`)의 방 생성/공개방 목록 API만 얇게 감싼 클라이언트.
///
/// [RoomRepository] 전체를 실서버로 옮기기엔 서버 쪽 모양이 앱이 기대하는 것과 많이
/// 다르다(해시태그·카테고리·진행상태 없음, 방 상세는 멤버·챌린지가 통째로 다른 모양 등 —
/// `providers.dart` 의 설명 참고). 그래서 지금은 방 생성과 공개방 목록만 이 클라이언트로
/// 붙이고, 나머지(상세·댓글·좋아요 등)는 여전히 [LocalRoomRepository] 의 로컬 상태를 쓴다.
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
}
