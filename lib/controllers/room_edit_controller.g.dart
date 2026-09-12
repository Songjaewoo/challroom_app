// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_edit_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 방 정보 수정 화면의 저장 상태. 화면 자체는 [RoomEditScreen] 에 넘어온 [RoomDetail] 값으로
/// 미리 채워지니, 여기선 조회 없이 제출만 다룬다.

@ProviderFor(RoomEdit)
final roomEditProvider = RoomEditFamily._();

/// 방 정보 수정 화면의 저장 상태. 화면 자체는 [RoomEditScreen] 에 넘어온 [RoomDetail] 값으로
/// 미리 채워지니, 여기선 조회 없이 제출만 다룬다.
final class RoomEditProvider extends $AsyncNotifierProvider<RoomEdit, void> {
  /// 방 정보 수정 화면의 저장 상태. 화면 자체는 [RoomEditScreen] 에 넘어온 [RoomDetail] 값으로
  /// 미리 채워지니, 여기선 조회 없이 제출만 다룬다.
  RoomEditProvider._({
    required RoomEditFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'roomEditProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$roomEditHash();

  @override
  String toString() {
    return r'roomEditProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  RoomEdit create() => RoomEdit();

  @override
  bool operator ==(Object other) {
    return other is RoomEditProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$roomEditHash() => r'598004be35468847d7caf2dd3d6936e8e63e4ec7';

/// 방 정보 수정 화면의 저장 상태. 화면 자체는 [RoomEditScreen] 에 넘어온 [RoomDetail] 값으로
/// 미리 채워지니, 여기선 조회 없이 제출만 다룬다.

final class RoomEditFamily extends $Family
    with
        $ClassFamilyOverride<
          RoomEdit,
          AsyncValue<void>,
          void,
          FutureOr<void>,
          int
        > {
  RoomEditFamily._()
    : super(
        retry: null,
        name: r'roomEditProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// 방 정보 수정 화면의 저장 상태. 화면 자체는 [RoomEditScreen] 에 넘어온 [RoomDetail] 값으로
  /// 미리 채워지니, 여기선 조회 없이 제출만 다룬다.

  RoomEditProvider call(int roomId) =>
      RoomEditProvider._(argument: roomId, from: this);

  @override
  String toString() => r'roomEditProvider';
}

/// 방 정보 수정 화면의 저장 상태. 화면 자체는 [RoomEditScreen] 에 넘어온 [RoomDetail] 값으로
/// 미리 채워지니, 여기선 조회 없이 제출만 다룬다.

abstract class _$RoomEdit extends $AsyncNotifier<void> {
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
