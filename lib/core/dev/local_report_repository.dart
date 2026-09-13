import '../../models/reports.dart';
import '../../repositories/report_repository.dart';

/// `API_BASE_URL` 이 없을 때(지금 상태) 신고 화면을 미리 보기 위한 로컬 구현 — 실제로 어디
/// 보내지는 않고 잠깐 기다렸다가 성공으로 끝낸다. 제출된 신고를 쌓아두기만 한다(다른 화면이
/// 이 값을 보진 않는다 — 그럴 일이 생기면(예: "신고 완료" 배지) 여기서 꺼내 쓰면 된다).
class LocalReportRepository implements ReportRepository {
  final _submitted = <({ReportTargetType targetType, int targetId, ReportReason reason, String? detail})>[];

  @override
  Future<void> submitReport({
    required ReportTargetType targetType,
    required int targetId,
    required ReportReason reason,
    String? detail,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    _submitted.add((targetType: targetType, targetId: targetId, reason: reason, detail: detail));
  }
}
