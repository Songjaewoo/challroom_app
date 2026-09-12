// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auths.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SocialLoginReq _$SocialLoginReqFromJson(Map<String, dynamic> json) =>
    _SocialLoginReq(accessToken: json['access_token'] as String);

Map<String, dynamic> _$SocialLoginReqToJson(_SocialLoginReq instance) =>
    <String, dynamic>{'access_token': instance.accessToken};

_AuthTokens _$AuthTokensFromJson(Map<String, dynamic> json) => _AuthTokens(
  accessToken: json['access_token'] as String,
  refreshToken: json['refresh_token'] as String?,
);

Map<String, dynamic> _$AuthTokensToJson(_AuthTokens instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
    };

_AuthResult _$AuthResultFromJson(Map<String, dynamic> json) => _AuthResult(
  user: User.fromJson(json['user'] as Map<String, dynamic>),
  tokens: AuthTokens.fromJson(json['tokens'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AuthResultToJson(_AuthResult instance) =>
    <String, dynamic>{
      'user': instance.user.toJson(),
      'tokens': instance.tokens.toJson(),
    };
