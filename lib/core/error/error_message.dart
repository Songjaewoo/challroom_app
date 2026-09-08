import 'api_exception.dart';

/// 예외를 사용자 문구로 바꾼다. 화면마다 문구를 짓지 않는다.
extension ErrorMessageX on Object {
  String toUserMessage() => switch (this) {
    ApiException(:final message) => message,
    SocialAuthException(:final message) => message,
    NetworkException() => '네트워크 연결을 확인해 주세요.',
    _ => '알 수 없는 오류가 발생했습니다.',
  };
}
