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
  testWidgets('원본 영상 좋아요를 누르면 하트가 채워지고 숫자가 오르내린다', (tester) async {
    await _pumpToChallengeDetail(tester);

    // 시드 데이터: 원본 영상 좋아요 12개, 아직 안 누른 상태.
    expect(find.text('12'), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border_rounded), findsWidgets);

    await tester.tap(find.text('12'));
    await tester.pumpAndSettle();

    expect(find.text('13'), findsOneWidget);
    expect(find.text('12'), findsNothing);

    // 다시 누르면 원래대로.
    await tester.tap(find.text('13'));
    await tester.pumpAndSettle();

    expect(find.text('12'), findsOneWidget);
  });

  testWidgets('제출 영상 좋아요도 그리드 칸에서 바로 토글된다', (tester) async {
    await _pumpToChallengeDetail(tester);

    // 시드 데이터: 서준 영상은 이미 좋아요를 누른 상태(2개) — 채워진 하트 아이콘으로 구분해 짚는다
    // (숫자 "2" 는 다른 영상의 댓글 수와 겹칠 수 있다).
    expect(find.byIcon(Icons.favorite_rounded), findsOneWidget);
    await tester.ensureVisible(find.byIcon(Icons.favorite_rounded));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.favorite_rounded));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.favorite_rounded), findsNothing);
  });
}
