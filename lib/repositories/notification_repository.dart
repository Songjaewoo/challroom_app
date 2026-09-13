import 'package:dio/dio.dart';

import '../models/notifications.dart';

/// 인터페이스인 이유는 하나 — 백엔드가 없을 때 `LocalNotificationRepository` 로 갈아끼워
/// 알림함을 기기에서 미리 볼 수 있게 하기 위해서다.
abstract interface class NotificationRepository {
  /// 최신순으로 온다.
  Future<List<AppNotification>> fetchNotifications();

  /// 알림함을 열면 전부 읽음 처리한다 — 벨 아이콘의 안 읽은 개수 배지가 이 값을 본다.
  Future<void> markAllRead();

  /// 로컬 개발 모드 전용 — 실제 서버라면 알림은 푸시/소켓으로 서버가 내려주지, 클라이언트가
  /// 직접 만들어 넣지 않는다. 그래서 [DioNotificationRepository] 에서는 아무 일도 안 한다.
  /// (신청 수락처럼) 이 세션 안에서 실제로 일어난 일을 알림함에도 바로 반영하려고 둔 것.
  Future<void> add({required NotificationKind kind, required String message, int? roomId});
}

class DioNotificationRepository implements NotificationRepository {
  DioNotificationRepository(this._dio);

  final Dio _dio;

  @override
  Future<List<AppNotification>> fetchNotifications() async {
    final res = await _dio.get<List<dynamic>>('/notifications');
    return (res.data ?? const []).map((e) => AppNotification.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<void> markAllRead() async {
    await _dio.post<void>('/notifications/read-all');
  }

  @override
  Future<void> add({required NotificationKind kind, required String message, int? roomId}) async {
    // 실제 서버는 알림을 자기가 만들어 푸시하지, 클라이언트가 만들어 달라고 하지 않는다.
  }
}
