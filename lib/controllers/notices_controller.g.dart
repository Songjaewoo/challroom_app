// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notices_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notices)
final noticesProvider = NoticesProvider._();

final class NoticesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Notice>>,
          List<Notice>,
          FutureOr<List<Notice>>
        >
    with $FutureModifier<List<Notice>>, $FutureProvider<List<Notice>> {
  NoticesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'noticesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$noticesHash();

  @$internal
  @override
  $FutureProviderElement<List<Notice>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Notice>> create(Ref ref) {
    return notices(ref);
  }
}

String _$noticesHash() => r'cacc24cbcd999d1fbc57c0b11de0fbb06456a77e';
