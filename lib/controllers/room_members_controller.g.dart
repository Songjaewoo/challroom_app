// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_members_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 멤버 내보내기 액션 상태. 멤버 목록 자체는 [roomDetailProvider] 를 그대로 본다 —
/// 이 화면만을 위한 별도 조회는 두지 않는다.

@ProviderFor(RoomMembers)
final roomMembersProvider = RoomMembersFamily._();

/// 멤버 내보내기 액션 상태. 멤버 목록 자체는 [roomDetailProvider] 를 그대로 본다 —
/// 이 화면만을 위한 별도 조회는 두지 않는다.
final class RoomMembersProvider
    extends $AsyncNotifierProvider<RoomMembers, void> {
  /// 멤버 내보내기 액션 상태. 멤버 목록 자체는 [roomDetailProvider] 를 그대로 본다 —
  /// 이 화면만을 위한 별도 조회는 두지 않는다.
  RoomMembersProvider._({
    required RoomMembersFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'roomMembersProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$roomMembersHash();

  @override
  String toString() {
    return r'roomMembersProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  RoomMembers create() => RoomMembers();

  @override
  bool operator ==(Object other) {
    return other is RoomMembersProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$roomMembersHash() => r'75ef0030c7815264842e34874298c4fda667cd64';

/// 멤버 내보내기 액션 상태. 멤버 목록 자체는 [roomDetailProvider] 를 그대로 본다 —
/// 이 화면만을 위한 별도 조회는 두지 않는다.

final class RoomMembersFamily extends $Family
    with
        $ClassFamilyOverride<
          RoomMembers,
          AsyncValue<void>,
          void,
          FutureOr<void>,
          int
        > {
  RoomMembersFamily._()
    : super(
        retry: null,
        name: r'roomMembersProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// 멤버 내보내기 액션 상태. 멤버 목록 자체는 [roomDetailProvider] 를 그대로 본다 —
  /// 이 화면만을 위한 별도 조회는 두지 않는다.

  RoomMembersProvider call(int roomId) =>
      RoomMembersProvider._(argument: roomId, from: this);

  @override
  String toString() => r'roomMembersProvider';
}

/// 멤버 내보내기 액션 상태. 멤버 목록 자체는 [roomDetailProvider] 를 그대로 본다 —
/// 이 화면만을 위한 별도 조회는 두지 않는다.

abstract class _$RoomMembers extends $AsyncNotifier<void> {
  late final _$args = ref.$arg as int;
  int get roomId => _$args;

  FutureOr<void> build(int roomId);
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
    element.handleCreate(ref, () => build(_$args));
  }
}
