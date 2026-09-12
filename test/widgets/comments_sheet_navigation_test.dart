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
  Future<void> pumpToChallengeDetail(WidgetTester tester) async {
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

    // 홈 -> 방 상세 -> 챌린지 상세.
    await tester.tap(find.text('우리끼리 텐션 챌린지'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('3초 텐션 올리기'));
    await tester.pumpAndSettle();
  }

  testWidgets('원본 영상 "이 영상에 댓글" 행을 탭하면 댓글 시트가 뜨고, 댓글을 쓰면 목록에 바로 보인다', (tester) async {
    await pumpToChallengeDetail(tester);

    expect(find.text('이 영상에 댓글'), findsOneWidget);
    await tester.tap(find.text('이 영상에 댓글'));
    await tester.pumpAndSettle();

    // 시드 데이터 3개가 먼저 보인다.
    expect(find.text('3초 텐션 올리기 · 댓글 3'), findsOneWidget);
    expect(find.text('이거 보고 바로 방 만들었어요 다들 콜?'), findsOneWidget);

    await tester.enterText(find.byType(TextField), '나도 찍어봐야지');
    await tester.tap(find.byIcon(Icons.send_rounded));
    await tester.pumpAndSettle();

    expect(find.text('나도 찍어봐야지'), findsOneWidget);
    expect(find.text('3초 텐션 올리기 · 댓글 4'), findsOneWidget);
    // 방금 쓴 사람 닉네임(로그인한 유저)으로 달려야 한다.
    expect(find.text('하늘'), findsWidgets);
  });

  testWidgets('제출 영상의 댓글 배지를 탭하면 그 영상 댓글 시트가 뜬다 — 썸네일 탭과는 다른 동작', (tester) async {
    await pumpToChallengeDetail(tester);

    // 민지 제출 영상의 댓글 배지(2) 탭 — 재생이 아니라 시트가 떠야 한다.
    final badge = find.text('2').first;
    await tester.ensureVisible(badge);
    await tester.pumpAndSettle();
    await tester.tap(badge);
    await tester.pumpAndSettle();

    expect(find.text('민지님 영상 · 댓글 2'), findsOneWidget);
    expect(find.text('오 폼 미쳤다 ㅋㅋㅋ 나도 내일 찍어야지'), findsOneWidget);
    // 재생 화면으로는 안 갔다.
    expect(find.text('영상을 불러오지 못했어요.'), findsNothing);
  });
}
