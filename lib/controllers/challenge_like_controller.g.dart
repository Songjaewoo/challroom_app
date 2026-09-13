// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge_like_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 좋아요 토글 액션 상태 — 원본 영상 좋아요든 제출 영상 좋아요든 이 챌린지 하나에 딸린
/// [challengeDetailProvider] 를 그대로 다시 불러와 반영한다. [RoomApplicants] 와 같은 패턴.

@ProviderFor(ChallengeLike)
final challengeLikeProvider = ChallengeLikeFamily._();

/// 좋아요 토글 액션 상태 — 원본 영상 좋아요든 제출 영상 좋아요든 이 챌린지 하나에 딸린
/// [challengeDetailProvider] 를 그대로 다시 불러와 반영한다. [RoomApplicants] 와 같은 패턴.
final class ChallengeLikeProvider
    extends $AsyncNotifierProvider<ChallengeLike, void> {
  /// 좋아요 토글 액션 상태 — 원본 영상 좋아요든 제출 영상 좋아요든 이 챌린지 하나에 딸린
  /// [challengeDetailProvider] 를 그대로 다시 불러와 반영한다. [RoomApplicants] 와 같은 패턴.
  ChallengeLikeProvider._({
    required ChallengeLikeFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'challengeLikeProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$challengeLikeHash();

  @override
  String toString() {
    return r'challengeLikeProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ChallengeLike create() => ChallengeLike();

  @override
  bool operator ==(Object other) {
    return other is ChallengeLikeProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$challengeLikeHash() => r'2432468e99a6d64b508f3801f4e592ea72875547';

/// 좋아요 토글 액션 상태 — 원본 영상 좋아요든 제출 영상 좋아요든 이 챌린지 하나에 딸린
/// [challengeDetailProvider] 를 그대로 다시 불러와 반영한다. [RoomApplicants] 와 같은 패턴.

final class ChallengeLikeFamily extends $Family
    with
        $ClassFamilyOverride<
          ChallengeLike,
          AsyncValue<void>,
          void,
          FutureOr<void>,
          int
        > {
  ChallengeLikeFamily._()
    : super(
        retry: null,
        name: r'challengeLikeProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// 좋아요 토글 액션 상태 — 원본 영상 좋아요든 제출 영상 좋아요든 이 챌린지 하나에 딸린
  /// [challengeDetailProvider] 를 그대로 다시 불러와 반영한다. [RoomApplicants] 와 같은 패턴.

  ChallengeLikeProvider call(int challengeId) =>
      ChallengeLikeProvider._(argument: challengeId, from: this);

  @override
  String toString() => r'challengeLikeProvider';
}

/// 좋아요 토글 액션 상태 — 원본 영상 좋아요든 제출 영상 좋아요든 이 챌린지 하나에 딸린
/// [challengeDetailProvider] 를 그대로 다시 불러와 반영한다. [RoomApplicants] 와 같은 패턴.

abstract class _$ChallengeLike extends $AsyncNotifier<void> {
  late final _$args = ref.$arg as int;
  int get challengeId => _$args;

  FutureOr<void> build(int challengeId);
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
