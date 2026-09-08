import 'package:challroom_app/controllers/auth_controller.dart';
import 'package:challroom_app/core/auth/social_auth_service.dart';
import 'package:challroom_app/core/error/api_exception.dart';
import 'package:challroom_app/core/storage/token_storage.dart';
import 'package:challroom_app/models/auths.dart';
import 'package:challroom_app/models/enums.dart';
import 'package:challroom_app/models/users.dart';
import 'package:challroom_app/providers.dart';
import 'package:challroom_app/repositories/auth_repository.dart';
import 'package:challroom_app/repositories/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockUserRepository extends Mock implements UserRepository {}

class MockSocialAuthService extends Mock implements SocialAuthService {}

class MockTokenStorage extends Mock implements TokenStorage {}

const _user = User(id: 1, provider: SocialProvider.kakao, nickname: '송재우');
const _result = AuthResult(
  user: _user,
  tokens: AuthTokens(accessToken: 'app-token'),
);

void main() {
  setUpAll(() {
    registerFallbackValue(const SocialLoginReq(accessToken: ''));
    registerFallbackValue(SocialProvider.kakao);
  });

  late MockAuthRepository repo;
  late MockUserRepository userRepo;
  late MockSocialAuthService social;
  late MockTokenStorage storage;

  setUp(() {
    repo = MockAuthRepository();
    userRepo = MockUserRepository();
    social = MockSocialAuthService();
    storage = MockTokenStorage();

    when(
      () => storage.saveTokens(
        accessToken: any(named: 'accessToken'),
        refreshToken: any(named: 'refreshToken'),
      ),
    ).thenAnswer((_) async {});
    when(storage.clear).thenAnswer((_) async {});
  });

  ProviderContainer makeContainer() => ProviderContainer.test(
    overrides: [
      authRepositoryProvider.overrideWithValue(repo),
      userRepositoryProvider.overrideWithValue(userRepo),
      socialAuthServiceProvider.overrideWithValue(social),
      tokenStorageProvider.overrideWithValue(storage),
    ],
  );

  test('저장된 토큰이 없으면 로그아웃 상태다', () async {
    when(storage.readAccessToken).thenAnswer((_) async => null);

    expect(await makeContainer().read(authProvider.future), isNull);
    verifyNever(userRepo.fetchMe);
  });

  test('저장된 토큰이 있으면 내 정보를 불러온다', () async {
    when(storage.readAccessToken).thenAnswer((_) async => 'saved-token');
    when(userRepo.fetchMe).thenAnswer((_) async => _user);

    expect(await makeContainer().read(authProvider.future), _user);
  });

  test('로그인에 성공하면 유저가 들어오고 앱 토큰을 저장한다', () async {
    when(storage.readAccessToken).thenAnswer((_) async => null);
    when(() => social.obtainAccessToken(any())).thenAnswer((_) async => 'social-token');
    when(() => repo.signIn(any(), any())).thenAnswer((_) async => _result);

    final container = makeContainer();
    await container.read(authProvider.future);

    await container.read(authProvider.notifier).signIn(SocialProvider.kakao);

    expect(container.read(authProvider).value, _user);
    verify(() => repo.signIn(SocialProvider.kakao, const SocialLoginReq(accessToken: 'social-token'))).called(1);
    verify(() => storage.saveTokens(accessToken: 'app-token', refreshToken: null)).called(1);
  });

  test('서버가 로그인을 거절하면 AsyncError 가 된다', () async {
    when(storage.readAccessToken).thenAnswer((_) async => null);
    when(() => social.obtainAccessToken(any())).thenAnswer((_) async => 'social-token');
    when(
      () => repo.signIn(any(), any()),
    ).thenThrow(const ApiException(statusCode: 401, code: 'INVALID_TOKEN', message: '다시 시도해 주세요.'));

    final container = makeContainer();
    await container.read(authProvider.future);

    await container.read(authProvider.notifier).signIn(SocialProvider.kakao);

    expect(container.read(authProvider), isA<AsyncError<User?>>());
    verifyNever(() => storage.saveTokens(accessToken: any(named: 'accessToken')));
  });

  test('소셜 SDK 가 실패하면 서버를 부르지 않는다', () async {
    when(storage.readAccessToken).thenAnswer((_) async => null);
    when(() => social.obtainAccessToken(any())).thenThrow(const SocialAuthException('카카오 로그인은 아직 연결 전이에요.'));

    final container = makeContainer();
    await container.read(authProvider.future);

    await container.read(authProvider.notifier).signIn(SocialProvider.kakao);

    expect(container.read(authProvider), isA<AsyncError<User?>>());
    verifyNever(() => repo.signIn(any(), any()));
  });

  test('로그아웃하면 서버 호출이 실패해도 토큰을 지운다', () async {
    when(storage.readAccessToken).thenAnswer((_) async => 'saved-token');
    when(userRepo.fetchMe).thenAnswer((_) async => _user);
    when(repo.signOut).thenThrow(const NetworkException());

    final container = makeContainer();
    await container.read(authProvider.future);

    await container.read(authProvider.notifier).signOut();

    verify(storage.clear).called(1);
    expect(container.read(authProvider), isA<AsyncError<User?>>());
  });
}
