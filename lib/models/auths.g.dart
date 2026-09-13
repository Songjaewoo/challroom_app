// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auths.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SocialLoginReq _$SocialLoginReqFromJson(Map<String, dynamic> json) =>
    _SocialLoginReq(accessToken: json['token'] as String);

Map<String, dynamic> _$SocialLoginReqToJson(_SocialLoginReq instance) =>
    <String, dynamic>{'token': instance.accessToken};

_AuthResult _$AuthResultFromJson(Map<String, dynamic> json) => _AuthResult(
  user: User.fromJson(json['user'] as Map<String, dynamic>),
  accessToken: json['accessToken'] as String,
  refreshToken: json['refreshToken'] as String,
  isNewUser: json['isNewUser'] as bool? ?? false,
);

Map<String, dynamic> _$AuthResultToJson(_AuthResult instance) =>
    <String, dynamic>{
      'user': instance.user.toJson(),
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'isNewUser': instance.isNewUser,
    };
