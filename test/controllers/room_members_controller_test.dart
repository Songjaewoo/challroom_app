import 'package:challroom_app/controllers/room_detail_controller.dart';
import 'package:challroom_app/controllers/room_members_controller.dart';
import 'package:challroom_app/core/error/api_exception.dart';
import 'package:challroom_app/models/rooms.dart';
import 'package:challroom_app/providers.dart';
import 'package:challroom_app/repositories/room_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRoomRepository extends Mock implements RoomRepository {}

const _before = RoomDetail(
  id: 1,
  title: '우리끼리 텐션 챌린지',
  members: [ParticipantInfo(nickname: '하늘', isOwner: true), ParticipantInfo(nickname: '민지')],
  memberCount: 2,
  isOwnedByMe: true,
);

const _after = RoomDetail(
  id: 1,
  title: '우리끼리 텐션 챌린지',
  members: [ParticipantInfo(nickname: '하늘', isOwner: true)],
  memberCount: 1,
  isOwnedByMe: true,
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

  test('멤버를 내보내면 방 상세를 다시 불러와 반영한다', () async {
    when(() => repo.fetchRoomDetail(1)).thenAnswer((_) async => _before);
    when(() => repo.removeMember(1, '민지')).thenAnswer((_) async => _after);

    final container = makeContainer();
    await container.read(roomDetailProvider(1).future);

    when(() => repo.fetchRoomDetail(1)).thenAnswer((_) async => _after);
    await container.read(roomMembersProvider(1).notifier).removeMember('민지');
    // invalidate() 는 재조회를 시작만 시킨다 — 끝난 값을 보려면 future 를 한 번 더 기다려야 한다.
    await container.read(roomDetailProvider(1).future);

    expect(container.read(roomDetailProvider(1)).value, _after);
    verify(() => repo.removeMember(1, '민지')).called(1);
  });

  test('방장이 아니면(서버가 거절) AsyncError 가 된다', () async {
    when(() => repo.fetchRoomDetail(1)).thenAnswer((_) async => _before);
    when(
      () => repo.removeMember(any(), any()),
    ).thenThrow(const ApiException(statusCode: 403, code: 'NOT_ROOM_OWNER', message: '방장만 멤버를 내보낼 수 있어요.'));

    final container = makeContainer();
    await container.read(roomDetailProvider(1).future);

    await container.read(roomMembersProvider(1).notifier).removeMember('민지');

    expect(container.read(roomMembersProvider(1)), isA<AsyncError<void>>());
  });
}
