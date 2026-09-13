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

// 1번 방(우리끼리 텐션 챌린지)의 방장 자리로 심어둔 닉네임 — 신청 수락 테스트에 필요하다.
const _user = User(id: 1, provider: SocialProvider.kakao, nickname: '하늘');

Future<void> _pumpApp(WidgetTester tester) async {
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
}

void main() {
  testWidgets('종 아이콘에 안 읽은 배지가 뜨고, 알림함엔 케이스별 문구가 다 보이고, 열면 읽음 처리된다', (tester) async {
    await _pumpApp(tester);

    // 시드 알림 6개 중 2개(신청 도착, 댓글)가 안 읽음 — 벨에 배지가 떠 있어야 한다.
    final badgeBefore = tester.widget<Badge>(find.byType(Badge));
    expect(badgeBefore.isLabelVisible, isTrue);

    await tester.tap(find.byIcon(Icons.notifications_outlined));
    await tester.pumpAndSettle();

    expect(find.descendant(of: find.byType(AppBar), matching: find.text('알림')), findsOneWidget);

    // 케이스 6개 문구가 전부 보인다.
    expect(find.textContaining('유진님이 \'우리끼리 텐션 챌린지\' 방에 참가 신청을 보냈어요'), findsOneWidget);
    expect(find.textContaining('민지님이 내 영상에 댓글을 남겼어요'), findsOneWidget);
    expect(find.textContaining('지수님이 \'눈빛 승부 한판 붙자\' 방에 들어왔어요'), findsOneWidget);
    expect(find.textContaining('\'오늘 기분 한마디\' 방장이 참가 신청을 수락했어요'), findsOneWidget);
    expect(find.textContaining('\'눈빛 승부 한판 붙자\' 방장이 참가 신청을 거절했어요'), findsOneWidget);
    expect(find.textContaining('새 챌린지가 추가됐어요'), findsOneWidget);

    // 뒤로 가면 배지가 사라져 있어야 한다(전부 읽음 처리).
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    final badgeAfter = tester.widget<Badge>(find.byType(Badge));
    expect(badgeAfter.isLabelVisible, isFalse);
  });

  testWidgets('방장이 신청을 수락하면 알림함에도 "들어왔어요" 알림이 실시간으로 쌓인다', (tester) async {
    await _pumpApp(tester);

    await tester.tap(find.text('우리끼리 텐션 챌린지'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('멤버 4명'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('수락').first); // 유진
    await tester.pumpAndSettle();
    await tester.tap(find.text('수락하기'));
    await tester.pumpAndSettle();

    // 방 상세 -> 홈으로 돌아가 알림함을 연다.
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.notifications_outlined));
    await tester.pumpAndSettle();

    expect(find.textContaining('유진님이 \'우리끼리 텐션 챌린지\' 방에 들어왔어요'), findsOneWidget);
  });
}
