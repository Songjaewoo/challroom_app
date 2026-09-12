import 'package:dio/dio.dart';

import '../models/faqs.dart';

/// 인터페이스인 이유는 하나 — 백엔드가 없을 때 `LocalFaqRepository` 로 갈아끼워
/// 설정 > 자주 묻는 질문을 기기에서 미리 볼 수 있게 하기 위해서다.
abstract interface class FaqRepository {
  /// 각 항목이 이미 답변을 들고 있어 상세 화면은 따로 조회하지 않는다.
  Future<List<Faq>> fetchFaqs();
}

class DioFaqRepository implements FaqRepository {
  DioFaqRepository(this._dio);

  final Dio _dio;

  @override
  Future<List<Faq>> fetchFaqs() async {
    final res = await _dio.get<List<dynamic>>('/faqs');
    return (res.data ?? const []).map((e) => Faq.fromJson(e as Map<String, dynamic>)).toList();
  }
}
