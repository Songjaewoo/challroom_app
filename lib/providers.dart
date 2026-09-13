import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'core/auth/social_auth_service.dart';
import 'core/dev/local_backend.dart';
import 'core/dev/local_comment_repository.dart';
import 'core/dev/local_faq_repository.dart';
import 'core/dev/local_notice_repository.dart';
import 'core/dev/local_notification_repository.dart';
import 'core/dev/local_report_repository.dart';
import 'core/dev/local_room_repository.dart';
import 'core/network/dio_client.dart';
import 'core/network/room_api_client.dart';
import 'core/storage/token_storage.dart';
import 'repositories/auth_repository.dart';
import 'repositories/comment_repository.dart';
import 'repositories/faq_repository.dart';
import 'repositories/notice_repository.dart';
import 'repositories/notification_repository.dart';
import 'repositories/report_repository.dart';
import 'repositories/room_repository.dart';
import 'repositories/user_repository.dart';

part 'providers.g.dart';

// Repository provider 는 전부 이 파일에 모은다.
// Controller provider 는 @riverpod 이 클래스에 붙으므로 Controller 파일에 남는다.

@Riverpod(keepAlive: true)
TokenStorage tokenStorage(Ref ref) => const TokenStorage();

@Riverpod(keepAlive: true)
Dio dio(Ref ref) => createDio(ref.watch(tokenStorageProvider));

/// `API_BASE_URL` 이 없으면(지금 상태) 서버 없이도 로그인→프로필 설정→홈 흐름을
/// 미리 볼 수 있게 메모리 전용 가짜 백엔드를 쓴다. `--dart-define=API_BASE_URL=...` 로
/// 실제 서버를 넘기면 이 provider 들은 자동으로 Dio 구현으로 돌아간다.
@Riverpod(keepAlive: true)
LocalDevBackend localDevBackend(Ref ref) => LocalDevBackend();

/// 지금은 네이버만 실제 SDK 로 붙어 있다 — [HybridSocialAuthService] 가 provider 별로
/// 그 하나만 진짜로 보내고 나머지는 기존 방식(로컬 모드는 가짜 토큰, 실서버 모드는
/// "아직 연결 전" 에러)으로 넘긴다.
@Riverpod(keepAlive: true)
SocialAuthService socialAuthService(Ref ref) => HybridSocialAuthService(
  fallback: apiBaseUrl.isEmpty ? const LocalSocialAuthService() : const UnavailableSocialAuthService(),
);

/// 로그인은 실제 서버(`challroom_api`)의 `/v1/auth` 라우터가 이미 구현돼 있어서, 다른
/// 도메인과 달리 `apiBaseUrl` 이 있으면 바로 Dio 로 갈아탄다.
@riverpod
AuthRepository authRepository(Ref ref) => apiBaseUrl.isEmpty
    ? LocalAuthRepository(ref.watch(localDevBackendProvider))
    : DioAuthRepository(ref.watch(dioProvider), ref.watch(tokenStorageProvider));

@riverpod
UserRepository userRepository(Ref ref) => apiBaseUrl.isEmpty
    ? LocalUserRepository(ref.watch(localDevBackendProvider))
    : DioUserRepository(ref.watch(dioProvider));

// 아래 여섯 개(방/댓글/공지/FAQ/알림/신고)는 서버 쪽에 아직 이 앱이 기대하는 모양의
// 라우터가 없거나(댓글·공지·FAQ·알림·신고는 라우터 자체가 없고, 방은 있어도 경로/응답
// 모양이 많이 다르다) 반쪽만 구현돼 있다. `apiBaseUrl` 을 채워 로그인만 실제 서버로
// 테스트할 때 이 화면들까지 같이 깨지면 안 되니, 서버 쪽 작업이 끝날 때까지는
// `apiBaseUrl` 과 무관하게 전부 로컬 목업을 쓴다 — 각자 준비되면 이 줄만 위 두 개처럼
// `apiBaseUrl.isEmpty ? Local... : Dio...` 로 되돌린다.
//
// 방 만들기만 예외다 — 화면 전체를 실서버로 옮기진 않지만(목록·상세 모양이 아직 안 맞다),
// `createRoom` 하나만은 [RoomApiClient] 를 같이 넘겨 실제 서버에도 방을 만들어본다
// (`LocalRoomRepository.createRoom` 참고).

/// 로컬 모드에서는 방 만들기로 생긴 방을 기억해야 해서 `keepAlive` 다 — 화면을 옮겨 다녀도
/// [LocalRoomRepository] 인스턴스가(그리고 그 안의 상태가) 계속 살아있어야 한다.
@Riverpod(keepAlive: true)
RoomRepository roomRepository(Ref ref) => LocalRoomRepository(
  ref.watch(userRepositoryProvider),
  apiClient: apiBaseUrl.isEmpty ? null : RoomApiClient(ref.watch(dioProvider)),
);

/// 방 목록과 마찬가지로 작성한 댓글이 화면을 옮겨도 남아있어야 해서 `keepAlive` 다.
@Riverpod(keepAlive: true)
CommentRepository commentRepository(Ref ref) => LocalCommentRepository(ref.watch(userRepositoryProvider));

@riverpod
NoticeRepository noticeRepository(Ref ref) => const LocalNoticeRepository();

@riverpod
FaqRepository faqRepository(Ref ref) => const LocalFaqRepository();

/// 신청 수락처럼 이 세션 안에서 실제로 생긴 알림을 쌓아둬야 해서 `keepAlive` 다 — 방/댓글
/// 저장소와 같은 이유.
@Riverpod(keepAlive: true)
NotificationRepository notificationRepository(Ref ref) => LocalNotificationRepository();

@riverpod
ReportRepository reportRepository(Ref ref) => LocalReportRepository();
