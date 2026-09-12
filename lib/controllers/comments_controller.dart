import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/comments.dart';
import '../providers.dart';

part 'comments_controller.g.dart';

/// 댓글 바텀시트 하나의 상태 — [CommentTarget] 값만 바꿔가며 원본 영상 댓글과
/// 제출 영상 댓글 양쪽에 다 쓴다([CommentsSheet] 참고).
@riverpod
class Comments extends _$Comments {
  @override
  Future<List<Comment>> build(CommentTarget target) {
    return ref.watch(commentRepositoryProvider).fetchComments(target);
  }

  /// 댓글을 올리고, 성공하면 방금 쓴 댓글을 목록 끝에 이어붙인다.
  Future<void> post(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;

    final previous = state.value ?? const [];
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final comment = await ref.read(commentRepositoryProvider).postComment(target, trimmed);
      return [...previous, comment];
    });
  }
}
