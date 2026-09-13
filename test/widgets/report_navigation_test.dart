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

Future<void> _pumpToChallengeDetail(WidgetTester tester) async {
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

  await tester.tap(find.text('우리끼리 텐션 챌린지'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('3초 텐션 올리기'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('챌린지 상세 "⋮" 로 원본 영상을 신고하면 사유를 고르고 접수까지 끝낸다', (tester) async {
    await _pumpToChallengeDetail(tester);

    await tester.tap(find.descendant(of: find.byType(AppBar), matching: find.byIcon(Icons.more_vert)));
    await tester.pumpAndSettle();
    await tester.tap(find.text('원본 영상 신고'));
    await tester.pumpAndSettle();

    expect(find.descendant(of: find.byType(AppBar), matching: find.text('신고하기')), findsOneWidget);
    expect(find.textContaining('3초 텐션 올리기'), findsOneWidget);

    // 사유를 고르기 전엔 제출 버튼이 비활성이다.
    final buttonBefore = tester.widget<FilledButton>(find.byType(FilledButton));
    expect(buttonBefore.onPressed, isNull);

    await tester.tap(find.text('저작권 침해'));
    await tester.pump();

    final buttonAfter = tester.widget<FilledButton>(find.byType(FilledButton));
    expect(buttonAfter.onPressed, isNotNull);

    // 기본 테스트 화면(800x600)이 작아 제출 버튼이 화면 아래쪽에 있다 — 짚어서 스크롤한다.
    await tester.ensureVisible(find.text('신고 접수하기'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('신고 접수하기'));
    await tester.pumpAndSettle();

    expect(find.text('신고가 접수됐어요'), findsOneWidget);

    await tester.tap(find.text('닫기'));
    await tester.pumpAndSettle();

    // 챌린지 상세로 돌아왔는지 확인.
    expect(find.text('제출된 영상'), findsOneWidget);
  });

  testWidgets('제출 영상 그리드 "⋮" 로 그 영상만 신고할 수 있다', (tester) async {
    await _pumpToChallengeDetail(tester);

    // 그리드 칸의 "⋮" 는 AppBar 것과 같은 아이콘이라, 그리드 안에 있는 것만 짚는다.
    await tester.tap(find.descendant(of: find.byType(GridView), matching: find.byIcon(Icons.more_vert)).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('신고하기'));
    await tester.pumpAndSettle();

    expect(find.textContaining('님 영상'), findsOneWidget);

    await tester.tap(find.text('기타'));
    await tester.pump();
    // 기본 테스트 화면(800x600)이 작아 제출 버튼이 화면 아래쪽에 있다 — 짚어서 스크롤한다.
    await tester.ensureVisible(find.text('신고 접수하기'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('신고 접수하기'));
    await tester.pumpAndSettle();

    expect(find.text('신고가 접수됐어요'), findsOneWidget);
  });
}
