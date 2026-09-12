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

void main() {
  Future<void> pumpAsUser(WidgetTester tester, User user, String roomTitle) async {
    final storage = _TokenStorage();
    final userRepo = _UserRepository();
    when(storage.readAccessToken).thenAnswer((_) async => 'saved-token');
    when(userRepo.fetchMe).thenAnswer((_) async => user);

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

    await tester.tap(find.text(roomTitle));
    await tester.pumpAndSettle();
  }

  testWidgets('방장이면 "⋮" 에 방 정보 수정 / 방 삭제가 보인다', (tester) async {
    // 1번 방("우리끼리 텐션 챌린지")은 데모로 방장 방으로 심어져 있다.
    await pumpAsUser(tester, const User(id: 1, provider: SocialProvider.kakao, nickname: '하늘'), '우리끼리 텐션 챌린지');

    await tester.tap(find.byIcon(Icons.more_vert));
    await tester.pumpAndSettle();

    expect(find.text('방 정보 수정'), findsOneWidget);
    expect(find.text('방 삭제'), findsOneWidget);
    expect(find.text('신고하기'), findsNothing);
    expect(find.text('방 나가기'), findsNothing);

    await tester.tap(find.text('방 삭제'));
    await tester.pumpAndSettle();

    expect(find.text('방 삭제은 곧 만나요!'), findsOneWidget);
  });

  testWidgets('방장이 아니면 "⋮" 에 신고하기 / 방 나가기가 보인다', (tester) async {
    // 2번 방("눈빛 승부 한판 붙자")은 방장 방이 아니다.
    await pumpAsUser(tester, const User(id: 2, provider: SocialProvider.kakao, nickname: '지수'), '눈빛 승부 한판 붙자');

    await tester.tap(find.byIcon(Icons.more_vert));
    await tester.pumpAndSettle();

    expect(find.text('신고하기'), findsOneWidget);
    expect(find.text('방 나가기'), findsOneWidget);
    expect(find.text('방 정보 수정'), findsNothing);
    expect(find.text('방 삭제'), findsNothing);
  });
}
