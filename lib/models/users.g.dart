// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  id: (json['id'] as num).toInt(),
  provider: $enumDecode(_$SocialProviderEnumMap, json['provider']),
  nickname: json['nickname'] as String?,
  profileImageUrl: json['profileImageUrl'] as String?,
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'id': instance.id,
  'provider': _$SocialProviderEnumMap[instance.provider]!,
  'nickname': instance.nickname,
  'profileImageUrl': instance.profileImageUrl,
};

const _$SocialProviderEnumMap = {
  SocialProvider.kakao: 'kakao',
  SocialProvider.naver: 'naver',
  SocialProvider.google: 'google',
  SocialProvider.apple: 'apple',
};

_ProfileUpdateReq _$ProfileUpdateReqFromJson(Map<String, dynamic> json) =>
    _ProfileUpdateReq(
      nickname: json['nickname'] as String,
      profileImageUrl: json['profileImageUrl'] as String?,
    );

Map<String, dynamic> _$ProfileUpdateReqToJson(_ProfileUpdateReq instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
      'profileImageUrl': instance.profileImageUrl,
    };
