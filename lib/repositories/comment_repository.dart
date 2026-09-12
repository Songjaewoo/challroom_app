import 'package:dio/dio.dart';

import '../models/comments.dart';

/// [CommentTarget] 하나(챌린지 원본 영상 또는 특정 제출 영상)에 달린 댓글을 다룬다.
/// 두 대상이 인터페이스 하나를 공유하니, 댓글 바텀시트도 어떤 영상인지 몰라도 된다.
abstract interface class CommentRepository {
  Future<List<Comment>> fetchComments(CommentTarget target);

  /// 실 서버라면 작성자는 인증 토큰으로 정해진다 — 그래서 닉네임을 인자로 받지 않는다.
  Future<Comment> postComment(CommentTarget target, String text);
}

class DioCommentRepository implements CommentRepository {
  DioCommentRepository(this._dio);

  final Dio _dio;

  String _path(CommentTarget target) => '/${target.type.apiSegment}/${target.id}/comments';

  @override
  Future<List<Comment>> fetchComments(CommentTarget target) async {
    final res = await _dio.get<List<dynamic>>(_path(target));
    return (res.data ?? const []).map((e) => Comment.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<Comment> postComment(CommentTarget target, String text) async {
    final res = await _dio.post<Map<String, dynamic>>(_path(target), data: {'text': text});
    return Comment.fromJson(res.data!);
  }
}
