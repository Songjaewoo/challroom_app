// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pick_videos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PickVideo _$PickVideoFromJson(Map<String, dynamic> json) => _PickVideo(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  source: json['source'] as String,
  videoUrl: json['videoUrl'] as String?,
  assetPath: json['assetPath'] as String?,
  thumbnailUrl: json['thumbnailUrl'] as String?,
  thumbnailPath: json['thumbnailPath'] as String?,
);

Map<String, dynamic> _$PickVideoToJson(_PickVideo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'source': instance.source,
      'videoUrl': instance.videoUrl,
      'assetPath': instance.assetPath,
      'thumbnailUrl': instance.thumbnailUrl,
      'thumbnailPath': instance.thumbnailPath,
    };
