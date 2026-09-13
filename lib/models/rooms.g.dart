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
  participantCount: (json['participantCount'] as num).toInt(),
  status: $enumDecode(_$RoomStatusEnumMap, json['status']),
  category: $enumDecodeNullable(_$RoomCategoryEnumMap, json['category']),
  thumbnailUrl: json['thumbnailUrl'] as String?,
  isApplied: json['isApplied'] as bool? ?? false,
  isMember: json['isMember'] as bool? ?? false,
);

Map<String, dynamic> _$RoomToJson(_Room instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'hashtags': instance.hashtags,
  'participants': instance.participants.map((e) => e.toJson()).toList(),
  'participantCount': instance.participantCount,
  'status': _$RoomStatusEnumMap[instance.status]!,
  'category': _$RoomCategoryEnumMap[instance.category],
  'thumbnailUrl': instance.thumbnailUrl,
  'isApplied': instance.isApplied,
  'isMember': instance.isMember,
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
      description: json['description'] as String?,
      hashtags:
          (json['hashtags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      isPublic: json['isPublic'] as bool? ?? true,
      pickVideoId: (json['pickVideoId'] as num?)?.toInt(),
      videoUrl: json['videoUrl'] as String?,
      assetPath: json['assetPath'] as String?,
    );

Map<String, dynamic> _$RoomCreateReqToJson(_RoomCreateReq instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'hashtags': instance.hashtags,
      'isPublic': instance.isPublic,
      'pickVideoId': instance.pickVideoId,
      'videoUrl': instance.videoUrl,
      'assetPath': instance.assetPath,
    };

_RoomUpdateReq _$RoomUpdateReqFromJson(Map<String, dynamic> json) =>
    _RoomUpdateReq(
      title: json['title'] as String,
      description: json['description'] as String?,
      hashtags:
          (json['hashtags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      isPublic: json['isPublic'] as bool? ?? true,
    );

Map<String, dynamic> _$RoomUpdateReqToJson(_RoomUpdateReq instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'hashtags': instance.hashtags,
      'isPublic': instance.isPublic,
    };

_ParticipantInfo _$ParticipantInfoFromJson(Map<String, dynamic> json) =>
    _ParticipantInfo(
      nickname: json['nickname'] as String,
      profileImageUrl: json['profileImageUrl'] as String?,
      isOwner: json['isOwner'] as bool? ?? false,
    );

Map<String, dynamic> _$ParticipantInfoToJson(_ParticipantInfo instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
      'profileImageUrl': instance.profileImageUrl,
      'isOwner': instance.isOwner,
    };

_RoomDetail _$RoomDetailFromJson(Map<String, dynamic> json) => _RoomDetail(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  description: json['description'] as String?,
  hashtags:
      (json['hashtags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  isPublic: json['isPublic'] as bool? ?? true,
  members:
      (json['members'] as List<dynamic>?)
          ?.map((e) => ParticipantInfo.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ParticipantInfo>[],
  memberCount: (json['memberCount'] as num).toInt(),
  challenges:
      (json['challenges'] as List<dynamic>?)
          ?.map((e) => RoomChallenge.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <RoomChallenge>[],
  isOwnedByMe: json['isOwnedByMe'] as bool? ?? false,
  inviteCode: json['inviteCode'] as String?,
  pendingApplicants:
      (json['pendingApplicants'] as List<dynamic>?)
          ?.map((e) => ParticipantInfo.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ParticipantInfo>[],
);

Map<String, dynamic> _$RoomDetailToJson(_RoomDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'hashtags': instance.hashtags,
      'isPublic': instance.isPublic,
      'members': instance.members.map((e) => e.toJson()).toList(),
      'memberCount': instance.memberCount,
      'challenges': instance.challenges.map((e) => e.toJson()).toList(),
      'isOwnedByMe': instance.isOwnedByMe,
      'inviteCode': instance.inviteCode,
      'pendingApplicants': instance.pendingApplicants
          .map((e) => e.toJson())
          .toList(),
    };

_RoomChallenge _$RoomChallengeFromJson(Map<String, dynamic> json) =>
    _RoomChallenge(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      source: json['source'] as String,
      submittedCount: (json['submittedCount'] as num).toInt(),
      totalCount: (json['totalCount'] as num).toInt(),
      thumbnailUrl: json['thumbnailUrl'] as String?,
    );

Map<String, dynamic> _$RoomChallengeToJson(_RoomChallenge instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'source': instance.source,
      'submittedCount': instance.submittedCount,
      'totalCount': instance.totalCount,
      'thumbnailUrl': instance.thumbnailUrl,
    };

_ChallengeDetail _$ChallengeDetailFromJson(Map<String, dynamic> json) =>
    _ChallengeDetail(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      source: json['source'] as String,
      videoUrl: json['videoUrl'] as String?,
      assetPath: json['assetPath'] as String?,
      totalCount: (json['totalCount'] as num).toInt(),
      submissions:
          (json['submissions'] as List<dynamic>?)
              ?.map((e) => Submission.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Submission>[],
      commentCount: (json['commentCount'] as num?)?.toInt() ?? 0,
      likeCount: (json['likeCount'] as num?)?.toInt() ?? 0,
      isLikedByMe: json['isLikedByMe'] as bool? ?? false,
    );

Map<String, dynamic> _$ChallengeDetailToJson(_ChallengeDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'source': instance.source,
      'videoUrl': instance.videoUrl,
      'assetPath': instance.assetPath,
      'totalCount': instance.totalCount,
      'submissions': instance.submissions.map((e) => e.toJson()).toList(),
      'commentCount': instance.commentCount,
      'likeCount': instance.likeCount,
      'isLikedByMe': instance.isLikedByMe,
    };
