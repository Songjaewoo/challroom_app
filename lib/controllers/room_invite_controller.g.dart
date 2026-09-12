// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_invite_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 초대 코드 "생성해줘" 요청 상태. 코드 값 자체는 [roomDetailProvider] 의
/// `inviteCode` 에서 본다 — 이 컨트롤러는 생성 액션과 로딩/에러만 다룬다.

@ProviderFor(RoomInvite)
final roomInviteProvider = RoomInviteFamily._();

/// 초대 코드 "생성해줘" 요청 상태. 코드 값 자체는 [roomDetailProvider] 의
/// `inviteCode` 에서 본다 — 이 컨트롤러는 생성 액션과 로딩/에러만 다룬다.
final class RoomInviteProvider
    extends $AsyncNotifierProvider<RoomInvite, void> {
  /// 초대 코드 "생성해줘" 요청 상태. 코드 값 자체는 [roomDetailProvider] 의
  /// `inviteCode` 에서 본다 — 이 컨트롤러는 생성 액션과 로딩/에러만 다룬다.
  RoomInviteProvider._({
    required RoomInviteFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'roomInviteProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$roomInviteHash();

  @override
  String toString() {
    return r'roomInviteProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  RoomInvite create() => RoomInvite();

  @override
  bool operator ==(Object other) {
    return other is RoomInviteProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$roomInviteHash() => r'f76d76c08ddb9f4288426ff5f8af1cdc4189a661';

/// 초대 코드 "생성해줘" 요청 상태. 코드 값 자체는 [roomDetailProvider] 의
/// `inviteCode` 에서 본다 — 이 컨트롤러는 생성 액션과 로딩/에러만 다룬다.

final class RoomInviteFamily extends $Family
    with
        $ClassFamilyOverride<
          RoomInvite,
          AsyncValue<void>,
          void,
          FutureOr<void>,
          int
        > {
  RoomInviteFamily._()
    : super(
        retry: null,
        name: r'roomInviteProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// 초대 코드 "생성해줘" 요청 상태. 코드 값 자체는 [roomDetailProvider] 의
  /// `inviteCode` 에서 본다 — 이 컨트롤러는 생성 액션과 로딩/에러만 다룬다.

  RoomInviteProvider call(int roomId) =>
      RoomInviteProvider._(argument: roomId, from: this);

  @override
  String toString() => r'roomInviteProvider';
}

/// 초대 코드 "생성해줘" 요청 상태. 코드 값 자체는 [roomDetailProvider] 의
/// `inviteCode` 에서 본다 — 이 컨트롤러는 생성 액션과 로딩/에러만 다룬다.

abstract class _$RoomInvite extends $AsyncNotifier<void> {
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
