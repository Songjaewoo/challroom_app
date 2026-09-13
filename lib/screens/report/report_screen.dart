import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../controllers/report_controller.dart';
import '../../core/error/error_message.dart';
import '../../core/theme/app_theme.dart';
import '../../models/reports.dart';

/// [ReportScreen] 으로 라우팅할 때 `extra` 로 넘기는 값.
typedef ReportScreenArgs = ({ReportTarget target, String targetLabel});

/// 영상 신고 화면 — 챌린지 원본 영상이든 제출 영상이든 [target] 만 다르고 흐름은 같다.
/// 사유를 고르고(필수) 자세한 내용을 적은 뒤(선택) 접수하면, 같은 화면 안에서 접수 완료
/// 상태로 바뀐다 — 팝 타이밍과 스낵바가 꼬이는 걸 피하려고 화면을 두 상태로 나눈다.
class ReportScreen extends ConsumerStatefulWidget {
  const ReportScreen({required this.target, required this.targetLabel, super.key});

  final ReportTarget target;

  /// 위에 "무엇을 신고하는지" 보여줄 이름 — "우리끼리 텐션 챌린지" 나 "민지님 영상" 처럼.
  final String targetLabel;

  @override
  ConsumerState<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends ConsumerState<ReportScreen> {
  final _detailController = TextEditingController();
  ReportReason? _selectedReason;
  var _submitted = false;

  @override
  void dispose() {
    _detailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final busy = ref.watch(reportSubmitProvider).isLoading;

    return Scaffold(
      appBar: AppBar(title: const Text('신고하기')),
      body: SafeArea(
        child: _submitted ? _SubmittedView(onClose: () => context.pop()) : _buildForm(context, busy),
      ),
    );
  }

  Widget _buildForm(BuildContext context, bool busy) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 24),
      children: [
        Text(
          '"${widget.targetLabel}"',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.ink),
        ),
        const SizedBox(height: 2),
        const Text('을(를) 신고합니다. 신고 사유를 골라주세요.', style: TextStyle(fontSize: 13.5, color: AppColors.inkFaint)),
        const SizedBox(height: 16),
        DecoratedBox(
          decoration: BoxDecoration(color: AppColors.accentSoft, borderRadius: BorderRadius.circular(14)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: RadioGroup<ReportReason>(
              groupValue: _selectedReason,
              onChanged: (reason) {
                if (!busy) setState(() => _selectedReason = reason);
              },
              child: Column(
                children: [
                  for (var i = 0; i < ReportReason.values.length; i++) ...[
                    RadioListTile<ReportReason>(
                      value: ReportReason.values[i],
                      activeColor: AppColors.primary,
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                      title: Text(
                        ReportReason.values[i].label,
                        style: const TextStyle(fontSize: 15, color: AppColors.ink),
                      ),
                    ),
                    if (i != ReportReason.values.length - 1)
                      const Divider(height: 0.5, thickness: 0.5, color: AppColors.border),
                  ],
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          '자세한 내용 (선택)',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.inkMuted),
        ),
        const SizedBox(height: 7),
        TextField(
          controller: _detailController,
          enabled: !busy,
          minLines: 3,
          maxLines: 6,
          style: const TextStyle(fontSize: 15.5),
          decoration: const InputDecoration(hintText: '어떤 부분이 문제인지 적어주시면 검토에 도움이 돼요.'),
        ),
        const SizedBox(height: 24),
        // 다른 사람의 콘텐츠에 영향을 주는 액션이라 "내보내기/거절" 과 같은 danger 색을 쓴다.
        FilledButton(
          onPressed: busy || _selectedReason == null ? null : _submit,
          style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
          child: busy
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.onBrand),
                )
              : const Text('신고 접수하기'),
        ),
      ],
    );
  }

  Future<void> _submit() async {
    final reason = _selectedReason;
    if (reason == null) return;

    final detail = _detailController.text.trim();
    await ref
        .read(reportSubmitProvider.notifier)
        .submit(
          targetType: widget.target.type,
          targetId: widget.target.id,
          reason: reason,
          detail: detail.isEmpty ? null : detail,
        );
    if (!mounted) return;

    if (ref.read(reportSubmitProvider).hasError) {
      final error = ref.read(reportSubmitProvider).error!;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(error.toUserMessage())));
      return;
    }

    setState(() => _submitted = true);
  }
}

class _SubmittedView extends StatelessWidget {
  const _SubmittedView({required this.onClose});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle_rounded, size: 52, color: AppColors.success),
          const SizedBox(height: 16),
          const Text(
            '신고가 접수됐어요',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.ink),
          ),
          const SizedBox(height: 8),
          const Text(
            '검토 후 필요한 조치를 진행할게요.\n신고해 주셔서 감사해요.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.5, color: AppColors.inkMuted, height: 1.45),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: onClose,
            style: FilledButton.styleFrom(minimumSize: const Size(160, 46)),
            child: const Text('닫기'),
          ),
        ],
      ),
    );
  }
}
