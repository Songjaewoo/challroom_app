import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/reports.dart';
import '../providers.dart';

part 'report_controller.g.dart';

/// [ReportScreen] 하나를 위한 제출 액션 상태.
@riverpod
class ReportSubmit extends _$ReportSubmit {
  @override
  Future<void> build() async {}

  Future<void> submit({
    required ReportTargetType targetType,
    required int targetId,
    required ReportReason reason,
    String? detail,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(reportRepositoryProvider)
          .submitReport(targetType: targetType, targetId: targetId, reason: reason, detail: detail),
    );
  }
}
