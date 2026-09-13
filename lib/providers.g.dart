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

/// 지금은 네이버만 실제 SDK 로 붙어 있다 — [HybridSocialAuthService] 가 provider 별로
/// 그 하나만 진짜로 보내고 나머지는 기존 방식(로컬 모드는 가짜 토큰, 실서버 모드는
/// "아직 연결 전" 에러)으로 넘긴다.

@ProviderFor(socialAuthService)
final socialAuthServiceProvider = SocialAuthServiceProvider._();

/// 지금은 네이버만 실제 SDK 로 붙어 있다 — [HybridSocialAuthService] 가 provider 별로
/// 그 하나만 진짜로 보내고 나머지는 기존 방식(로컬 모드는 가짜 토큰, 실서버 모드는
/// "아직 연결 전" 에러)으로 넘긴다.

final class SocialAuthServiceProvider
    extends
        $FunctionalProvider<
          SocialAuthService,
          SocialAuthService,
          SocialAuthService
        >
    with $Provider<SocialAuthService> {
  /// 지금은 네이버만 실제 SDK 로 붙어 있다 — [HybridSocialAuthService] 가 provider 별로
  /// 그 하나만 진짜로 보내고 나머지는 기존 방식(로컬 모드는 가짜 토큰, 실서버 모드는
  /// "아직 연결 전" 에러)으로 넘긴다.
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

String _$socialAuthServiceHash() => r'7c8edb622ba76350b5b5407c79b982e24b3ac659';

/// 로그인은 실제 서버(`challroom_api`)의 `/v1/auth` 라우터가 이미 구현돼 있어서, 다른
/// 도메인과 달리 `apiBaseUrl` 이 있으면 바로 Dio 로 갈아탄다.

@ProviderFor(authRepository)
final authRepositoryProvider = AuthRepositoryProvider._();

/// 로그인은 실제 서버(`challroom_api`)의 `/v1/auth` 라우터가 이미 구현돼 있어서, 다른
/// 도메인과 달리 `apiBaseUrl` 이 있으면 바로 Dio 로 갈아탄다.

final class AuthRepositoryProvider
    extends $FunctionalProvider<AuthRepository, AuthRepository, AuthRepository>
    with $Provider<AuthRepository> {
  /// 로그인은 실제 서버(`challroom_api`)의 `/v1/auth` 라우터가 이미 구현돼 있어서, 다른
  /// 도메인과 달리 `apiBaseUrl` 이 있으면 바로 Dio 로 갈아탄다.
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

String _$authRepositoryHash() => r'4216d19b04d072ba70259eced034b351fc29be09';

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

/// 로컬 모드에서는 방 만들기로 생긴 방을 기억해야 해서 `keepAlive` 다 — 화면을 옮겨 다녀도
/// [LocalRoomRepository] 인스턴스가(그리고 그 안의 상태가) 계속 살아있어야 한다.

@ProviderFor(roomRepository)
final roomRepositoryProvider = RoomRepositoryProvider._();

/// 로컬 모드에서는 방 만들기로 생긴 방을 기억해야 해서 `keepAlive` 다 — 화면을 옮겨 다녀도
/// [LocalRoomRepository] 인스턴스가(그리고 그 안의 상태가) 계속 살아있어야 한다.

final class RoomRepositoryProvider
    extends $FunctionalProvider<RoomRepository, RoomRepository, RoomRepository>
    with $Provider<RoomRepository> {
  /// 로컬 모드에서는 방 만들기로 생긴 방을 기억해야 해서 `keepAlive` 다 — 화면을 옮겨 다녀도
  /// [LocalRoomRepository] 인스턴스가(그리고 그 안의 상태가) 계속 살아있어야 한다.
  RoomRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'roomRepositoryProvider',
        isAutoDispose: false,
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

String _$roomRepositoryHash() => r'd96b1a07903efce682b53d56c5433410939e463c';

/// 방 목록과 마찬가지로 작성한 댓글이 화면을 옮겨도 남아있어야 해서 `keepAlive` 다.

@ProviderFor(commentRepository)
final commentRepositoryProvider = CommentRepositoryProvider._();

/// 방 목록과 마찬가지로 작성한 댓글이 화면을 옮겨도 남아있어야 해서 `keepAlive` 다.

final class CommentRepositoryProvider
    extends
        $FunctionalProvider<
          CommentRepository,
          CommentRepository,
          CommentRepository
        >
    with $Provider<CommentRepository> {
  /// 방 목록과 마찬가지로 작성한 댓글이 화면을 옮겨도 남아있어야 해서 `keepAlive` 다.
  CommentRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'commentRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$commentRepositoryHash();

  @$internal
  @override
  $ProviderElement<CommentRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CommentRepository create(Ref ref) {
    return commentRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CommentRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CommentRepository>(value),
    );
  }
}

String _$commentRepositoryHash() => r'e475b42184d42491d116b5ff197b78e72273f72d';

@ProviderFor(noticeRepository)
final noticeRepositoryProvider = NoticeRepositoryProvider._();

final class NoticeRepositoryProvider
    extends
        $FunctionalProvider<
          NoticeRepository,
          NoticeRepository,
          NoticeRepository
        >
    with $Provider<NoticeRepository> {
  NoticeRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'noticeRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$noticeRepositoryHash();

  @$internal
  @override
  $ProviderElement<NoticeRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  NoticeRepository create(Ref ref) {
    return noticeRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NoticeRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NoticeRepository>(value),
    );
  }
}

String _$noticeRepositoryHash() => r'9ec355dd039a4daa8c53de45f28473f78032c4be';

@ProviderFor(faqRepository)
final faqRepositoryProvider = FaqRepositoryProvider._();

final class FaqRepositoryProvider
    extends $FunctionalProvider<FaqRepository, FaqRepository, FaqRepository>
    with $Provider<FaqRepository> {
  FaqRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'faqRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$faqRepositoryHash();

  @$internal
  @override
  $ProviderElement<FaqRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FaqRepository create(Ref ref) {
    return faqRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FaqRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FaqRepository>(value),
    );
  }
}

String _$faqRepositoryHash() => r'8d6e34b98b4748e90ef5b29fcf882b69f27dc858';

/// 신청 수락처럼 이 세션 안에서 실제로 생긴 알림을 쌓아둬야 해서 `keepAlive` 다 — 방/댓글
/// 저장소와 같은 이유.

@ProviderFor(notificationRepository)
final notificationRepositoryProvider = NotificationRepositoryProvider._();

/// 신청 수락처럼 이 세션 안에서 실제로 생긴 알림을 쌓아둬야 해서 `keepAlive` 다 — 방/댓글
/// 저장소와 같은 이유.

final class NotificationRepositoryProvider
    extends
        $FunctionalProvider<
          NotificationRepository,
          NotificationRepository,
          NotificationRepository
        >
    with $Provider<NotificationRepository> {
  /// 신청 수락처럼 이 세션 안에서 실제로 생긴 알림을 쌓아둬야 해서 `keepAlive` 다 — 방/댓글
  /// 저장소와 같은 이유.
  NotificationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationRepositoryHash();

  @$internal
  @override
  $ProviderElement<NotificationRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationRepository create(Ref ref) {
    return notificationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationRepository>(value),
    );
  }
}

String _$notificationRepositoryHash() =>
    r'1edb487f05aaa80eb52c5806b52200e89f9cb343';

@ProviderFor(reportRepository)
final reportRepositoryProvider = ReportRepositoryProvider._();

final class ReportRepositoryProvider
    extends
        $FunctionalProvider<
          ReportRepository,
          ReportRepository,
          ReportRepository
        >
    with $Provider<ReportRepository> {
  ReportRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reportRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reportRepositoryHash();

  @$internal
  @override
  $ProviderElement<ReportRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ReportRepository create(Ref ref) {
    return reportRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReportRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReportRepository>(value),
    );
  }
}

String _$reportRepositoryHash() => r'1a88637457e7b3879f1cd0e9f777b93f3da22e4f';
