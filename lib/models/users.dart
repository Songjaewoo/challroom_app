import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'users.freezed.dart';
part 'users.g.dart';

@freezed
abstract class User with _$User {
  const factory User({
    required int id,
    required SocialProvider provider,

    /// 닉네임 설정 전에는 비어 있다 — 온보딩에서 채운다.
    String? nickname,
    String? profileImageUrl,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
abstract class ProfileUpdateReq with _$ProfileUpdateReq {
  const factory ProfileUpdateReq({
    required String nickname,

    /// 미리 업로드해 받은 이미지 URL. 사진을 안 바꿨으면 `null`.
    String? profileImageUrl,
  }) = _ProfileUpdateReq;

  factory ProfileUpdateReq.fromJson(Map<String, dynamic> json) => _$ProfileUpdateReqFromJson(json);
}
