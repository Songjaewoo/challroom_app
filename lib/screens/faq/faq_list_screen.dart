import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../controllers/faqs_controller.dart';
import '../../core/error/error_message.dart';
import '../../core/router/app_router.dart';
import '../../core/theme/app_theme.dart';
import '../../models/faqs.dart';
import '../../shared/widgets/empty_view.dart';
import '../../shared/widgets/error_view.dart';

/// 설정 > 자주 묻는 질문. 항목을 탭하면 (다시 조회하지 않고) 이미 불러온 [Faq] 를
/// 그대로 들고 상세 화면으로 간다.
class FaqListScreen extends ConsumerWidget {
  const FaqListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final faqs = ref.watch(faqsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('자주 묻는 질문')),
      body: faqs.when(
        loading: () => const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        error: (error, _) => ErrorView(message: error.toUserMessage(), onRetry: () => ref.invalidate(faqsProvider)),
        data: (list) => list.isEmpty ? const EmptyView(message: '아직 등록된 질문이 없어요.') : _FaqGroupedList(faqs: list),
      ),
    );
  }
}

class _FaqGroupedList extends StatelessWidget {
  const _FaqGroupedList({required this.faqs});

  final List<Faq> faqs;

  @override
  Widget build(BuildContext context) {
    // 원래 순서(카테고리가 처음 등장하는 순서)를 지키면서 묶는다.
    final grouped = <String, List<Faq>>{};
    for (final faq in faqs) {
      grouped.putIfAbsent(faq.category, () => []).add(faq);
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 24),
      children: [
        for (final entry in grouped.entries) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              entry.key,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.inkMuted),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(14),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Column(
                children: [
                  for (var i = 0; i < entry.value.length; i++) ...[
                    _FaqTile(faq: entry.value[i]),
                    if (i != entry.value.length - 1)
                      const Divider(height: 0.5, thickness: 0.5, color: AppColors.border),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ],
    );
  }
}

class _FaqTile extends StatelessWidget {
  const _FaqTile({required this.faq});

  final Faq faq;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push(RoutePath.faqDetailOf(faq.id), extra: faq),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        child: Row(
          children: [
            const Text('Q', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.primary)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                faq.question,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w500, color: AppColors.ink),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right_rounded, size: 18, color: AppColors.inkFaint),
          ],
        ),
      ),
    );
  }
}
