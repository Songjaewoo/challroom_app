import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import '../../models/enums.dart';
import '../error/api_exception.dart';
import 'social_auth_service.dart';

/// 카카오 로그인 SDK([kakao_flutter_sdk_user])를 직접 붙인 구현.
///
/// 네이티브 쪽 설정(`ios/Runner/Info.plist` 의 `CFBundleURLTypes`/`LSApplicationQueriesSchemes`,
/// `SceneDelegate.swift` 의 콜백 처리, `main.dart` 의 `KakaoSdk.init`)이 맞아야 실제로 동작한다.
class KakaoSocialAuthService implements SocialAuthService {
  const KakaoSocialAuthService();

  @override
  Future<String> obtainAccessToken(SocialProvider provider) async {
    try {
      // 카카오톡 앱이 깔려 있으면 그쪽으로, 없으면 카카오 계정(웹) 로그인으로 — SDK 가
      // 권장하는 표준 분기다.
      final installed = await isKakaoTalkInstalled();
      final token = installed ? await UserApi.instance.loginWithKakaoTalk() : await UserApi.instance.loginWithKakaoAccount();
      return token.accessToken;
    } on KakaoAuthException catch (e) {
      // 카카오 계정(웹) 로그인 화면에서 취소하면 이 예외로 온다(`AuthErrorCause.accessDenied`).
      if (e.error == AuthErrorCause.accessDenied) {
        throw const SocialAuthException('카카오 로그인을 취소했어요.');
      }
      throw SocialAuthException(e.errorDescription ?? '카카오 로그인에 실패했어요.');
    } on KakaoClientException catch (e) {
      // 카카오톡 앱으로 로그인하다 취소하면 이 예외로 온다(`ClientErrorCause.cancelled`).
      if (e.reason == ClientErrorCause.cancelled) {
        throw const SocialAuthException('카카오 로그인을 취소했어요.');
      }
      throw SocialAuthException(e.msg);
    } catch (e) {
      throw const SocialAuthException('카카오 로그인에 실패했어요. 다시 시도해 주세요.');
    }
  }
}
