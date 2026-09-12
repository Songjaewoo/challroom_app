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

/// 6자리 초대 코드 형태(대문자/숫자)의 Text 를 화면에서 찾아 값을 뽑아낸다.
final _codePattern = RegExp(r'^[A-Z0-9]{6}$');

void main() {
  testWidgets('"코드로 참여"에서 발급된 코드를 입력하면 그 방 상세로 이동한다', (tester) async {
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

    // 방장인 1번 방에서 코드를 하나 발급받는다(멤버 화면 안에서 바로).
    await tester.tap(find.text('우리끼리 텐션 챌린지'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('멤버 4명'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('코드 만들기'));
    await tester.pumpAndSettle();

    final code = tester
        .widgetList<Text>(find.byType(Text))
        .map((t) => t.data)
        .whereType<String>()
        .firstWhere(_codePattern.hasMatch);

    // 방 상세까지 뒤로 나온다(멤버 -> 방 상세).
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.pageBack();
    await tester.pumpAndSettle();

    // "내 방" 탭 -> "코드로 참여" -> 코드 입력.
    await tester.tap(find.text('내 방'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('코드로 참여'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), code);
    await tester.pump();
    await tester.tap(find.text('입장하기'));
    await tester.pumpAndSettle();

    // 방 상세로 이동했다 — 같은 방(1번, 우리끼리 텐션 챌린지)이니 그대로 보인다.
    expect(find.text('코드로 방 참여'), findsNothing);
    expect(find.text('챌린지 영상 3개'), findsOneWidget);
  });
}
