import 'package:google_sign_in/google_sign_in.dart';

import '../../models/enums.dart';
import '../error/api_exception.dart';
import 'social_auth_service.dart';

/// 구글 로그인 SDK([google_sign_in])를 직접 붙인 구현.
///
/// 다른 제공자와 달리 서버(`challroom_api`)가 검증하는 값은 액세스 토큰이 아니라
/// **ID 토큰**이다 — `google_flutter_sdk` 가 아니라 이 값을 `SocialLoginReq.accessToken`
/// 자리에 담아 보낸다. `GoogleSignIn.instance.initialize(...)` 가 `main.dart` 에서
/// 앱 시작 시 미리 호출돼 있어야 한다.
class GoogleSocialAuthService implements SocialAuthService {
  const GoogleSocialAuthService();

  @override
  Future<String> obtainAccessToken(SocialProvider provider) async {
    try {
      final account = await GoogleSignIn.instance.authenticate();
      final idToken = account.authentication.idToken;
      if (idToken == null) {
        throw const SocialAuthException('구글 로그인에 실패했어요. 다시 시도해 주세요.');
      }
      return idToken;
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        throw const SocialAuthException('구글 로그인을 취소했어요.');
      }
      throw SocialAuthException(e.description ?? '구글 로그인에 실패했어요.');
    }
  }
}
