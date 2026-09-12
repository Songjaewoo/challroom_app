// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_rooms_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(myRooms)
final myRoomsProvider = MyRoomsProvider._();

final class MyRoomsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Room>>,
          List<Room>,
          FutureOr<List<Room>>
        >
    with $FutureModifier<List<Room>>, $FutureProvider<List<Room>> {
  MyRoomsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myRoomsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myRoomsHash();

  @$internal
  @override
  $FutureProviderElement<List<Room>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Room>> create(Ref ref) {
    return myRooms(ref);
  }
}

String _$myRoomsHash() => r'86526f30c5efcdf542fc077db80101c14b04471a';
