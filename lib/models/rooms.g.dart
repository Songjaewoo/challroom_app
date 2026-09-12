// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rooms.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Room _$RoomFromJson(Map<String, dynamic> json) => _Room(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  hashtags:
      (json['hashtags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
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

const _$RoomStatusEnumMap = {
  RoomStatus.open: 'open',
  RoomStatus.ongoing: 'ongoing',
  RoomStatus.closed: 'closed',
};

const _$RoomCategoryEnumMap = {
  RoomCategory.dance: 'dance',
  RoomCategory.workout: 'workout',
  RoomCategory.swim: 'swim',
};

_RoomCreateReq _$RoomCreateReqFromJson(Map<String, dynamic> json) =>
    _RoomCreateReq(
      title: json['title'] as String,
      hashtags:
          (json['hashtags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      isPublic: json['is_public'] as bool? ?? true,
      pickVideoId: (json['pick_video_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RoomCreateReqToJson(_RoomCreateReq instance) =>
    <String, dynamic>{
      'title': instance.title,
      'hashtags': instance.hashtags,
      'is_public': instance.isPublic,
      'pick_video_id': instance.pickVideoId,
    };

_RoomUpdateReq _$RoomUpdateReqFromJson(Map<String, dynamic> json) =>
    _RoomUpdateReq(
      title: json['title'] as String,
      hashtags:
          (json['hashtags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      isPublic: json['is_public'] as bool? ?? true,
    );

Map<String, dynamic> _$RoomUpdateReqToJson(_RoomUpdateReq instance) =>
    <String, dynamic>{
      'title': instance.title,
      'hashtags': instance.hashtags,
      'is_public': instance.isPublic,
    };

_ParticipantInfo _$ParticipantInfoFromJson(Map<String, dynamic> json) =>
    _ParticipantInfo(
      nickname: json['nickname'] as String,
      profileImageUrl: json['profile_image_url'] as String?,
      isOwner: json['is_owner'] as bool? ?? false,
    );

Map<String, dynamic> _$ParticipantInfoToJson(_ParticipantInfo instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
      'profile_image_url': instance.profileImageUrl,
      'is_owner': instance.isOwner,
    };

_RoomDetail _$RoomDetailFromJson(Map<String, dynamic> json) => _RoomDetail(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  hashtags:
      (json['hashtags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  isPublic: json['is_public'] as bool? ?? true,
  members:
      (json['members'] as List<dynamic>?)
          ?.map((e) => ParticipantInfo.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ParticipantInfo>[],
  memberCount: (json['member_count'] as num).toInt(),
  challenges:
      (json['challenges'] as List<dynamic>?)
          ?.map((e) => RoomChallenge.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <RoomChallenge>[],
  isOwnedByMe: json['is_owned_by_me'] as bool? ?? false,
  inviteCode: json['invite_code'] as String?,
);

Map<String, dynamic> _$RoomDetailToJson(_RoomDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'hashtags': instance.hashtags,
      'is_public': instance.isPublic,
      'members': instance.members.map((e) => e.toJson()).toList(),
      'member_count': instance.memberCount,
      'challenges': instance.challenges.map((e) => e.toJson()).toList(),
      'is_owned_by_me': instance.isOwnedByMe,
      'invite_code': instance.inviteCode,
    };

_RoomChallenge _$RoomChallengeFromJson(Map<String, dynamic> json) =>
    _RoomChallenge(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      source: json['source'] as String,
      submittedCount: (json['submitted_count'] as num).toInt(),
      totalCount: (json['total_count'] as num).toInt(),
      thumbnailUrl: json['thumbnail_url'] as String?,
    );

Map<String, dynamic> _$RoomChallengeToJson(_RoomChallenge instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'source': instance.source,
      'submitted_count': instance.submittedCount,
      'total_count': instance.totalCount,
      'thumbnail_url': instance.thumbnailUrl,
    };

_ChallengeDetail _$ChallengeDetailFromJson(Map<String, dynamic> json) =>
    _ChallengeDetail(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      source: json['source'] as String,
      videoUrl: json['video_url'] as String?,
      assetPath: json['asset_path'] as String?,
      totalCount: (json['total_count'] as num).toInt(),
      submissions:
          (json['submissions'] as List<dynamic>?)
              ?.map((e) => Submission.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Submission>[],
      commentCount: (json['comment_count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ChallengeDetailToJson(_ChallengeDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'source': instance.source,
      'video_url': instance.videoUrl,
      'asset_path': instance.assetPath,
      'total_count': instance.totalCount,
      'submissions': instance.submissions.map((e) => e.toJson()).toList(),
      'comment_count': instance.commentCount,
    };
