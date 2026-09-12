// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Comment _$CommentFromJson(Map<String, dynamic> json) => _Comment(
  id: (json['id'] as num).toInt(),
  nickname: json['nickname'] as String,
  text: json['text'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  likeCount: (json['like_count'] as num?)?.toInt() ?? 0,
  likedByMe: json['liked_by_me'] as bool? ?? false,
);

Map<String, dynamic> _$CommentToJson(_Comment instance) => <String, dynamic>{
  'id': instance.id,
  'nickname': instance.nickname,
  'text': instance.text,
  'created_at': instance.createdAt.toIso8601String(),
  'like_count': instance.likeCount,
  'liked_by_me': instance.likedByMe,
};
