import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/comments_controller.dart';
import '../../core/error/error_message.dart';
import '../../core/theme/app_theme.dart';
import '../../models/comments.dart';
import '../../shared/avatar_color.dart';
import '../../shared/relative_time.dart';
import '../../shared/widgets/empty_view.dart';
import '../../shared/widgets/error_view.dart';
import '../../shared/widgets/loading_view.dart';

/// 댓글 바텀시트를 연다. 원본 영상 행([target]이 [CommentTargetType.challenge])이든 제출
/// 영상 배지([CommentTargetType.submission])든, 호출부는 대상과 헤더에 쓸 이름만 넘기면 된다
/// — 영상이 브라우저로 열리든 네이티브로 열리든 이 시트는 항상 같다.
Future<void> showCommentsSheet(BuildContext context, {required CommentTarget target, required String title}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => CommentsSheet(target: target, title: title),
  );
}

class CommentsSheet extends ConsumerStatefulWidget {
  const CommentsSheet({required this.target, required this.title, super.key});

  final CommentTarget target;
  final String title;

  @override
  ConsumerState<CommentsSheet> createState() => _CommentsSheetState();
}

class _CommentsSheetState extends ConsumerState<CommentsSheet> {
  final _inputController = TextEditingController();
  var _sending = false;

  // DraggableScrollableSheet 가 매 build 마다 넘겨주는 컨트롤러를 그대로 들고 있다가
  // 새 댓글이 오면 여기로 스크롤한다 — 시트 드래그와 목록 스크롤이 한 제스처로 이어지려면
  // 이 컨트롤러를 목록에도 그대로 써야 해서, 따로 새 ScrollController 를 만들지 않는다.
  ScrollController? _listScrollController;

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final comments = ref.watch(commentsProvider(widget.target));

    ref.listen(commentsProvider(widget.target), (previous, next) {
      if (next case AsyncError(:final error)) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(error.toUserMessage())));
      }
      // 로딩→데이터로 바뀐 게 "새로 올린 댓글" 쪽이면(목록이 늘었으면) 맨 아래로 스크롤해 보여준다.
      final prevCount = previous?.value?.length ?? 0;
      final nextCount = next.value?.length ?? 0;
      if (next case AsyncData()) {
        if (nextCount > prevCount) _scrollToBottom();
        setState(() => _sending = false);
      }
    });

    // 모달 바텀시트는 키보드를 알아서 피해주지 않는다 — 시트 전체를 키보드 높이만큼 들어
    // 올려서, 인풋바가 항상 키보드 바로 위에 붙어있게 한다(키보드에 가려 뭘 쳤는지 안 보이는
    // 문제 수정). `DraggableScrollableSheet` 는 남은 높이에 맞춰 다시 비율을 잡으니 목록도
    // 같이 줄어든다.
    return AnimatedPadding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      child: DraggableScrollableSheet(
        initialChildSize: 0.72,
        minChildSize: 0.4,
        maxChildSize: 0.94,
        expand: false,
        builder: (context, listScrollController) {
          _listScrollController = listScrollController;
          return DecoratedBox(
            decoration: const BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: SafeArea(
              top: false,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Container(
                    width: 34,
                    height: 4,
                    decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(4)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 14, 8, 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              text: '${widget.title} · 댓글 ',
                              style: const TextStyle(fontSize: 15.5, fontWeight: FontWeight.w700, color: AppColors.ink),
                              children: [
                                TextSpan(
                                  text: '${comments.value?.length ?? ''}',
                                  style: const TextStyle(color: AppColors.primary),
                                ),
                              ],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.of(context).maybePop(),
                          icon: const Icon(Icons.close, size: 22, color: AppColors.inkMuted),
                          visualDensity: VisualDensity.compact,
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1, color: AppColors.border),
                  Expanded(
                    child: comments.when(
                      loading: () => const LoadingView(),
                      error: (error, _) => ErrorView(
                        message: error.toUserMessage(),
                        onRetry: () => ref.invalidate(commentsProvider(widget.target)),
                      ),
                      data: (list) => list.isEmpty
                          ? const EmptyView(message: '아직 댓글이 없어요.\n첫 댓글을 남겨보세요.')
                          : ListView.separated(
                              // DraggableScrollableSheet 가 준 컨트롤러를 그대로 써야 드래그와
                              // 목록 스크롤이 한 제스처로 자연스럽게 이어진다.
                              controller: listScrollController,
                              padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
                              itemCount: list.length,
                              separatorBuilder: (_, _) => const SizedBox(height: 16),
                              itemBuilder: (_, index) => _CommentRow(comment: list[index]),
                            ),
                    ),
                  ),
                  const Divider(height: 1, color: AppColors.border),
                  _CommentInputBar(controller: _inputController, sending: _sending, onSend: _send),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = _listScrollController;
      if (controller == null || !controller.hasClients) return;
      controller.animateTo(
        controller.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  void _send() {
    final text = _inputController.text;
    if (text.trim().isEmpty) return;

    setState(() => _sending = true);
    _inputController.clear();
    FocusScope.of(context).unfocus();
    ref.read(commentsProvider(widget.target).notifier).post(text);
  }
}

class _CommentRow extends StatelessWidget {
  const _CommentRow({required this.comment});

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 15,
          backgroundColor: avatarColorFor(comment.nickname),
          child: Text(
            comment.nickname.substring(0, 1),
            style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: AppColors.onBrand),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(comment.nickname, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.ink)),
                  const SizedBox(width: 6),
                  Text(relativeTimeKo(comment.createdAt), style: const TextStyle(fontSize: 12, color: AppColors.inkFaint)),
                ],
              ),
              const SizedBox(height: 3),
              Text(comment.text, style: const TextStyle(fontSize: 14.5, color: AppColors.ink, height: 1.4)),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Column(
          children: [
            Icon(
              comment.likedByMe ? Icons.favorite : Icons.favorite_border,
              size: 18,
              color: comment.likedByMe ? AppColors.primary : AppColors.inkFaint,
            ),
            if (comment.likeCount > 0) ...[
              const SizedBox(height: 2),
              Text('${comment.likeCount}', style: const TextStyle(fontSize: 11, color: AppColors.inkFaint)),
            ],
          ],
        ),
      ],
    );
  }
}

class _CommentInputBar extends ConsumerWidget {
  const _CommentInputBar({required this.controller, required this.sending, required this.onSend});

  final TextEditingController controller;
  final bool sending;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nickname = ref.watch(authProvider).value?.nickname;

    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: nickname == null ? AppColors.accentSoft : avatarColorFor(nickname),
            child: nickname == null
                ? null
                : Text(
                    nickname.substring(0, 1),
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.onBrand),
                  ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              enabled: !sending,
              minLines: 1,
              maxLines: 4,
              style: const TextStyle(fontSize: 14.5, color: AppColors.ink),
              decoration: InputDecoration(
                hintText: '댓글을 남겨보세요',
                hintStyle: const TextStyle(fontSize: 14.5, color: AppColors.inkFaint),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
              ),
              onSubmitted: (_) => onSend(),
            ),
          ),
          const SizedBox(width: 6),
          IconButton(
            onPressed: sending ? null : onSend,
            icon: sending
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
                  )
                : const Icon(Icons.send_rounded, color: AppColors.primary, size: 22),
          ),
        ],
      ),
    );
  }
}
