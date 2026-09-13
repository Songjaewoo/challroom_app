// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submissions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Submission _$SubmissionFromJson(Map<String, dynamic> json) => _Submission(
  id: (json['id'] as num).toInt(),
  nickname: json['nickname'] as String,
  videoUrl: json['videoUrl'] as String?,
  assetPath: json['assetPath'] as String?,
  thumbnailUrl: json['thumbnailUrl'] as String?,
  commentCount: (json['commentCount'] as num?)?.toInt() ?? 0,
  likeCount: (json['likeCount'] as num?)?.toInt() ?? 0,
  isLikedByMe: json['isLikedByMe'] as bool? ?? false,
);

Map<String, dynamic> _$SubmissionToJson(_Submission instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'videoUrl': instance.videoUrl,
      'assetPath': instance.assetPath,
      'thumbnailUrl': instance.thumbnailUrl,
      'commentCount': instance.commentCount,
      'likeCount': instance.likeCount,
      'isLikedByMe': instance.isLikedByMe,
    };
