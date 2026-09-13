import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../providers.dart';
import 'challenge_detail_controller.dart';

part 'challenge_like_controller.g.dart';

/// 좋아요 토글 액션 상태 — 원본 영상 좋아요든 제출 영상 좋아요든 이 챌린지 하나에 딸린
/// [challengeDetailProvider] 를 그대로 다시 불러와 반영한다. [RoomApplicants] 와 같은 패턴.
@riverpod
class ChallengeLike extends _$ChallengeLike {
  @override
  Future<void> build(int challengeId) async {}

  Future<void> toggleChallenge() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(roomRepositoryProvider).toggleChallengeLike(challengeId);
    });

    if (state.hasError) return;
    ref.invalidate(challengeDetailProvider(challengeId));
  }

  Future<void> toggleSubmission(int submissionId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(roomRepositoryProvider).toggleSubmissionLike(challengeId, submissionId);
    });

    if (state.hasError) return;
    ref.invalidate(challengeDetailProvider(challengeId));
  }
}
