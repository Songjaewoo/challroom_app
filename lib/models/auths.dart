import 'package:freezed_annotation/freezed_annotation.dart';

import 'users.dart';

part 'auths.freezed.dart';
part 'auths.g.dart';

/// 소셜 SDK 로 받은 토큰을 서버에 넘기는 바디. 어느 제공자인지는 경로가 정한다.
@freezed
abstract class SocialLoginReq with _$SocialLoginReq {
  const factory SocialLoginReq({required String accessToken}) = _SocialLoginReq;

  factory SocialLoginReq.fromJson(Map<String, dynamic> json) => _$SocialLoginReqFromJson(json);
}

@freezed
abstract class AuthTokens with _$AuthTokens {
  const factory AuthTokens({required String accessToken, String? refreshToken}) = _AuthTokens;

  factory AuthTokens.fromJson(Map<String, dynamic> json) => _$AuthTokensFromJson(json);
}

@freezed
abstract class AuthResult with _$AuthResult {
  const factory AuthResult({required User user, required AuthTokens tokens}) = _AuthResult;

  factory AuthResult.fromJson(Map<String, dynamic> json) => _$AuthResultFromJson(json);
}
