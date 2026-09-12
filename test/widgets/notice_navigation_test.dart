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
  testWidgets('설정 > 공지사항 — 목록이 고정 공지 먼저 보이고, 탭하면 본문까지 보인다', (tester) async {
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
    await tester.scrollUntilVisible(find.text('공지사항'), 200, scrollable: find.byType(Scrollable));
    await tester.tap(find.text('공지사항'));
    await tester.pumpAndSettle();

    expect(find.text('공지'), findsOneWidget); // 고정 공지 배지 — 하나뿐이다.
    expect(find.text('챌룸 앱 정식 출시 안내'), findsOneWidget);

    await tester.tap(find.text('챌룸 앱 정식 출시 안내'));
    await tester.pumpAndSettle();

    expect(find.textContaining('오늘부터 챌룸이 정식으로 문을 엽니다'), findsOneWidget);
  });
}
