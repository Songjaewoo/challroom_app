import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/rooms.dart';
import '../providers.dart';

part 'challenge_detail_controller.g.dart';

@riverpod
Future<ChallengeDetail> challengeDetail(Ref ref, int challengeId) {
  return ref.watch(roomRepositoryProvider).fetchChallengeDetail(challengeId);
}
