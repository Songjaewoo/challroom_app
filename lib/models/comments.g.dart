// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Comment _$CommentFromJson(Map<String, dynamic> json) => _Comment(
  id: (json['id'] as num).toInt(),
  nickname: json['nickname'] as String,
  text: json['text'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  likeCount: (json['likeCount'] as num?)?.toInt() ?? 0,
  likedByMe: json['likedByMe'] as bool? ?? false,
);

Map<String, dynamic> _$CommentToJson(_Comment instance) => <String, dynamic>{
  'id': instance.id,
  'nickname': instance.nickname,
  'text': instance.text,
  'createdAt': instance.createdAt.toIso8601String(),
  'likeCount': instance.likeCount,
  'likedByMe': instance.likedByMe,
};
