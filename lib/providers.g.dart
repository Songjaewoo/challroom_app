// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(tokenStorage)
final tokenStorageProvider = TokenStorageProvider._();

final class TokenStorageProvider
    extends $FunctionalProvider<TokenStorage, TokenStorage, TokenStorage>
    with $Provider<TokenStorage> {
  TokenStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tokenStorageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tokenStorageHash();

  @$internal
  @override
  $ProviderElement<TokenStorage> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TokenStorage create(Ref ref) {
    return tokenStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TokenStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TokenStorage>(value),
    );
  }
}

String _$tokenStorageHash() => r'6cd9a72ce24a379d8da2fe005711efef2ede5ac2';

@ProviderFor(dio)
final dioProvider = DioProvider._();

final class DioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  DioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dioProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return dio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$dioHash() => r'aa964a26eab393bcae310af92fce1b5a14518f59';

/// `API_BASE_URL` 이 없으면(지금 상태) 서버 없이도 로그인→프로필 설정→홈 흐름을
/// 미리 볼 수 있게 메모리 전용 가짜 백엔드를 쓴다. `--dart-define=API_BASE_URL=...` 로
/// 실제 서버를 넘기면 이 provider 들은 자동으로 Dio 구현으로 돌아간다.

@ProviderFor(localDevBackend)
final localDevBackendProvider = LocalDevBackendProvider._();

/// `API_BASE_URL` 이 없으면(지금 상태) 서버 없이도 로그인→프로필 설정→홈 흐름을
/// 미리 볼 수 있게 메모리 전용 가짜 백엔드를 쓴다. `--dart-define=API_BASE_URL=...` 로
/// 실제 서버를 넘기면 이 provider 들은 자동으로 Dio 구현으로 돌아간다.

final class LocalDevBackendProvider
    extends
        $FunctionalProvider<LocalDevBackend, LocalDevBackend, LocalDevBackend>
    with $Provider<LocalDevBackend> {
  /// `API_BASE_URL` 이 없으면(지금 상태) 서버 없이도 로그인→프로필 설정→홈 흐름을
  /// 미리 볼 수 있게 메모리 전용 가짜 백엔드를 쓴다. `--dart-define=API_BASE_URL=...` 로
  /// 실제 서버를 넘기면 이 provider 들은 자동으로 Dio 구현으로 돌아간다.
  LocalDevBackendProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localDevBackendProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localDevBackendHash();

  @$internal
  @override
  $ProviderElement<LocalDevBackend> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LocalDevBackend create(Ref ref) {
    return localDevBackend(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalDevBackend value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalDevBackend>(value),
    );
  }
}

String _$localDevBackendHash() => r'6cef318177f8bbccf1e5a8d711268b183552c8dc';

/// 소셜 SDK 를 붙이면 `UnavailableSocialAuthService` 자리를 새 구현으로 바꾼다.

@ProviderFor(socialAuthService)
final socialAuthServiceProvider = SocialAuthServiceProvider._();

/// 소셜 SDK 를 붙이면 `UnavailableSocialAuthService` 자리를 새 구현으로 바꾼다.

final class SocialAuthServiceProvider
    extends
        $FunctionalProvider<
          SocialAuthService,
          SocialAuthService,
          SocialAuthService
        >
    with $Provider<SocialAuthService> {
  /// 소셜 SDK 를 붙이면 `UnavailableSocialAuthService` 자리를 새 구현으로 바꾼다.
  SocialAuthServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'socialAuthServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$socialAuthServiceHash();

  @$internal
  @override
  $ProviderElement<SocialAuthService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SocialAuthService create(Ref ref) {
    return socialAuthService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SocialAuthService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SocialAuthService>(value),
    );
  }
}

String _$socialAuthServiceHash() => r'4fc38addd5e1200173b4f5a4c5eb3a3f13a528cf';

@ProviderFor(authRepository)
final authRepositoryProvider = AuthRepositoryProvider._();

final class AuthRepositoryProvider
    extends $FunctionalProvider<AuthRepository, AuthRepository, AuthRepository>
    with $Provider<AuthRepository> {
  AuthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRepositoryHash();

  @$internal
  @override
  $ProviderElement<AuthRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthRepository create(Ref ref) {
    return authRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRepository>(value),
    );
  }
}

String _$authRepositoryHash() => r'e985e586604016a1386d301f2d82707b74ecb325';

@ProviderFor(userRepository)
final userRepositoryProvider = UserRepositoryProvider._();

final class UserRepositoryProvider
    extends $FunctionalProvider<UserRepository, UserRepository, UserRepository>
    with $Provider<UserRepository> {
  UserRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userRepositoryHash();

  @$internal
  @override
  $ProviderElement<UserRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UserRepository create(Ref ref) {
    return userRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserRepository>(value),
    );
  }
}

String _$userRepositoryHash() => r'f7d660a4d25f178dd38528f0290f6c5dcece501f';

@ProviderFor(roomRepository)
final roomRepositoryProvider = RoomRepositoryProvider._();

final class RoomRepositoryProvider
    extends $FunctionalProvider<RoomRepository, RoomRepository, RoomRepository>
    with $Provider<RoomRepository> {
  RoomRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'roomRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$roomRepositoryHash();

  @$internal
  @override
  $ProviderElement<RoomRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RoomRepository create(Ref ref) {
    return roomRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RoomRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RoomRepository>(value),
    );
  }
}

String _$roomRepositoryHash() => r'92061f0198719ac4d26de4a3204837259302a811';
