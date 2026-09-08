// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 로그인 상태. `null` 이면 로그아웃, 값이 있으면 로그인된 유저다.
///
/// 라우터가 이 상태를 보고 로그인 화면과 홈을 가른다 — 화면마다 로그인 체크를 넣지 않는다.

@ProviderFor(Auth)
final authProvider = AuthProvider._();

/// 로그인 상태. `null` 이면 로그아웃, 값이 있으면 로그인된 유저다.
///
/// 라우터가 이 상태를 보고 로그인 화면과 홈을 가른다 — 화면마다 로그인 체크를 넣지 않는다.
final class AuthProvider extends $AsyncNotifierProvider<Auth, User?> {
  /// 로그인 상태. `null` 이면 로그아웃, 값이 있으면 로그인된 유저다.
  ///
  /// 라우터가 이 상태를 보고 로그인 화면과 홈을 가른다 — 화면마다 로그인 체크를 넣지 않는다.
  AuthProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authHash();

  @$internal
  @override
  Auth create() => Auth();
}

String _$authHash() => r'dba89d691464ff2d82693344c79b65c8e8af8690';

/// 로그인 상태. `null` 이면 로그아웃, 값이 있으면 로그인된 유저다.
///
/// 라우터가 이 상태를 보고 로그인 화면과 홈을 가른다 — 화면마다 로그인 체크를 넣지 않는다.

abstract class _$Auth extends $AsyncNotifier<User?> {
  FutureOr<User?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<User?>, User?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<User?>, User?>,
              AsyncValue<User?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
