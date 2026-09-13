import 'package:dio/dio.dart';

import '../error/api_exception.dart';
import '../storage/token_storage.dart';

/// 요청에 인증 헤더를 붙이고, 응답에서 알맹이를 꺼내고, 실패를 [ApiException] 으로 바꾼다.
///
/// **서버 규약이 바뀌면 이 파일 하나만 고친다.** Repository 마다 `res.data['data']` 를
/// 반복하거나 `DioException` 을 해석하는 코드가 생기면 안 된다.
class ApiInterceptor extends Interceptor {
  ApiInterceptor(this._tokenStorage);

  final TokenStorage _tokenStorage;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _tokenStorage.readAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    // 서버가 { "data": ... } 로 감싸 보내면 여기서 한 번만 벗긴다.
    // 감싸지 않는 서버라면 이 블록을 지우면 된다 — Repository 는 그대로 둔다.
    final body = response.data;
    if (body is Map<String, dynamic> && body.containsKey('data')) {
      response.data = body['data'];
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: _toAppException(err),
      ),
    );
  }

  Object _toAppException(DioException err) {
    final response = err.response;
    if (response == null) return const NetworkException();

    final body = response.data;
    final error = body is Map<String, dynamic> ? body : const <String, dynamic>{};

    return ApiException(
      statusCode: response.statusCode ?? 0,
      // 서버의 에러 응답(`ErrorResponse`)은 코드를 `error` 필드에 담아 보낸다(`code` 가 아니다).
      code: error['error'] as String? ?? 'UNKNOWN',
      message: error['message'] as String? ?? _defaultMessage(response.statusCode),
    );
  }

  String _defaultMessage(int? statusCode) => switch (statusCode) {
    400 => '요청이 올바르지 않아요.',
    401 => '로그인이 필요해요.',
    403 => '권한이 없어요.',
    404 => '찾을 수 없어요.',
    409 => '이미 처리된 요청이에요.',
    _ => '잠시 후 다시 시도해 주세요.',
  };
}
