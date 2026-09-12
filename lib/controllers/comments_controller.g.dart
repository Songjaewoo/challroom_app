// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 댓글 바텀시트 하나의 상태 — [CommentTarget] 값만 바꿔가며 원본 영상 댓글과
/// 제출 영상 댓글 양쪽에 다 쓴다([CommentsSheet] 참고).

@ProviderFor(Comments)
final commentsProvider = CommentsFamily._();

/// 댓글 바텀시트 하나의 상태 — [CommentTarget] 값만 바꿔가며 원본 영상 댓글과
/// 제출 영상 댓글 양쪽에 다 쓴다([CommentsSheet] 참고).
final class CommentsProvider
    extends $AsyncNotifierProvider<Comments, List<Comment>> {
  /// 댓글 바텀시트 하나의 상태 — [CommentTarget] 값만 바꿔가며 원본 영상 댓글과
  /// 제출 영상 댓글 양쪽에 다 쓴다([CommentsSheet] 참고).
  CommentsProvider._({
    required CommentsFamily super.from,
    required CommentTarget super.argument,
  }) : super(
         retry: null,
         name: r'commentsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$commentsHash();

  @override
  String toString() {
    return r'commentsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  Comments create() => Comments();

  @override
  bool operator ==(Object other) {
    return other is CommentsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$commentsHash() => r'e6ec92507991fad8d46527daf7833edec364759a';

/// 댓글 바텀시트 하나의 상태 — [CommentTarget] 값만 바꿔가며 원본 영상 댓글과
/// 제출 영상 댓글 양쪽에 다 쓴다([CommentsSheet] 참고).

final class CommentsFamily extends $Family
    with
        $ClassFamilyOverride<
          Comments,
          AsyncValue<List<Comment>>,
          List<Comment>,
          FutureOr<List<Comment>>,
          CommentTarget
        > {
  CommentsFamily._()
    : super(
        retry: null,
        name: r'commentsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// 댓글 바텀시트 하나의 상태 — [CommentTarget] 값만 바꿔가며 원본 영상 댓글과
  /// 제출 영상 댓글 양쪽에 다 쓴다([CommentsSheet] 참고).

  CommentsProvider call(CommentTarget target) =>
      CommentsProvider._(argument: target, from: this);

  @override
  String toString() => r'commentsProvider';
}

/// 댓글 바텀시트 하나의 상태 — [CommentTarget] 값만 바꿔가며 원본 영상 댓글과
/// 제출 영상 댓글 양쪽에 다 쓴다([CommentsSheet] 참고).

abstract class _$Comments extends $AsyncNotifier<List<Comment>> {
  late final _$args = ref.$arg as CommentTarget;
  CommentTarget get target => _$args;

  FutureOr<List<Comment>> build(CommentTarget target);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Comment>>, List<Comment>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Comment>>, List<Comment>>,
              AsyncValue<List<Comment>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
