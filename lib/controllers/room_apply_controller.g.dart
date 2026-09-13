// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_apply_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// "신청"/"신청취소" 배지의 액션 상태 — 방 하나당 하나. 성공하면 홈 목록과 "내 방" 목록을
/// 둘 다 다시 불러와 배지가 즉시 바뀌도록 한다.

@ProviderFor(RoomApply)
final roomApplyProvider = RoomApplyFamily._();

/// "신청"/"신청취소" 배지의 액션 상태 — 방 하나당 하나. 성공하면 홈 목록과 "내 방" 목록을
/// 둘 다 다시 불러와 배지가 즉시 바뀌도록 한다.
final class RoomApplyProvider extends $AsyncNotifierProvider<RoomApply, void> {
  /// "신청"/"신청취소" 배지의 액션 상태 — 방 하나당 하나. 성공하면 홈 목록과 "내 방" 목록을
  /// 둘 다 다시 불러와 배지가 즉시 바뀌도록 한다.
  RoomApplyProvider._({
    required RoomApplyFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'roomApplyProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$roomApplyHash();

  @override
  String toString() {
    return r'roomApplyProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  RoomApply create() => RoomApply();

  @override
  bool operator ==(Object other) {
    return other is RoomApplyProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$roomApplyHash() => r'71822855ae8d8397fc1db7feafb7ddabe88be6b2';

/// "신청"/"신청취소" 배지의 액션 상태 — 방 하나당 하나. 성공하면 홈 목록과 "내 방" 목록을
/// 둘 다 다시 불러와 배지가 즉시 바뀌도록 한다.

final class RoomApplyFamily extends $Family
    with
        $ClassFamilyOverride<
          RoomApply,
          AsyncValue<void>,
          void,
          FutureOr<void>,
          int
        > {
  RoomApplyFamily._()
    : super(
        retry: null,
        name: r'roomApplyProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// "신청"/"신청취소" 배지의 액션 상태 — 방 하나당 하나. 성공하면 홈 목록과 "내 방" 목록을
  /// 둘 다 다시 불러와 배지가 즉시 바뀌도록 한다.

  RoomApplyProvider call(int roomId) =>
      RoomApplyProvider._(argument: roomId, from: this);

  @override
  String toString() => r'roomApplyProvider';
}

/// "신청"/"신청취소" 배지의 액션 상태 — 방 하나당 하나. 성공하면 홈 목록과 "내 방" 목록을
/// 둘 다 다시 불러와 배지가 즉시 바뀌도록 한다.

abstract class _$RoomApply extends $AsyncNotifier<void> {
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
