import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/room_apply_controller.dart';
import '../../../core/error/error_message.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/confirm_dialog.dart';

/// "신청" 배지를 누르면 뜨는 확인 창 — 확인하면 실제로 신청 상태가 저장돼 "내 방" 목록에도
/// 신청 중인 채로 나타난다.
Future<void> showApplyConfirmDialog(BuildContext context, {required int roomId, required String roomTitle}) async {
  final confirmed = await showAppConfirmDialog(
    context,
    title: '참가 신청',
    message: '"$roomTitle" 방에 참가 신청을 보낼까요?\n방장이 수락하면 함께할 수 있어요.',
    confirmLabel: '신청하기',
  );
  if (!confirmed || !context.mounted) return;

  final container = ProviderScope.containerOf(context);
  await container.read(roomApplyProvider(roomId).notifier).apply();
  if (!context.mounted) return;

  final result = container.read(roomApplyProvider(roomId));
  _showToast(
    context,
    result.hasError ? result.error!.toUserMessage() : '참가 신청을 보냈어요. 방장이 수락하면 알려드릴게요.',
    isError: result.hasError,
  );
}

/// "신청취소" 배지를 누르면 뜨는 확인 창.
Future<void> showCancelApplicationDialog(
  BuildContext context, {
  required int roomId,
  required String roomTitle,
}) async {
  final confirmed = await showAppConfirmDialog(
    context,
    title: '신청 취소',
    message: '"$roomTitle" 방에 보낸 참가 신청을 취소할까요?',
    confirmLabel: '신청 취소하기',
  );
  if (!confirmed || !context.mounted) return;

  final container = ProviderScope.containerOf(context);
  await container.read(roomApplyProvider(roomId).notifier).cancel();
  if (!context.mounted) return;

  final result = container.read(roomApplyProvider(roomId));
  _showToast(context, result.hasError ? result.error!.toUserMessage() : '참가 신청을 취소했어요.', isError: result.hasError);
}

/// 밑에서 뜨는 토스트 — 기본 스낵바처럼 글자만 덜렁 있는 대신, 결과를 아이콘으로도 같이 보여준다.
/// 배경·모양은 [AppTheme] 의 `snackBarTheme` 을 그대로 따른다.
void _showToast(BuildContext context, String message, {required bool isError}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline_rounded : Icons.check_circle_rounded,
              size: 20,
              color: isError ? AppColors.inkMuted : AppColors.success,
            ),
            const SizedBox(width: 10),
            Expanded(child: Text(message)),
          ],
        ),
      ),
    );
}
