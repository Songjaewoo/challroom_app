import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'core/auth/social_auth_service.dart';
import 'core/dev/local_backend.dart';
import 'core/dev/local_room_repository.dart';
import 'core/network/dio_client.dart';
import 'core/storage/token_storage.dart';
import 'repositories/auth_repository.dart';
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

/// 소셜 SDK 를 붙이면 `UnavailableSocialAuthService` 자리를 새 구현으로 바꾼다.
@Riverpod(keepAlive: true)
SocialAuthService socialAuthService(Ref ref) =>
    apiBaseUrl.isEmpty ? const LocalSocialAuthService() : const UnavailableSocialAuthService();

@riverpod
AuthRepository authRepository(Ref ref) => apiBaseUrl.isEmpty
    ? LocalAuthRepository(ref.watch(localDevBackendProvider))
    : DioAuthRepository(ref.watch(dioProvider));

@riverpod
UserRepository userRepository(Ref ref) => apiBaseUrl.isEmpty
    ? LocalUserRepository(ref.watch(localDevBackendProvider))
    : DioUserRepository(ref.watch(dioProvider));

@riverpod
RoomRepository roomRepository(Ref ref) =>
    apiBaseUrl.isEmpty ? const LocalRoomRepository() : DioRoomRepository(ref.watch(dioProvider));
