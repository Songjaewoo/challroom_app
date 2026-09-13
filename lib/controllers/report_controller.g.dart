// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// [ReportScreen] 하나를 위한 제출 액션 상태.

@ProviderFor(ReportSubmit)
final reportSubmitProvider = ReportSubmitProvider._();

/// [ReportScreen] 하나를 위한 제출 액션 상태.
final class ReportSubmitProvider
    extends $AsyncNotifierProvider<ReportSubmit, void> {
  /// [ReportScreen] 하나를 위한 제출 액션 상태.
  ReportSubmitProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reportSubmitProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reportSubmitHash();

  @$internal
  @override
  ReportSubmit create() => ReportSubmit();
}

String _$reportSubmitHash() => r'd6245d2b4dd5636c0b0d52936c1a2fd52d65fabe';

/// [ReportScreen] 하나를 위한 제출 액션 상태.

abstract class _$ReportSubmit extends $AsyncNotifier<void> {
  FutureOr<void> build();
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
    element.handleCreate(ref, build);
  }
}
