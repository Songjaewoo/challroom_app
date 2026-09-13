// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notices.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Notice _$NoticeFromJson(Map<String, dynamic> json) => _Notice(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  content: json['content'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  isPinned: json['isPinned'] as bool? ?? false,
);

Map<String, dynamic> _$NoticeToJson(_Notice instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'content': instance.content,
  'createdAt': instance.createdAt.toIso8601String(),
  'isPinned': instance.isPinned,
};
