import 'package:dio/dio.dart';

import '../error/api_exception.dart';
import '../storage/token_storage.dart';
import 'api_interceptor.dart';

/// 앱이 쓰는 유일한 [Dio] 구현.
///
/// [ApiInterceptor] 가 [DioException.error] 에 담아 준 앱 예외를 여기서 꺼내 던진다.
/// 덕분에 Repository 위쪽으로는 `DioException` 이 절대 새지 않는다 (절대 규칙 2).
class ApiDio with DioMixin implements Dio {
  ApiDio(BaseOptions options) {
    this.options = options;
    httpClientAdapter = HttpClientAdapter();
  }

  @override
  Future<Response<T>> fetch<T>(RequestOptions requestOptions) async {
    try {
      return await super.fetch<T>(requestOptions);
    } on DioException catch (e) {
      final error = e.error;
      if (error is ApiException || error is NetworkException) throw error!;
      throw const NetworkException();
    }
  }
}

/// 서버 주소는 코드에 박지 않는다 — `--dart-define=API_BASE_URL=...` 로 주입한다.
const apiBaseUrl = String.fromEnvironment('API_BASE_URL');

Dio createDio(TokenStorage tokenStorage) {
  final dio = ApiDio(
    BaseOptions(
      // 서버 라우트가 전부 `/v1` 아래에 있다 — 호출부는 매번 안 붙이고 여기서 한 번에 더한다.
      baseUrl: apiBaseUrl.isEmpty ? '' : '$apiBaseUrl/v1',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      contentType: Headers.jsonContentType,
    ),
  );

  dio.interceptors.add(ApiInterceptor(tokenStorage));
  return dio;
}
