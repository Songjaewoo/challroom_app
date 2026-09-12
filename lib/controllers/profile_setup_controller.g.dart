// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_setup_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 닉네임·프로필 사진을 저장하는 액션 전용 Controller — 최초 온보딩과 설정의
/// "프로필 편집" 이 똑같이 쓴다(둘 다 "프로필을 저장한다"는 같은 동작이다).
/// 조회할 초기 상태가 없어 `build()` 는 아무것도 하지 않는다 — 진행 상태만 [AsyncValue] 로 본다.

@ProviderFor(ProfileSetup)
final profileSetupProvider = ProfileSetupProvider._();

/// 닉네임·프로필 사진을 저장하는 액션 전용 Controller — 최초 온보딩과 설정의
/// "프로필 편집" 이 똑같이 쓴다(둘 다 "프로필을 저장한다"는 같은 동작이다).
/// 조회할 초기 상태가 없어 `build()` 는 아무것도 하지 않는다 — 진행 상태만 [AsyncValue] 로 본다.
final class ProfileSetupProvider
    extends $AsyncNotifierProvider<ProfileSetup, void> {
  /// 닉네임·프로필 사진을 저장하는 액션 전용 Controller — 최초 온보딩과 설정의
  /// "프로필 편집" 이 똑같이 쓴다(둘 다 "프로필을 저장한다"는 같은 동작이다).
  /// 조회할 초기 상태가 없어 `build()` 는 아무것도 하지 않는다 — 진행 상태만 [AsyncValue] 로 본다.
  ProfileSetupProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileSetupProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileSetupHash();

  @$internal
  @override
  ProfileSetup create() => ProfileSetup();
}

String _$profileSetupHash() => r'a8c173f8d57b316bf381369970393af1151401d5';

/// 닉네임·프로필 사진을 저장하는 액션 전용 Controller — 최초 온보딩과 설정의
/// "프로필 편집" 이 똑같이 쓴다(둘 다 "프로필을 저장한다"는 같은 동작이다).
/// 조회할 초기 상태가 없어 `build()` 는 아무것도 하지 않는다 — 진행 상태만 [AsyncValue] 로 본다.

abstract class _$ProfileSetup extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
