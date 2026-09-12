import 'package:challroom_app/controllers/challenge_detail_controller.dart';
import 'package:challroom_app/core/error/api_exception.dart';
import 'package:challroom_app/models/rooms.dart';
import 'package:challroom_app/models/submissions.dart';
import 'package:challroom_app/providers.dart';
import 'package:challroom_app/repositories/room_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRoomRepository extends Mock implements RoomRepository {}

const _detail = ChallengeDetail(
  id: 1,
  title: '3초 텐션 올리기',
  source: 'YouTube Shorts',
  videoUrl: 'https://youtube.com/shorts/abc',
  totalCount: 4,
  submissions: [Submission(id: 1, nickname: '민지', commentCount: 2)],
);

void main() {
  late MockRoomRepository repo;

  setUp(() {
    repo = MockRoomRepository();
  });

  ProviderContainer makeContainer() => ProviderContainer.test(
    overrides: [roomRepositoryProvider.overrideWithValue(repo)],
    retry: (retryCount, error) => null,
  );

  test('챌린지 id로 상세 정보(원본 영상 + 제출 목록)를 불러온다', () async {
    when(() => repo.fetchChallengeDetail(1)).thenAnswer((_) async => _detail);

    final container = makeContainer();

    expect(await container.read(challengeDetailProvider(1).future), _detail);
    verify(() => repo.fetchChallengeDetail(1)).called(1);
  });

  test('없는 챌린지면 AsyncError 가 된다', () async {
    when(
      () => repo.fetchChallengeDetail(any()),
    ).thenThrow(const ApiException(statusCode: 404, code: 'CHALLENGE_NOT_FOUND', message: '챌린지를 찾을 수 없어요.'));

    final container = makeContainer();
    await container.read(challengeDetailProvider(999).future).catchError((_) => _detail);

    expect(container.read(challengeDetailProvider(999)), isA<AsyncError<ChallengeDetail>>());
  });
}
