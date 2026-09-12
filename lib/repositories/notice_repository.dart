import 'package:dio/dio.dart';

import '../models/notices.dart';

/// 인터페이스인 이유는 하나 — 백엔드가 없을 때 `LocalNoticeRepository` 로 갈아끼워
/// 설정 > 공지사항을 기기에서 미리 볼 수 있게 하기 위해서다.
abstract interface class NoticeRepository {
  /// 최신순으로 온다. 각 항목이 이미 본문을 들고 있어 상세 화면은 따로 조회하지 않는다.
  Future<List<Notice>> fetchNotices();
}

class DioNoticeRepository implements NoticeRepository {
  DioNoticeRepository(this._dio);

  final Dio _dio;

  @override
  Future<List<Notice>> fetchNotices() async {
    final res = await _dio.get<List<dynamic>>('/notices');
    return (res.data ?? const []).map((e) => Notice.fromJson(e as Map<String, dynamic>)).toList();
  }
}
