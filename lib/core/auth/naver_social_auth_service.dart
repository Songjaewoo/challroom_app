import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:flutter_naver_login/interface/types/naver_login_status.dart';

import '../../models/enums.dart';
import '../error/api_exception.dart';
import 'social_auth_service.dart';

/// 네이버 로그인 SDK([flutter_naver_login])를 직접 붙인 구현.
///
/// 네이티브 쪽 설정(`ios/Runner/Info.plist` 의 `Nid*` 키, URL Scheme, iOS 는
/// `SceneDelegate.swift` 의 콜백 처리)이 맞아야 실제로 동작한다.
class NaverSocialAuthService implements SocialAuthService {
  const NaverSocialAuthService();

  @override
  Future<String> obtainAccessToken(SocialProvider provider) async {
    final result = await FlutterNaverLogin.logIn();

    switch (result.status) {
      case NaverLoginStatus.loggedIn:
        final token = result.accessToken?.accessToken;
        if (token == null || token.isEmpty) {
          throw const SocialAuthException('네이버 로그인에 실패했어요. 다시 시도해 주세요.');
        }
        return token;
      case NaverLoginStatus.loggedOut:
        throw const SocialAuthException('네이버 로그인을 취소했어요.');
      case NaverLoginStatus.error:
        throw SocialAuthException(result.errorMessage ?? '네이버 로그인에 실패했어요.');
    }
  }
}
