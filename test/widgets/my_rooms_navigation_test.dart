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
  testWidgets('바텀 네비게이션 "내 방" 탭을 누르면 참여 중인 방 목록이 뜨고, 탭하면 방 상세로 간다', (tester) async {
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

    await tester.tap(find.text('내 방'));
    await tester.pumpAndSettle();

    expect(find.text('우리끼리 텐션 챌린지'), findsOneWidget);
    expect(find.text('눈빛 승부 한판 붙자'), findsOneWidget);
    // 데모에서 "내 방"은 앞 두 개만 — 세 번째 방은 안 보여야 한다.
    expect(find.text('오늘 기분 한마디'), findsNothing);
    // 이미 속한 방이라 "신청" 배지는 없어야 한다.
    expect(find.text('신청'), findsNothing);

    await tester.tap(find.text('눈빛 승부 한판 붙자'));
    await tester.pumpAndSettle();

    expect(find.descendant(of: find.byType(AppBar), matching: find.byIcon(Icons.more_vert)), findsOneWidget);
  });
}
