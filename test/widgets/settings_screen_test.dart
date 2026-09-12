import 'package:challroom_app/core/storage/token_storage.dart';
import 'package:challroom_app/main.dart';
import 'package:challroom_app/models/enums.dart';
import 'package:challroom_app/models/users.dart';
import 'package:challroom_app/providers.dart';
import 'package:challroom_app/repositories/auth_repository.dart';
import 'package:challroom_app/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _TokenStorage extends Mock implements TokenStorage {}

class _UserRepository extends Mock implements UserRepository {}

class _AuthRepository extends Mock implements AuthRepository {}

const _user = User(id: 1, provider: SocialProvider.kakao, nickname: '하늘');

void main() {
  testWidgets('설정 탭 — 닉네임·로그인 계정이 보이고, 로그아웃을 누르면 로그인 화면으로 돌아간다', (tester) async {
    final storage = _TokenStorage();
    final userRepo = _UserRepository();
    final authRepo = _AuthRepository();
    when(storage.readAccessToken).thenAnswer((_) async => 'saved-token');
    when(storage.clear).thenAnswer((_) async {});
    when(userRepo.fetchMe).thenAnswer((_) async => _user);
    when(authRepo.signOut).thenAnswer((_) async {});

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          tokenStorageProvider.overrideWithValue(storage),
          userRepositoryProvider.overrideWithValue(userRepo),
          authRepositoryProvider.overrideWithValue(authRepo),
        ],
        child: const App(),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('설정'));
    await tester.pumpAndSettle();

    expect(find.text('하늘'), findsOneWidget);
    expect(find.text('카카오'), findsOneWidget);

    // 로그아웃 버튼은 화면 아래쪽이라 스크롤해야 빌드된다.
    await tester.scrollUntilVisible(find.text('로그아웃'), 200, scrollable: find.byType(Scrollable));
    await tester.tap(find.text('로그아웃'));
    await tester.pumpAndSettle();

    verify(authRepo.signOut).called(1);
    verify(storage.clear).called(1);
    // 로그아웃 성공 → authProvider 가 null → 라우터가 로그인 화면으로 되돌린다.
    expect(find.text('카카오로 시작하기'), findsOneWidget);
  });
}
