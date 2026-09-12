// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge_detail_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(challengeDetail)
final challengeDetailProvider = ChallengeDetailFamily._();

final class ChallengeDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<ChallengeDetail>,
          ChallengeDetail,
          FutureOr<ChallengeDetail>
        >
    with $FutureModifier<ChallengeDetail>, $FutureProvider<ChallengeDetail> {
  ChallengeDetailProvider._({
    required ChallengeDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'challengeDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$challengeDetailHash();

  @override
  String toString() {
    return r'challengeDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ChallengeDetail> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ChallengeDetail> create(Ref ref) {
    final argument = this.argument as int;
    return challengeDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ChallengeDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$challengeDetailHash() => r'28f2a9a3a37e65dc3bb9f1ca4c1fcc8b059edcab';

final class ChallengeDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ChallengeDetail>, int> {
  ChallengeDetailFamily._()
    : super(
        retry: null,
        name: r'challengeDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ChallengeDetailProvider call(int challengeId) =>
      ChallengeDetailProvider._(argument: challengeId, from: this);

  @override
  String toString() => r'challengeDetailProvider';
}
