// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pick_videos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PickVideo _$PickVideoFromJson(Map<String, dynamic> json) => _PickVideo(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  source: json['source'] as String,
  videoUrl: json['video_url'] as String?,
  assetPath: json['asset_path'] as String?,
  thumbnailUrl: json['thumbnail_url'] as String?,
);

Map<String, dynamic> _$PickVideoToJson(_PickVideo instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'source': instance.source,
  'video_url': instance.videoUrl,
  'asset_path': instance.assetPath,
  'thumbnail_url': instance.thumbnailUrl,
};
