import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

/// 앱 전체에서 쓰는 확인 창 — 기본 `AlertDialog` 흰 카드 대신 이 모양(다크 카드 + 취소/확인
/// 버튼 두 개)으로 통일한다. "신청" 확인 창에서 처음 만든 모양을 다른 확인 창(멤버 내보내기,
/// 신청 거절 등)에도 그대로 쓴다. `true` 를 반환하면 확인, 그 외(취소·바깥 탭으로 닫힘)는
/// `false` 다.
/// [destructive] 는 남에게 영향을 주는 거절/제거처럼 되돌리기 애매한 부정적 액션일 때
/// `true` — 확인 버튼이 진행형 CTA(핑크) 대신 [AppColors.danger] 로 바뀐다.
Future<bool> showAppConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  required String confirmLabel,
  String cancelLabel = '취소',
  bool destructive = false,
}) async {
  final confirmed = await showDialog<bool>(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.6),
    builder: (dialogContext) => _AppConfirmDialog(
      title: title,
      message: message,
      confirmLabel: confirmLabel,
      cancelLabel: cancelLabel,
      destructive: destructive,
    ),
  );
  return confirmed ?? false;
}

class _AppConfirmDialog extends StatelessWidget {
  const _AppConfirmDialog({
    required this.title,
    required this.message,
    required this.confirmLabel,
    required this.cancelLabel,
    required this.destructive,
  });

  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 32),
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
        decoration: BoxDecoration(color: AppColors.accentSoft, borderRadius: BorderRadius.circular(22)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.ink)),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14.5, color: AppColors.inkMuted, height: 1.45),
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.inkMuted,
                      side: const BorderSide(color: AppColors.border),
                      minimumSize: const Size.fromHeight(46),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(cancelLabel),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FilledButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(46),
                      backgroundColor: destructive ? AppColors.danger : null,
                    ),
                    child: Text(confirmLabel),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
