import 'package:challroom_app/controllers/create_room_controller.dart';
import 'package:challroom_app/controllers/home_controller.dart';
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

const _created = Room(id: 10, title: '새 방', participantCount: 1, status: RoomStatus.open);

void main() {
  setUpAll(() {
    registerFallbackValue(const RoomCreateReq(title: ''));
  });

  late MockRoomRepository repo;

  setUp(() {
    repo = MockRoomRepository();
    when(() => repo.fetchRooms(category: any(named: 'category'))).thenAnswer((_) async => const []);
    when(repo.fetchMyRooms).thenAnswer((_) async => const []);
  });

  ProviderContainer makeContainer() => ProviderContainer.test(
    overrides: [roomRepositoryProvider.overrideWithValue(repo)],
    retry: (retryCount, error) => null,
  );

  test('방을 만들면 만들어진 방을 상태로 들고, 방 목록/내 방 목록을 다시 조회한다', () async {
    when(() => repo.createRoom(any())).thenAnswer((_) async => _created);

    final container = makeContainer();
    // 캐시됐는지 확인하기 위해 미리 한 번 구독해 둔다.
    await container.read(roomListProvider.future);
    await container.read(myRoomsProvider.future);
    clearInteractions(repo);
    when(() => repo.fetchRooms(category: any(named: 'category'))).thenAnswer((_) async => const []);
    when(repo.fetchMyRooms).thenAnswer((_) async => const []);
    when(() => repo.createRoom(any())).thenAnswer((_) async => _created);

    await container.read(createRoomProvider.notifier).submit(const RoomCreateReq(title: '새 방'));

    expect(container.read(createRoomProvider).value, _created);
    verify(() => repo.createRoom(const RoomCreateReq(title: '새 방'))).called(1);
  });

  test('만들기에 실패하면 AsyncError 가 된다', () async {
    when(
      () => repo.createRoom(any()),
    ).thenThrow(const ApiException(statusCode: 400, code: 'INVALID_TITLE', message: '방 이름을 확인해 주세요.'));

    final container = makeContainer();

    await container.read(createRoomProvider.notifier).submit(const RoomCreateReq(title: ''));

    expect(container.read(createRoomProvider), isA<AsyncError<Room?>>());
  });
}
