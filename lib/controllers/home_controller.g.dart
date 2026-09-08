// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(weeklyPicks)
final weeklyPicksProvider = WeeklyPicksProvider._();

final class WeeklyPicksProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PickVideo>>,
          List<PickVideo>,
          FutureOr<List<PickVideo>>
        >
    with $FutureModifier<List<PickVideo>>, $FutureProvider<List<PickVideo>> {
  WeeklyPicksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'weeklyPicksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$weeklyPicksHash();

  @$internal
  @override
  $FutureProviderElement<List<PickVideo>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PickVideo>> create(Ref ref) {
    return weeklyPicks(ref);
  }
}

String _$weeklyPicksHash() => r'0b3dd0d77b214a5b00a1eca55b2e1f5ab031c831';

/// 카테고리 칩 선택 상태. `null` 은 "전체". [roomListProvider] 가 이 값을 보고 다시 조회한다.

@ProviderFor(SelectedRoomCategory)
final selectedRoomCategoryProvider = SelectedRoomCategoryProvider._();

/// 카테고리 칩 선택 상태. `null` 은 "전체". [roomListProvider] 가 이 값을 보고 다시 조회한다.
final class SelectedRoomCategoryProvider
    extends $NotifierProvider<SelectedRoomCategory, RoomCategory?> {
  /// 카테고리 칩 선택 상태. `null` 은 "전체". [roomListProvider] 가 이 값을 보고 다시 조회한다.
  SelectedRoomCategoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedRoomCategoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedRoomCategoryHash();

  @$internal
  @override
  SelectedRoomCategory create() => SelectedRoomCategory();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RoomCategory? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RoomCategory?>(value),
    );
  }
}

String _$selectedRoomCategoryHash() =>
    r'f7e5db905c09e6749b5c8d1c8c721e6043d7afab';

/// 카테고리 칩 선택 상태. `null` 은 "전체". [roomListProvider] 가 이 값을 보고 다시 조회한다.

abstract class _$SelectedRoomCategory extends $Notifier<RoomCategory?> {
  RoomCategory? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<RoomCategory?, RoomCategory?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RoomCategory?, RoomCategory?>,
              RoomCategory?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(roomList)
final roomListProvider = RoomListProvider._();

final class RoomListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Room>>,
          List<Room>,
          FutureOr<List<Room>>
        >
    with $FutureModifier<List<Room>>, $FutureProvider<List<Room>> {
  RoomListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'roomListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$roomListHash();

  @$internal
  @override
  $FutureProviderElement<List<Room>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Room>> create(Ref ref) {
    return roomList(ref);
  }
}

String _$roomListHash() => r'f84b8dac9390dde0fd0eb79c3fd97467cb84b807';
