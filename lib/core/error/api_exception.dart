/// 서버가 응답을 돌려줬지만 실패인 경우.
///
/// `DioException` → `ApiException` 변환은 [ApiInterceptor] 한 곳에서만 한다.
/// Repository / Controller / Screen 어디에도 `DioException` 이 나오면 안 된다.
class ApiException implements Exception {
  const ApiException({required this.statusCode, required this.code, required this.message});

  /// HTTP 상태 코드. 응답을 못 받은 경우는 [NetworkException] 이므로 항상 실제 코드다.
  final int statusCode;

  /// 서버가 준 에러 코드. 분기는 Controller 에서만 한다.
  final String code;

  /// 사용자에게 보일 문구.
  final String message;

  @override
  String toString() => 'ApiException($statusCode $code): $message';
}

/// 응답 자체를 받지 못한 경우 — 타임아웃, 연결 실패, 요청 취소.
class NetworkException implements Exception {
  const NetworkException();

  @override
  String toString() => 'NetworkException';
}

/// 소셜 SDK 단계에서 실패한 경우 — 사용자 취소, SDK 미연동, 토큰 발급 실패.
/// 서버와 무관하므로 [ApiException] 이 아니다.
class SocialAuthException implements Exception {
  const SocialAuthException(this.message);

  final String message;

  @override
  String toString() => 'SocialAuthException: $message';
}
