import 'package:challroom_app/controllers/room_detail_controller.dart';
import 'package:challroom_app/core/error/api_exception.dart';
import 'package:challroom_app/models/rooms.dart';
import 'package:challroom_app/providers.dart';
import 'package:challroom_app/repositories/room_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRoomRepository extends Mock implements RoomRepository {}

const _detail = RoomDetail(
  id: 1,
  title: '우리끼리 텐션 챌린지',
  members: [
    ParticipantInfo(nickname: '민지'),
    ParticipantInfo(nickname: '서준'),
  ],
  memberCount: 2,
  challenges: [RoomChallenge(id: 1, title: '3초 텐션', source: 'YouTube Shorts', submittedCount: 1, totalCount: 2)],
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

  test('방 id로 상세 정보를 불러온다', () async {
    when(() => repo.fetchRoomDetail(1)).thenAnswer((_) async => _detail);

    final container = makeContainer();

    expect(await container.read(roomDetailProvider(1).future), _detail);
    verify(() => repo.fetchRoomDetail(1)).called(1);
  });

  test('없는 방이면 AsyncError 가 된다', () async {
    when(
      () => repo.fetchRoomDetail(any()),
    ).thenThrow(const ApiException(statusCode: 404, code: 'ROOM_NOT_FOUND', message: '방을 찾을 수 없어요.'));

    final container = makeContainer();
    await container.read(roomDetailProvider(999).future).catchError((_) => _detail);

    expect(container.read(roomDetailProvider(999)), isA<AsyncError<RoomDetail>>());
  });
}
