import 'package:challroom_app/controllers/auth_controller.dart';
import 'package:challroom_app/controllers/profile_setup_controller.dart';
import 'package:challroom_app/core/error/api_exception.dart';
import 'package:challroom_app/core/storage/token_storage.dart';
import 'package:challroom_app/models/enums.dart';
import 'package:challroom_app/models/users.dart';
import 'package:challroom_app/providers.dart';
import 'package:challroom_app/repositories/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockTokenStorage extends Mock implements TokenStorage {}

const _beforeUser = User(id: 1, provider: SocialProvider.kakao);
const _afterUser = User(id: 1, provider: SocialProvider.kakao, nickname: '하늘');

void main() {
  setUpAll(() {
    registerFallbackValue(const ProfileUpdateReq(nickname: ''));
    registerFallbackValue(XFile(''));
  });

  late MockUserRepository repo;
  late MockTokenStorage storage;

  setUp(() {
    repo = MockUserRepository();
    storage = MockTokenStorage();
    when(storage.readAccessToken).thenAnswer((_) async => 'saved-token');
  });

  ProviderContainer makeContainer() => ProviderContainer.test(
    overrides: [userRepositoryProvider.overrideWithValue(repo), tokenStorageProvider.overrideWithValue(storage)],
  );

  test('사진 없이 닉네임만 저장하면 auth 상태가 최신 유저로 갱신된다', () async {
    // submit() 이 끝나면 authProvider 가 refresh() 로 fetchMe() 를 다시 부른다 —
    // 실제 서버처럼 그 시점부터 바뀐 값을 돌려주게 스텁한다.
    var current = _beforeUser;
    when(repo.fetchMe).thenAnswer((_) async => current);
    when(() => repo.updateProfile(any())).thenAnswer((_) async {
      current = _afterUser;
      return current;
    });

    final container = makeContainer();
    await container.read(authProvider.future);

    await container.read(profileSetupProvider.notifier).submit(nickname: '하늘');

    expect(container.read(authProvider).value, _afterUser);
    verify(() => repo.updateProfile(const ProfileUpdateReq(nickname: '하늘'))).called(1);
    verifyNever(() => repo.uploadAvatar(any()));
  });

  test('사진이 있으면 먼저 올리고 받은 URL로 프로필을 저장한다', () async {
    var current = _beforeUser;
    when(repo.fetchMe).thenAnswer((_) async => current);
    when(() => repo.uploadAvatar(any())).thenAnswer((_) async => 'https://cdn.example.com/a.jpg');
    when(() => repo.updateProfile(any())).thenAnswer((_) async {
      current = _afterUser;
      return current;
    });

    final container = makeContainer();
    await container.read(authProvider.future);

    final avatar = XFile('local/path.jpg');
    await container.read(profileSetupProvider.notifier).submit(nickname: '하늘', avatar: avatar);

    verify(
      () =>
          repo.updateProfile(const ProfileUpdateReq(nickname: '하늘', profileImageUrl: 'https://cdn.example.com/a.jpg')),
    ).called(1);
  });

  test('서버가 거절하면 AsyncError 가 되고 auth 상태는 그대로다', () async {
    when(repo.fetchMe).thenAnswer((_) async => _beforeUser);
    when(
      () => repo.updateProfile(any()),
    ).thenThrow(const ApiException(statusCode: 409, code: 'DUPLICATED_NICKNAME', message: '이미 쓰는 닉네임이에요.'));

    final container = makeContainer();
    await container.read(authProvider.future);

    await container.read(profileSetupProvider.notifier).submit(nickname: '하늘');

    expect(container.read(profileSetupProvider), isA<AsyncError<void>>());
    expect(container.read(authProvider).value, _beforeUser);
  });
}
