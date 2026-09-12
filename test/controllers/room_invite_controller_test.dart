import 'package:challroom_app/controllers/room_detail_controller.dart';
import 'package:challroom_app/controllers/room_invite_controller.dart';
import 'package:challroom_app/core/error/api_exception.dart';
import 'package:challroom_app/models/rooms.dart';
import 'package:challroom_app/providers.dart';
import 'package:challroom_app/repositories/room_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRoomRepository extends Mock implements RoomRepository {}

const _before = RoomDetail(id: 1, title: '우리끼리 텐션 챌린지', memberCount: 1, isOwnedByMe: true);
const _after = RoomDetail(id: 1, title: '우리끼리 텐션 챌린지', memberCount: 1, isOwnedByMe: true, inviteCode: 'ABCD12');

void main() {
  late MockRoomRepository repo;

  setUp(() {
    repo = MockRoomRepository();
  });

  ProviderContainer makeContainer() => ProviderContainer.test(
    overrides: [roomRepositoryProvider.overrideWithValue(repo)],
    retry: (retryCount, error) => null,
  );

  test('코드를 생성하면 방 상세를 다시 불러와 반영한다', () async {
    when(() => repo.fetchRoomDetail(1)).thenAnswer((_) async => _before);
    when(() => repo.createInviteCode(1)).thenAnswer((_) async => _after);

    final container = makeContainer();
    await container.read(roomDetailProvider(1).future);

    when(() => repo.fetchRoomDetail(1)).thenAnswer((_) async => _after);
    await container.read(roomInviteProvider(1).notifier).generate();
    await container.read(roomDetailProvider(1).future);

    expect(container.read(roomDetailProvider(1)).value?.inviteCode, 'ABCD12');
  });

  test('방장이 아니면(서버가 거절) AsyncError 가 된다', () async {
    when(() => repo.fetchRoomDetail(1)).thenAnswer((_) async => _before);
    when(
      () => repo.createInviteCode(any()),
    ).thenThrow(const ApiException(statusCode: 403, code: 'NOT_ROOM_OWNER', message: '방장만 초대 코드를 만들 수 있어요.'));

    final container = makeContainer();
    await container.read(roomDetailProvider(1).future);

    await container.read(roomInviteProvider(1).notifier).generate();

    expect(container.read(roomInviteProvider(1)), isA<AsyncError<void>>());
  });
}
