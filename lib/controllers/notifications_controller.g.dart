// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notifications)
final notificationsProvider = NotificationsProvider._();

final class NotificationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AppNotification>>,
          List<AppNotification>,
          FutureOr<List<AppNotification>>
        >
    with
        $FutureModifier<List<AppNotification>>,
        $FutureProvider<List<AppNotification>> {
  NotificationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationsHash();

  @$internal
  @override
  $FutureProviderElement<List<AppNotification>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<AppNotification>> create(Ref ref) {
    return notifications(ref);
  }
}

String _$notificationsHash() => r'79228277ae07f09987f1de92a18894eaac85ae03';

/// 벨 아이콘 배지 숫자 — [notificationsProvider] 를 그대로 보고 안 읽은 것만 센다.
/// 화면 하나만을 위한 값이라 따로 조회하지 않는다.

@ProviderFor(unreadNotificationCount)
final unreadNotificationCountProvider = UnreadNotificationCountProvider._();

/// 벨 아이콘 배지 숫자 — [notificationsProvider] 를 그대로 보고 안 읽은 것만 센다.
/// 화면 하나만을 위한 값이라 따로 조회하지 않는다.

final class UnreadNotificationCountProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  /// 벨 아이콘 배지 숫자 — [notificationsProvider] 를 그대로 보고 안 읽은 것만 센다.
  /// 화면 하나만을 위한 값이라 따로 조회하지 않는다.
  UnreadNotificationCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'unreadNotificationCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$unreadNotificationCountHash();

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    return unreadNotificationCount(ref);
  }
}

String _$unreadNotificationCountHash() =>
    r'27f17c610e1ecd9f52d242b231f0f1707a09bde4';

/// 알림함 화면에 들어가면 전부 읽음 처리한다.

@ProviderFor(NotificationsRead)
final notificationsReadProvider = NotificationsReadProvider._();

/// 알림함 화면에 들어가면 전부 읽음 처리한다.
final class NotificationsReadProvider
    extends $AsyncNotifierProvider<NotificationsRead, void> {
  /// 알림함 화면에 들어가면 전부 읽음 처리한다.
  NotificationsReadProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationsReadProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationsReadHash();

  @$internal
  @override
  NotificationsRead create() => NotificationsRead();
}

String _$notificationsReadHash() => r'f302469d260bedae6c7adf7636f3bd1c0e7dc811';

/// 알림함 화면에 들어가면 전부 읽음 처리한다.

abstract class _$NotificationsRead extends $AsyncNotifier<void> {
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
