// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_detail_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(roomDetail)
final roomDetailProvider = RoomDetailFamily._();

final class RoomDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<RoomDetail>,
          RoomDetail,
          FutureOr<RoomDetail>
        >
    with $FutureModifier<RoomDetail>, $FutureProvider<RoomDetail> {
  RoomDetailProvider._({
    required RoomDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'roomDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$roomDetailHash();

  @override
  String toString() {
    return r'roomDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<RoomDetail> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<RoomDetail> create(Ref ref) {
    final argument = this.argument as int;
    return roomDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RoomDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$roomDetailHash() => r'9aa7d657287c129bc81bca0b4cdbbd24fe770144';

final class RoomDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<RoomDetail>, int> {
  RoomDetailFamily._()
    : super(
        retry: null,
        name: r'roomDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RoomDetailProvider call(int roomId) =>
      RoomDetailProvider._(argument: roomId, from: this);

  @override
  String toString() => r'roomDetailProvider';
}
