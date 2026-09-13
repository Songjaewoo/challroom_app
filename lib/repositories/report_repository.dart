import 'package:dio/dio.dart';

import '../models/reports.dart';

/// 인터페이스인 이유는 하나 — 백엔드가 없을 때 `LocalReportRepository` 로 갈아끼워
/// 신고 화면을 기기에서 미리 볼 수 있게 하기 위해서다.
abstract interface class ReportRepository {
  Future<void> submitReport({
    required ReportTargetType targetType,
    required int targetId,
    required ReportReason reason,
    String? detail,
  });
}

class DioReportRepository implements ReportRepository {
  DioReportRepository(this._dio);

  final Dio _dio;

  @override
  Future<void> submitReport({
    required ReportTargetType targetType,
    required int targetId,
    required ReportReason reason,
    String? detail,
  }) async {
    await _dio.post<void>(
      '/reports',
      data: {'targetType': targetType.apiValue, 'targetId': targetId, 'reason': reason.apiValue, 'detail': detail},
    );
  }
}
