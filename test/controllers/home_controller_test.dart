import 'package:challroom_app/controllers/home_controller.dart';
import 'package:challroom_app/core/error/api_exception.dart';
import 'package:challroom_app/models/enums.dart';
import 'package:challroom_app/models/pick_videos.dart';
import 'package:challroom_app/models/rooms.dart';
import 'package:challroom_app/providers.dart';
import 'package:challroom_app/repositories/room_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRoomRepository extends Mock implements RoomRepository {}

const _danceRoom = Room(id: 1, title: '춤방', participantCount: 1, status: RoomStatus.open, category: RoomCategory.dance);
const _uncategorizedRoom = Room(id: 2, title: '자유방', participantCount: 1, status: RoomStatus.open);

void main() {
  late MockRoomRepository repo;

  setUp(() {
    repo = MockRoomRepository();
  });

  ProviderContainer makeContainer() => ProviderContainer.test(
    overrides: [roomRepositoryProvider.overrideWithValue(repo)],
    // 기본 재시도(지수 백오프)를 끈다 — 실패 테스트가 AsyncLoading(retrying) 에서 멈추지 않게.
    retry: (retryCount, error) => null,
  );

  test('PICK 영상을 불러온다', () async {
    when(
      repo.fetchWeeklyPicks,
    ).thenAnswer((_) async => const [PickVideo(id: 1, title: '3초 텐션', source: 'YouTube Shorts')]);

    final container = makeContainer();

    expect(await container.read(weeklyPicksProvider.future), hasLength(1));
  });

  test('PICK 영상 조회가 실패하면 AsyncError 가 된다', () async {
    when(
      repo.fetchWeeklyPicks,
    ).thenThrow(const ApiException(statusCode: 500, code: 'SERVER_ERROR', message: '문제가 생겼어요.'));

    final container = makeContainer();
    await container.read(weeklyPicksProvider.future).catchError((_) => <PickVideo>[]);

    expect(container.read(weeklyPicksProvider), isA<AsyncError<List<PickVideo>>>());
  });

  test('카테고리를 안 고르면(전체) 필터 없이 조회한다', () async {
    when(
      () => repo.fetchRooms(category: any(named: 'category')),
    ).thenAnswer((_) async => const [_danceRoom, _uncategorizedRoom]);

    final container = makeContainer();

    expect(await container.read(roomListProvider.future), hasLength(2));
    verify(() => repo.fetchRooms(category: null)).called(1);
  });

  test('카테고리를 고르면 그 값으로 다시 조회한다', () async {
    when(() => repo.fetchRooms(category: any(named: 'category'))).thenAnswer((_) async => const [_danceRoom]);

    final container = makeContainer();
    await container.read(roomListProvider.future);

    container.read(selectedRoomCategoryProvider.notifier).select(RoomCategory.dance);
    await container.read(roomListProvider.future);

    verify(() => repo.fetchRooms(category: RoomCategory.dance)).called(1);
  });
}
