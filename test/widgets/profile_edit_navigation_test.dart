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

const _beforeUser = User(id: 1, provider: SocialProvider.kakao, nickname: '하늘');
const _afterUser = User(id: 1, provider: SocialProvider.kakao, nickname: '구름');

void main() {
  setUpAll(() {
    registerFallbackValue(const ProfileUpdateReq(nickname: ''));
  });

  testWidgets('설정 > 프로필 카드에서 편집 화면으로 가면 닉네임이 미리 채워져 있고, 저장하면 설정으로 돌아와 반영된다', (tester) async {
    final storage = _TokenStorage();
    final userRepo = _UserRepository();
    when(storage.readAccessToken).thenAnswer((_) async => 'saved-token');

    var current = _beforeUser;
    when(userRepo.fetchMe).thenAnswer((_) async => current);
    when(() => userRepo.updateProfile(any())).thenAnswer((_) async {
      current = _afterUser;
      return current;
    });

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          tokenStorageProvider.overrideWithValue(storage),
          userRepositoryProvider.overrideWithValue(userRepo),
        ],
        child: const App(),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('설정'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('하늘'));
    await tester.pumpAndSettle();

    expect(find.text('프로필 편집'), findsOneWidget);
    final field = tester.widget<TextField>(find.byType(TextField));
    expect(field.controller?.text, '하늘');

    await tester.enterText(find.byType(TextField), '구름');
    await tester.tap(find.text('저장'));
    await tester.pumpAndSettle();

    verify(() => userRepo.updateProfile(const ProfileUpdateReq(nickname: '구름'))).called(1);
    // 저장 후 설정 화면으로 돌아왔고, 갱신된 닉네임이 보인다.
    expect(find.text('프로필 편집'), findsNothing);
    expect(find.text('구름'), findsOneWidget);
  });
}
