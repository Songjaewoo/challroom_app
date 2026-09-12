// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_room_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 방 만들기 화면의 제출 상태. 성공하면 만들어진 [Room] 을 들고 있다 — 화면이 이 값으로
/// 상세 화면 이동을 판단한다.

@ProviderFor(CreateRoom)
final createRoomProvider = CreateRoomProvider._();

/// 방 만들기 화면의 제출 상태. 성공하면 만들어진 [Room] 을 들고 있다 — 화면이 이 값으로
/// 상세 화면 이동을 판단한다.
final class CreateRoomProvider
    extends $AsyncNotifierProvider<CreateRoom, Room?> {
  /// 방 만들기 화면의 제출 상태. 성공하면 만들어진 [Room] 을 들고 있다 — 화면이 이 값으로
  /// 상세 화면 이동을 판단한다.
  CreateRoomProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createRoomProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createRoomHash();

  @$internal
  @override
  CreateRoom create() => CreateRoom();
}

String _$createRoomHash() => r'd4b684652bbe3240744f791d5ddf03f3634f49ad';

/// 방 만들기 화면의 제출 상태. 성공하면 만들어진 [Room] 을 들고 있다 — 화면이 이 값으로
/// 상세 화면 이동을 판단한다.

abstract class _$CreateRoom extends $AsyncNotifier<Room?> {
  FutureOr<Room?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Room?>, Room?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Room?>, Room?>,
              AsyncValue<Room?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
