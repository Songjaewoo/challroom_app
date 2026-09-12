// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submissions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Submission _$SubmissionFromJson(Map<String, dynamic> json) => _Submission(
  id: (json['id'] as num).toInt(),
  nickname: json['nickname'] as String,
  videoUrl: json['video_url'] as String?,
  assetPath: json['asset_path'] as String?,
  thumbnailUrl: json['thumbnail_url'] as String?,
  commentCount: (json['comment_count'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$SubmissionToJson(_Submission instance) => <String, dynamic>{
  'id': instance.id,
  'nickname': instance.nickname,
  'video_url': instance.videoUrl,
  'asset_path': instance.assetPath,
  'thumbnail_url': instance.thumbnailUrl,
  'comment_count': instance.commentCount,
};
