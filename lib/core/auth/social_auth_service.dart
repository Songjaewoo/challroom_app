import '../../models/enums.dart';
import '../error/api_exception.dart';

/// 소셜 SDK 로 로그인해 **서버에 넘길 액세스 토큰**을 받아오는 자리.
///
/// 네이티브 SDK 연동이 필요한 유일한 지점이다. 카카오/네이버/구글/애플 SDK 를 붙일 때
/// 이 인터페이스를 구현하고 `socialAuthServiceProvider` 만 갈아끼우면 된다 —
/// Controller / Screen 은 고칠 게 없다.
abstract interface class SocialAuthService {
  Future<String> obtainAccessToken(SocialProvider provider);
}

/// SDK 를 붙이기 전까지 쓰는 구현. 누르면 "아직 연결 전"이라고 정직하게 알린다.
class UnavailableSocialAuthService implements SocialAuthService {
  const UnavailableSocialAuthService();

  @override
  Future<String> obtainAccessToken(SocialProvider provider) async {
    throw SocialAuthException('${provider.label} 로그인은 아직 연결 전이에요.');
  }
}
