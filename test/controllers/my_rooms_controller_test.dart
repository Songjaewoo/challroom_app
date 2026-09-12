import 'package:challroom_app/controllers/my_rooms_controller.dart';
import 'package:challroom_app/core/error/api_exception.dart';
import 'package:challroom_app/models/enums.dart';
import 'package:challroom_app/models/rooms.dart';
import 'package:challroom_app/providers.dart';
import 'package:challroom_app/repositories/room_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRoomRepository extends Mock implements RoomRepository {}

const _room = Room(id: 1, title: '우리끼리 텐션 챌린지', participantCount: 4, status: RoomStatus.ongoing);

void main() {
  late MockRoomRepository repo;

  setUp(() {
    repo = MockRoomRepository();
  });

  ProviderContainer makeContainer() => ProviderContainer.test(
    overrides: [roomRepositoryProvider.overrideWithValue(repo)],
    retry: (retryCount, error) => null,
  );

  test('내가 속한 방 목록을 불러온다', () async {
    when(repo.fetchMyRooms).thenAnswer((_) async => const [_room]);

    final container = makeContainer();

    expect(await container.read(myRoomsProvider.future), [_room]);
  });

  test('조회에 실패하면 AsyncError 가 된다', () async {
    when(repo.fetchMyRooms).thenThrow(const ApiException(statusCode: 500, code: 'SERVER_ERROR', message: '문제가 생겼어요.'));

    final container = makeContainer();
    await container.read(myRoomsProvider.future).catchError((_) => const <Room>[]);

    expect(container.read(myRoomsProvider), isA<AsyncError<List<Room>>>());
  });
}
