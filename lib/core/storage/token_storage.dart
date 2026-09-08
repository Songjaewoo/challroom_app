import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// 인증 토큰 보관소. flutter_secure_storage 를 감싸 키 문자열을 한 곳에 가둔다.
///
/// 저장 위치가 바뀌어도 이 파일만 고치면 된다.
class TokenStorage {
  const TokenStorage();

  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  // v11 기본값이 이미 AES-GCM + KeyStore 다 — 옵션을 따로 주지 않는다.
  static const _storage = FlutterSecureStorage();

  Future<String?> readAccessToken() => _storage.read(key: _accessTokenKey);

  Future<String?> readRefreshToken() => _storage.read(key: _refreshTokenKey);

  Future<void> saveTokens({required String accessToken, String? refreshToken}) async {
    await _storage.write(key: _accessTokenKey, value: accessToken);
    if (refreshToken != null) {
      await _storage.write(key: _refreshTokenKey, value: refreshToken);
    }
  }

  Future<void> clear() => _storage.deleteAll();
}
