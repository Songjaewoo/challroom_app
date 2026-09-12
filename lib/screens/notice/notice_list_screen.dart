import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../controllers/notices_controller.dart';
import '../../core/error/error_message.dart';
import '../../core/router/app_router.dart';
import '../../core/theme/app_theme.dart';
import '../../models/notices.dart';
import '../../shared/widgets/empty_view.dart';
import '../../shared/widgets/error_view.dart';

/// 설정 > 공지사항. 항목을 탭하면 (다시 조회하지 않고) 이미 불러온 [Notice] 를
/// 그대로 들고 상세 화면으로 간다.
class NoticeListScreen extends ConsumerWidget {
  const NoticeListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notices = ref.watch(noticesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('공지사항')),
      body: notices.when(
        loading: () => const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        error: (error, _) =>
            ErrorView(message: error.toUserMessage(), onRetry: () => ref.invalidate(noticesProvider)),
        data: (list) => list.isEmpty
            ? const EmptyView(message: '아직 등록된 공지사항이 없어요.')
            : ListView.separated(
                itemCount: list.length,
                separatorBuilder: (_, _) => const Divider(height: 0.5, thickness: 0.5, color: AppColors.border),
                itemBuilder: (_, index) => _NoticeTile(notice: list[index]),
              ),
      ),
    );
  }
}

class _NoticeTile extends StatelessWidget {
  const _NoticeTile({required this.notice});

  final Notice notice;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      onTap: () => context.push(RoutePath.noticeDetailOf(notice.id), extra: notice),
      title: Row(
        children: [
          if (notice.isPinned) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(color: AppColors.primarySoft, borderRadius: BorderRadius.circular(6)),
              child: const Text('공지', style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600, color: AppColors.primary)),
            ),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Text(
              notice.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.ink),
            ),
          ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(_formatDate(notice.createdAt), style: const TextStyle(fontSize: 11.5, color: AppColors.inkFaint)),
      ),
      trailing: const Icon(Icons.chevron_right_rounded, size: 18, color: AppColors.inkFaint),
    );
  }

  String _formatDate(DateTime date) =>
      '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';
}
