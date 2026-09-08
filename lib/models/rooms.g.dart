// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rooms.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Room _$RoomFromJson(Map<String, dynamic> json) => _Room(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  hashtags: (json['hashtags'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const <String>[],
  participants:
      (json['participants'] as List<dynamic>?)
          ?.map((e) => ParticipantInfo.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ParticipantInfo>[],
  participantCount: (json['participant_count'] as num).toInt(),
  status: $enumDecode(_$RoomStatusEnumMap, json['status']),
  category: $enumDecodeNullable(_$RoomCategoryEnumMap, json['category']),
  thumbnailUrl: json['thumbnail_url'] as String?,
);

Map<String, dynamic> _$RoomToJson(_Room instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'hashtags': instance.hashtags,
  'participants': instance.participants.map((e) => e.toJson()).toList(),
  'participant_count': instance.participantCount,
  'status': _$RoomStatusEnumMap[instance.status]!,
  'category': _$RoomCategoryEnumMap[instance.category],
  'thumbnail_url': instance.thumbnailUrl,
};

const _$RoomStatusEnumMap = {RoomStatus.open: 'open', RoomStatus.ongoing: 'ongoing', RoomStatus.closed: 'closed'};

const _$RoomCategoryEnumMap = {RoomCategory.dance: 'dance', RoomCategory.workout: 'workout', RoomCategory.swim: 'swim'};

_ParticipantInfo _$ParticipantInfoFromJson(Map<String, dynamic> json) =>
    _ParticipantInfo(nickname: json['nickname'] as String, profileImageUrl: json['profile_image_url'] as String?);

Map<String, dynamic> _$ParticipantInfoToJson(_ParticipantInfo instance) => <String, dynamic>{
  'nickname': instance.nickname,
  'profile_image_url': instance.profileImageUrl,
};
