import 'package:dio/dio.dart';

import '../core/storage/token_storage.dart';
import '../models/auths.dart';
import '../models/enums.dart';

/// 로그인·로그아웃 — 토큰 발급만 담당한다. 유저 정보 조회·수정은 [UserRepository] 몫이다.
///
/// 인터페이스인 이유는 하나 — 백엔드가 없을 때 [LocalAuthRepository] 로 갈아끼워
/// 로그인→프로필 설정→홈 흐름을 기기에서 미리 볼 수 있게 하기 위해서다.
/// (`core/dev/local_backend.dart`, `providers.dart` 참고)
abstract interface class AuthRepository {
  /// 소셜 SDK 로 받은 토큰을 서버에 넘겨 앱 토큰과 유저를 받는다.
  Future<AuthResult> signIn(SocialProvider provider, SocialLoginReq req);

  Future<void> signOut();
}

class DioAuthRepository implements AuthRepository {
  DioAuthRepository(this._dio, this._tokenStorage);

  final Dio _dio;
  final TokenStorage _tokenStorage;

  @override
  Future<AuthResult> signIn(SocialProvider provider, SocialLoginReq req) async {
    final res = await _dio.post<Map<String, dynamic>>('/auth/${provider.apiPath}/login', data: req.toJson());
    return AuthResult.fromJson(res.data!);
  }

  @override
  Future<void> signOut() async {
    // 서버가 리프레시 토큰을 무효화하려면 그 토큰이 뭔지 알아야 한다 — 몸에 실어 보낸다.
    final refreshToken = await _tokenStorage.readRefreshToken();
    if (refreshToken == null) return;
    await _dio.post<void>('/auth/logout', data: {'refresh_token': refreshToken});
  }
}
