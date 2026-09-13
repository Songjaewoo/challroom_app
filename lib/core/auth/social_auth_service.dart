import '../../models/enums.dart';
import '../error/api_exception.dart';
import 'google_social_auth_service.dart';
import 'kakao_social_auth_service.dart';
import 'naver_social_auth_service.dart';

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

/// 제공자별로 실제 SDK 연동 여부가 다른 과도기 상태를 표현한다 — 지금은 네이버·카카오·구글이
/// 실제 SDK([NaverSocialAuthService]/[KakaoSocialAuthService]/[GoogleSocialAuthService])로
/// 붙어 있고, 애플만 [fallback](로컬 모드는 가짜 토큰, 실서버 모드는
/// [UnavailableSocialAuthService])으로 넘긴다. 애플을 붙일 때 이 자리에 분기만 추가하면 된다.
class HybridSocialAuthService implements SocialAuthService {
  const HybridSocialAuthService({required this.fallback});

  final SocialAuthService fallback;

  @override
  Future<String> obtainAccessToken(SocialProvider provider) {
    switch (provider) {
      case SocialProvider.naver:
        return const NaverSocialAuthService().obtainAccessToken(provider);
      case SocialProvider.kakao:
        return const KakaoSocialAuthService().obtainAccessToken(provider);
      case SocialProvider.google:
        return const GoogleSocialAuthService().obtainAccessToken(provider);
      case SocialProvider.apple:
        return fallback.obtainAccessToken(provider);
    }
  }
}
