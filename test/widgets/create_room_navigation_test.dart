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
  testWidgets('바텀 네비게이션 "만들기"로 방을 만들면 새 방이 내 방 목록에도 보인다', (tester) async {
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

    // 바텀 네비게이션 "만들기" — 탭이 아니라 액션이라 화면이 모달로 뜬다.
    await tester.tap(find.text('만들기'));
    await tester.pumpAndSettle();

    expect(find.descendant(of: find.byType(AppBar), matching: find.text('방 만들기')), findsOneWidget);
    expect(find.text('영상을 선택해 주세요'), findsOneWidget);

    final submitButtonBefore = tester.widget<FilledButton>(find.byType(FilledButton));
    expect(submitButtonBefore.onPressed, isNull);

    await tester.enterText(find.byType(TextField).first, '새로 만든 방');
    await tester.pump();

    final submitButtonAfter = tester.widget<FilledButton>(find.byType(FilledButton));
    expect(submitButtonAfter.onPressed, isNotNull);

    // 'text("방 만들기")' 는 AppBar 타이틀과도 겹치므로 버튼 자체를 타입으로 짚는다.
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    // 방 상세로 이동했는지 확인.
    expect(find.text('챌린지 영상 0개'), findsOneWidget);

    // 내 방 목록에도 반영됐는지 확인.
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    await tester.tap(find.text('내 방'));
    await tester.pumpAndSettle();

    expect(find.text('새로 만든 방'), findsOneWidget);
  });
}
