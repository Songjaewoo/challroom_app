import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../controllers/notifications_controller.dart';
import '../../core/error/error_message.dart';
import '../../core/router/app_router.dart';
import '../../core/theme/app_theme.dart';
import '../../models/notifications.dart';
import '../../shared/widgets/empty_view.dart';
import '../../shared/widgets/error_view.dart';

/// 알림함 — 홈 헤더의 종 아이콘으로 들어온다. 열리면 바로 전부 읽음 처리한다.
class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    // 목록을 보여준 다음 프레임에 읽음 처리한다 — 빌드 중에 provider 를 invalidate 하면 안 된다.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) ref.read(notificationsReadProvider.notifier).markAllRead();
    });
  }

  @override
  Widget build(BuildContext context) {
    final notifications = ref.watch(notificationsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('알림')),
      body: notifications.when(
        loading: () => const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        error: (error, _) =>
            ErrorView(message: error.toUserMessage(), onRetry: () => ref.invalidate(notificationsProvider)),
        data: (list) => list.isEmpty
            ? const EmptyView(message: '아직 온 알림이 없어요.')
            : ListView.separated(
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
                itemCount: list.length,
                separatorBuilder: (_, _) => const SizedBox(height: 8),
                itemBuilder: (_, index) => _NotificationTile(notification: list[index]),
              ),
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({required this.notification});

  final AppNotification notification;

  @override
  Widget build(BuildContext context) {
    final style = _styleFor(notification.kind);
    final roomId = notification.roomId;

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: roomId == null ? null : () => context.push(RoutePath.roomDetailOf(roomId)),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: AppColors.accentSoft, borderRadius: BorderRadius.circular(14)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 38,
              height: 38,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: style.tint.withValues(alpha: 0.16), shape: BoxShape.circle),
              child: Icon(style.icon, size: 19, color: style.tint),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.message,
                    style: const TextStyle(fontSize: 14.5, color: AppColors.ink, height: 1.4),
                  ),
                  const SizedBox(height: 4),
                  Text(_relativeTime(notification.createdAt), style: const TextStyle(fontSize: 12.5, color: AppColors.inkFaint)),
                ],
              ),
            ),
            if (!notification.isRead) ...[
              const SizedBox(width: 8),
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(top: 4),
                decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _relativeTime(DateTime time) {
    final diff = DateTime.now().difference(time);
    if (diff.inMinutes < 1) return '방금 전';
    if (diff.inMinutes < 60) return '${diff.inMinutes}분 전';
    if (diff.inHours < 24) return '${diff.inHours}시간 전';
    if (diff.inDays < 7) return '${diff.inDays}일 전';
    return '${time.year}.${time.month.toString().padLeft(2, '0')}.${time.day.toString().padLeft(2, '0')}';
  }

  _NotificationStyle _styleFor(NotificationKind kind) => switch (kind) {
    // 누군가 다가온 소식이라 진행형 CTA 색(핑크)을 그대로 쓴다.
    NotificationKind.applicantReceived => const _NotificationStyle(Icons.person_add_alt_1_rounded, AppColors.primary),
    // 좋은 결과라 성공색.
    NotificationKind.applicationAccepted => const _NotificationStyle(Icons.check_circle_rounded, AppColors.success),
    // 아쉬운 결과지만 나에게 해가 되는 액션은 아니라 danger 대신 중립 톤으로 둔다.
    NotificationKind.applicationRejected => const _NotificationStyle(Icons.cancel_rounded, AppColors.inkMuted),
    // 새로 생긴 콘텐츠라 "생성" 액션 색(코랄).
    NotificationKind.comment => const _NotificationStyle(Icons.chat_bubble_rounded, AppColors.logoMid),
    // 가벼운 소식이라 보조 액션 색(살구).
    NotificationKind.memberJoined => const _NotificationStyle(Icons.groups_rounded, AppColors.logoBack),
    NotificationKind.challengeAdded => const _NotificationStyle(Icons.videocam_rounded, AppColors.logoMid),
  };
}

class _NotificationStyle {
  const _NotificationStyle(this.icon, this.tint);

  final IconData icon;
  final Color tint;
}
