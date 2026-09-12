import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'comments.freezed.dart';
part 'comments.g.dart';

/// 댓글이 달리는 대상 하나를 가리키는 값 — [CommentTargetType] + 그 대상의 id.
/// Dart record 라 별도 코드 생성 없이도 구조적 동등성(==, hashCode)이 나와서
/// `commentsProvider` 같은 family provider 의 키로 그대로 쓸 수 있다.
/// (`AssetVideoArgs` 와 같은 패턴 — [asset_video_player_screen.dart] 참고)
typedef CommentTarget = ({CommentTargetType type, int id});

/// 댓글 한 개.
@freezed
abstract class Comment with _$Comment {
  const factory Comment({
    required int id,
    required String nickname,
    required String text,
    required DateTime createdAt,
    @Default(0) int likeCount,
    @Default(false) bool likedByMe,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
}
