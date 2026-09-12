// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'join_room_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 초대 코드 입력 화면의 제출 상태. 성공하면 들어간 [Room] 을 들고 있다 — 화면이 이 값(널
/// 아님)으로 방 상세 이동을 판단한다. `build()` 가 처음에도 `null` 을 내놓으니, 화면은
/// "값이 있을 때" 만 이동으로 본다 — 열리자마자 이동해버리는 걸 막는다.

@ProviderFor(JoinRoom)
final joinRoomProvider = JoinRoomProvider._();

/// 초대 코드 입력 화면의 제출 상태. 성공하면 들어간 [Room] 을 들고 있다 — 화면이 이 값(널
/// 아님)으로 방 상세 이동을 판단한다. `build()` 가 처음에도 `null` 을 내놓으니, 화면은
/// "값이 있을 때" 만 이동으로 본다 — 열리자마자 이동해버리는 걸 막는다.
final class JoinRoomProvider extends $AsyncNotifierProvider<JoinRoom, Room?> {
  /// 초대 코드 입력 화면의 제출 상태. 성공하면 들어간 [Room] 을 들고 있다 — 화면이 이 값(널
  /// 아님)으로 방 상세 이동을 판단한다. `build()` 가 처음에도 `null` 을 내놓으니, 화면은
  /// "값이 있을 때" 만 이동으로 본다 — 열리자마자 이동해버리는 걸 막는다.
  JoinRoomProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'joinRoomProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$joinRoomHash();

  @$internal
  @override
  JoinRoom create() => JoinRoom();
}

String _$joinRoomHash() => r'c55b1a0c18b93a55fb5c1dc3ec114a3da90e990e';

/// 초대 코드 입력 화면의 제출 상태. 성공하면 들어간 [Room] 을 들고 있다 — 화면이 이 값(널
/// 아님)으로 방 상세 이동을 판단한다. `build()` 가 처음에도 `null` 을 내놓으니, 화면은
/// "값이 있을 때" 만 이동으로 본다 — 열리자마자 이동해버리는 걸 막는다.

abstract class _$JoinRoom extends $AsyncNotifier<Room?> {
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
