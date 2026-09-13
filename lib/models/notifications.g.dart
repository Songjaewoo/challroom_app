// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppNotification _$AppNotificationFromJson(Map<String, dynamic> json) =>
    _AppNotification(
      id: (json['id'] as num).toInt(),
      kind: $enumDecode(_$NotificationKindEnumMap, json['kind']),
      message: json['message'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isRead: json['isRead'] as bool? ?? false,
      roomId: (json['roomId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AppNotificationToJson(_AppNotification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'kind': _$NotificationKindEnumMap[instance.kind]!,
      'message': instance.message,
      'createdAt': instance.createdAt.toIso8601String(),
      'isRead': instance.isRead,
      'roomId': instance.roomId,
    };

const _$NotificationKindEnumMap = {
  NotificationKind.applicantReceived: 'applicant_received',
  NotificationKind.applicationAccepted: 'application_accepted',
  NotificationKind.applicationRejected: 'application_rejected',
  NotificationKind.comment: 'comment',
  NotificationKind.memberJoined: 'member_joined',
  NotificationKind.challengeAdded: 'challenge_added',
};
