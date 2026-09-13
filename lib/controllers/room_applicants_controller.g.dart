// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_applicants_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 신청 수락/거절 액션 상태 — 신청자 목록 자체는 [roomDetailProvider] 의
/// `pendingApplicants` 를 그대로 본다. [RoomMembersController] 와 같은 패턴.

@ProviderFor(RoomApplicants)
final roomApplicantsProvider = RoomApplicantsFamily._();

/// 신청 수락/거절 액션 상태 — 신청자 목록 자체는 [roomDetailProvider] 의
/// `pendingApplicants` 를 그대로 본다. [RoomMembersController] 와 같은 패턴.
final class RoomApplicantsProvider
    extends $AsyncNotifierProvider<RoomApplicants, void> {
  /// 신청 수락/거절 액션 상태 — 신청자 목록 자체는 [roomDetailProvider] 의
  /// `pendingApplicants` 를 그대로 본다. [RoomMembersController] 와 같은 패턴.
  RoomApplicantsProvider._({
    required RoomApplicantsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'roomApplicantsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$roomApplicantsHash();

  @override
  String toString() {
    return r'roomApplicantsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  RoomApplicants create() => RoomApplicants();

  @override
  bool operator ==(Object other) {
    return other is RoomApplicantsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$roomApplicantsHash() => r'a5dab787d690fc769c3104b1a851ef9e7827e0ef';

/// 신청 수락/거절 액션 상태 — 신청자 목록 자체는 [roomDetailProvider] 의
/// `pendingApplicants` 를 그대로 본다. [RoomMembersController] 와 같은 패턴.

final class RoomApplicantsFamily extends $Family
    with
        $ClassFamilyOverride<
          RoomApplicants,
          AsyncValue<void>,
          void,
          FutureOr<void>,
          int
        > {
  RoomApplicantsFamily._()
    : super(
        retry: null,
        name: r'roomApplicantsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// 신청 수락/거절 액션 상태 — 신청자 목록 자체는 [roomDetailProvider] 의
  /// `pendingApplicants` 를 그대로 본다. [RoomMembersController] 와 같은 패턴.

  RoomApplicantsProvider call(int roomId) =>
      RoomApplicantsProvider._(argument: roomId, from: this);

  @override
  String toString() => r'roomApplicantsProvider';
}

/// 신청 수락/거절 액션 상태 — 신청자 목록 자체는 [roomDetailProvider] 의
/// `pendingApplicants` 를 그대로 본다. [RoomMembersController] 와 같은 패턴.

abstract class _$RoomApplicants extends $AsyncNotifier<void> {
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
