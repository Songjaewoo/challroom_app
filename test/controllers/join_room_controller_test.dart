import 'package:challroom_app/controllers/join_room_controller.dart';
import 'package:challroom_app/core/error/api_exception.dart';
import 'package:challroom_app/models/enums.dart';
import 'package:challroom_app/models/rooms.dart';
import 'package:challroom_app/providers.dart';
import 'package:challroom_app/repositories/room_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRoomRepository extends Mock implements RoomRepository {}

const _room = Room(id: 1, title: '우리끼리 텐션 챌린지', participantCount: 5, status: RoomStatus.ongoing);

void main() {
  late MockRoomRepository repo;

  setUp(() {
    repo = MockRoomRepository();
  });

  ProviderContainer makeContainer() => ProviderContainer.test(
    overrides: [roomRepositoryProvider.overrideWithValue(repo)],
    retry: (retryCount, error) => null,
  );

  test('build() 는 처음에 null 이다 — 열자마자 이동하면 안 된다', () async {
    final container = makeContainer();
    expect(await container.read(joinRoomProvider.future), isNull);
  });

  test('코드가 유효하면 들어간 방을 상태로 들고, 내 방 목록을 다시 조회한다', () async {
    when(() => repo.joinRoomByCode('ABCD12')).thenAnswer((_) async => _room);
    when(repo.fetchMyRooms).thenAnswer((_) async => [_room]);

    final container = makeContainer();
    await container.read(joinRoomProvider.future);

    // 앞뒤 공백만 다듬어 그대로 넘긴다 — 대소문자 구분은 서버(로컬 목업)가 한다.
    await container.read(joinRoomProvider.notifier).submit('  ABCD12  ');

    expect(container.read(joinRoomProvider).value, _room);
    verify(() => repo.joinRoomByCode('ABCD12')).called(1);
  });

  test('코드가 유효하지 않으면 AsyncError 가 된다', () async {
    when(
      () => repo.joinRoomByCode(any()),
    ).thenThrow(const ApiException(statusCode: 404, code: 'INVITE_CODE_NOT_FOUND', message: '유효하지 않은 초대 코드예요.'));

    final container = makeContainer();
    await container.read(joinRoomProvider.future);

    await container.read(joinRoomProvider.notifier).submit('ZZZZZZ');

    expect(container.read(joinRoomProvider), isA<AsyncError<Room?>>());
  });

  test('빈 코드는 요청하지 않는다', () async {
    final container = makeContainer();
    await container.read(joinRoomProvider.future);

    await container.read(joinRoomProvider.notifier).submit('   ');

    verifyNever(() => repo.joinRoomByCode(any()));
  });
}
