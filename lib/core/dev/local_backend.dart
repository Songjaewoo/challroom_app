import 'package:image_picker/image_picker.dart';

import '../../models/auths.dart';
import '../../models/enums.dart';
import '../../models/users.dart';
import '../../repositories/auth_repository.dart';
import '../../repositories/user_repository.dart';
import '../auth/social_auth_service.dart';
import '../error/api_exception.dart';

/// `API_BASE_URL` 이 없을 때만 켜지는 메모리 전용 가짜 백엔드.
///
/// 실제 서버·소셜 SDK 가 붙기 전까지 로그인 → 프로필 설정 → 홈 흐름을
/// 기기에서 그대로 눌러 볼 수 있게 한다. 앱을 다시 켜면 초기화된다 — 영구 저장이
/// 필요하면 실제 백엔드를 붙이면 된다(그 순간 `providers.dart` 가 자동으로
/// [DioAuthRepository]/[DioUserRepository] 로 되돌아간다. 이 파일은 안 건드려도 된다).
class LocalDevBackend {
  User? _user;
  var _nextId = 1;

  Future<User> signIn(SocialProvider provider) async {
    final user = User(id: _nextId++, provider: provider);
    _user = user;
    return user;
  }

  Future<void> signOut() async => _user = null;

  Future<User> fetchMe() async => _user ?? (throw _notSignedIn);

  Future<User> updateProfile(ProfileUpdateReq req) async {
    final current = _user ?? (throw _notSignedIn);
    final updated = current.copyWith(
      nickname: req.nickname,
      profileImageUrl: req.profileImageUrl ?? current.profileImageUrl,
    );
    _user = updated;
    return updated;
  }

  /// 올릴 서버가 없으니 로컬 파일 경로를 그대로 "URL" 처럼 돌려준다 — 미리보기 목적.
  Future<String> uploadAvatar(XFile image) async => image.path;

  static const _notSignedIn = ApiException(statusCode: 401, code: 'NOT_SIGNED_IN', message: '로그인이 필요해요.');
}

/// 소셜 SDK 없이도 즉시 성공한다 — [LocalDevBackend] 와 짝지어 쓴다.
class LocalSocialAuthService implements SocialAuthService {
  const LocalSocialAuthService();

  @override
  Future<String> obtainAccessToken(SocialProvider provider) async => 'local-dev-token';
}

class LocalAuthRepository implements AuthRepository {
  LocalAuthRepository(this._backend);

  final LocalDevBackend _backend;

  @override
  Future<AuthResult> signIn(SocialProvider provider, SocialLoginReq req) async {
    final user = await _backend.signIn(provider);
    return AuthResult(
      user: user,
      tokens: const AuthTokens(accessToken: 'local-dev-token'),
    );
  }

  @override
  Future<void> signOut() => _backend.signOut();
}

class LocalUserRepository implements UserRepository {
  LocalUserRepository(this._backend);

  final LocalDevBackend _backend;

  @override
  Future<User> fetchMe() => _backend.fetchMe();

  @override
  Future<User> updateProfile(ProfileUpdateReq req) => _backend.updateProfile(req);

  @override
  Future<String> uploadAvatar(XFile image) => _backend.uploadAvatar(image);
}
