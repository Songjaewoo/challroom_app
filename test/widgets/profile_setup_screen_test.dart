import 'package:challroom_app/core/storage/token_storage.dart';
import 'package:challroom_app/main.dart';
import 'package:challroom_app/models/enums.dart';
import 'package:challroom_app/models/users.dart';
import 'package:challroom_app/providers.dart';
import 'package:challroom_app/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _TokenStorage extends Mock implements TokenStorage {}

class _UserRepository extends Mock implements UserRepository {}

const _newUser = User(id: 1, provider: SocialProvider.kakao);

void main() {
  setUpAll(() {
    registerFallbackValue(const ProfileUpdateReq(nickname: ''));
  });

  late _TokenStorage storage;
  late _UserRepository userRepo;

  setUp(() {
    storage = _TokenStorage();
    userRepo = _UserRepository();
    when(storage.readAccessToken).thenAnswer((_) async => 'saved-token');
    when(userRepo.fetchMe).thenAnswer((_) async => _newUser);
  });

  Widget makeApp() => ProviderScope(
    overrides: [tokenStorageProvider.overrideWithValue(storage), userRepositoryProvider.overrideWithValue(userRepo)],
    child: const App(),
  );

  testWidgets('닉네임 없는 유저는 로그인 후 프로필 설정 화면으로 간다', (tester) async {
    await tester.pumpWidget(makeApp());
    await tester.pumpAndSettle();

    expect(find.text('프로필을 만들어주세요'), findsOneWidget);
  });

  testWidgets('닉네임 형식이 안 맞으면 다음 버튼이 비활성이다', (tester) async {
    await tester.pumpWidget(makeApp());
    await tester.pumpAndSettle();

    final button = tester.widget<FilledButton>(find.byType(FilledButton));
    expect(button.onPressed, isNull);

    await tester.enterText(find.byType(TextField), '하늘');
    await tester.pump();

    final enabled = tester.widget<FilledButton>(find.byType(FilledButton));
    expect(enabled.onPressed, isNotNull);
  });

  testWidgets('다음을 누르면 프로필을 저장하고 홈으로 간다', (tester) async {
    when(() => userRepo.updateProfile(any())).thenAnswer((_) async {
      when(userRepo.fetchMe).thenAnswer((_) async => const User(id: 1, provider: SocialProvider.kakao, nickname: '하늘'));
      return const User(id: 1, provider: SocialProvider.kakao, nickname: '하늘');
    });

    await tester.pumpWidget(makeApp());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), '하늘');
    await tester.pump();
    await tester.tap(find.text('다음'));
    await tester.pumpAndSettle();

    expect(find.text('이번 주 챌룸 PICK'), findsOneWidget);
    verify(() => userRepo.updateProfile(const ProfileUpdateReq(nickname: '하늘'))).called(1);
  });
}
