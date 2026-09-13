import 'package:freezed_annotation/freezed_annotation.dart';

import 'users.dart';

part 'auths.freezed.dart';
part 'auths.g.dart';

/// 소셜 SDK 로 받은 토큰을 서버에 넘기는 바디. 어느 제공자인지는 경로가 정한다.
///
/// 서버 필드명이 그냥 `token` 이라(액세스 토큰인 게 경로로 이미 정해져 있어서) 여기서만
/// `@JsonKey` 로 전역 snake_case 규칙을 덮어쓴다.
@freezed
abstract class SocialLoginReq with _$SocialLoginReq {
  const factory SocialLoginReq({@JsonKey(name: 'token') required String accessToken}) = _SocialLoginReq;

  factory SocialLoginReq.fromJson(Map<String, dynamic> json) => _$SocialLoginReqFromJson(json);
}

/// 로그인 성공 응답 — 서버가 `user` 옆에 토큰 두 개를 바로 붙여 보낸다(중첩 객체가 아니다).
@freezed
abstract class AuthResult with _$AuthResult {
  const factory AuthResult({
    required User user,
    required String accessToken,
    required String refreshToken,

    /// 신규 가입이거나 닉네임을 아직 안 정한 유저면 `true` — 다만 라우터는 이 값 대신
    /// `user.nickname` 이 비어 있는지로 온보딩 여부를 가른다(서버 재조회 때도 같은 기준을
    /// 쓰려고). 응답 그대로 담아만 둔다.
    @Default(false) bool isNewUser,
  }) = _AuthResult;

  factory AuthResult.fromJson(Map<String, dynamic> json) => _$AuthResultFromJson(json);
}
