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
  testWidgets('방장이 "방 정보 수정"으로 제목을 바꾸면 방 상세에 바로 반영된다', (tester) async {
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

    // 홈 -> 방 상세(1번 방, 데모 방장 방) -> "⋮" -> 방 정보 수정.
    await tester.tap(find.text('우리끼리 텐션 챌린지'));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.more_vert));
    await tester.pumpAndSettle();
    await tester.tap(find.text('방 정보 수정'));
    await tester.pumpAndSettle();

    // 기존 값이 미리 채워져 있다.
    expect(find.text('방 정보 수정'), findsOneWidget); // AppBar 타이틀
    final field = tester.widget<TextField>(find.byType(TextField).first);
    expect(field.controller?.text, '우리끼리 텐션 챌린지');
    expect(find.text('#춤'), findsOneWidget);
    expect(find.text('#텐션업'), findsOneWidget);

    await tester.enterText(find.byType(TextField).first, '텐션 챌린지 시즌2');
    await tester.tap(find.text('저장'));
    await tester.pumpAndSettle();

    // 저장 후 방 상세로 돌아왔고, 새 제목이 보인다.
    expect(find.text('방 정보 수정'), findsNothing);
    expect(find.text('텐션 챌린지 시즌2'), findsOneWidget);
  });
}
