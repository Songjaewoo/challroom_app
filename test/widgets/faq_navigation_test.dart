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

const _user = User(id: 1, provider: SocialProvider.kakao, nickname: '하늘');

void main() {
  testWidgets('설정 > 자주 묻는 질문 — 카테고리로 묶여 보이고, 탭하면 답변까지 보인다', (tester) async {
    final storage = _TokenStorage();
    final userRepo = _UserRepository();
    when(storage.readAccessToken).thenAnswer((_) async => 'saved-token');
    when(userRepo.fetchMe).thenAnswer((_) async => _user);

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
    await tester.scrollUntilVisible(find.text('자주 묻는 질문'), 200, scrollable: find.byType(Scrollable));
    await tester.tap(find.text('자주 묻는 질문'));
    await tester.pumpAndSettle();

    expect(find.text('계정'), findsOneWidget); // 카테고리 라벨.
    expect(find.text('닉네임은 나중에 바꿀 수 있나요?'), findsOneWidget);

    await tester.tap(find.text('닉네임은 나중에 바꿀 수 있나요?'));
    await tester.pumpAndSettle();

    expect(find.textContaining('설정 > 프로필 편집에서'), findsOneWidget);
  });
}
