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
  Future<void> pumpHome(WidgetTester tester) async {
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

  testWidgets('홈에서 "신청" 을 누르면 방 상세로 이동하지 않고 커스텀 확인 창이 뜬다', (tester) async {
    await pumpHome(tester);

    // 기본 테스트 화면(800x600)이 작아 이 배지가 아직 스크롤 전 화면 아래쪽에 있다 — 짚어서 스크롤한다.
    await tester.ensureVisible(find.text('신청').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('신청').first);
    await tester.pumpAndSettle();

    // 방 상세로 튕기지 않고, 이 화면 안에서 확인 창이 뜬다.
    expect(find.text('참가 신청'), findsOneWidget);
    expect(find.textContaining('방에 참가 신청을 보낼까요?'), findsOneWidget);
    // 기본 AlertDialog 위젯이 아니라 직접 그린 카드 — Dialog 는 쓰되 AlertDialog 는 아니다.
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.byType(Dialog), findsOneWidget);
  });

  testWidgets('확인 창에서 "취소" 를 누르면 그냥 닫힌다', (tester) async {
    await pumpHome(tester);

    // 기본 테스트 화면(800x600)이 작아 이 배지가 아직 스크롤 전 화면 아래쪽에 있다 — 짚어서 스크롤한다.
    await tester.ensureVisible(find.text('신청').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('신청').first);
    await tester.pumpAndSettle();

    await tester.tap(find.text('취소'));
    await tester.pumpAndSettle();

    expect(find.text('참가 신청'), findsNothing);
    // 다른 화면으로 넘어가지도 않았어야 한다 — 홈 그대로.
    expect(find.text('만들기'), findsOneWidget);
  });

  testWidgets('확인 창에서 "신청하기" 를 누르면 스낵바로 안내한다', (tester) async {
    await pumpHome(tester);

    // 기본 테스트 화면(800x600)이 작아 이 배지가 아직 스크롤 전 화면 아래쪽에 있다 — 짚어서 스크롤한다.
    await tester.ensureVisible(find.text('신청').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('신청').first);
    await tester.pumpAndSettle();

    await tester.tap(find.text('신청하기'));
    await tester.pumpAndSettle();

    expect(find.text('참가 신청을 보냈어요. 방장이 수락하면 알려드릴게요.'), findsOneWidget);
  });

  testWidgets('신청한 방은 "내 방" 목록에도 "신청취소" 배지와 함께 보이고, 취소하면 다시 사라진다', (tester) async {
    await pumpHome(tester);

    // "신청" 배지는 모집 중이면서 아직 멤버가 아닌 "오늘 기분 한마디" 하나뿐이다 — 이미
    // 멤버인 "눈빛 승부 한판 붙자"(모집 중이긴 하지만)는 신청해봐야 소용없어 배지가 안 뜬다.
    await tester.ensureVisible(find.text('신청'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('신청'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('신청하기'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('내 방'));
    await tester.pumpAndSettle();

    expect(find.text('오늘 기분 한마디'), findsOneWidget);
    expect(find.text('신청취소'), findsOneWidget);

    await tester.tap(find.text('신청취소'));
    await tester.pumpAndSettle();

    expect(find.text('신청 취소'), findsOneWidget);
    await tester.tap(find.text('신청 취소하기'));
    await tester.pumpAndSettle();

    expect(find.text('참가 신청을 취소했어요.'), findsOneWidget);

    // 스낵바가 사라질 시간을 주고, 내 방 목록에서 빠졌는지 확인한다.
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.text('오늘 기분 한마디'), findsNothing);
  });
}
