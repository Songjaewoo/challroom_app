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
    expect(find.byKey(const Key('createRoomVideoUrlField')), findsOneWidget);

    // "상세 설명" 이 여러 줄이라 폼이 길어져 "방 만들기" 버튼이 처음엔 화면 밖(빌드 캐시 범위 밖)에
    // 있다 — 실제로 스크롤해야 트리에 올라온다. `scrollUntilVisible` 은 기본으로 아무
    // `Scrollable` 이나 짚는데, 이 화면엔 각 `TextField` 내부 스크롤까지 여러 개 있어 애매하니
    // ListView 자체를 드래그한다.
    await tester.drag(find.byType(ListView), const Offset(0, -400));
    await tester.pumpAndSettle();

    final submitButtonBefore = tester.widget<FilledButton>(find.byType(FilledButton));
    expect(submitButtonBefore.onPressed, isNull);

    await tester.enterText(find.byKey(const Key('createRoomTitleField')), '새로 만든 방');
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

  testWidgets('방 만들기에서 URL을 입력하면 그 링크로 챌린지 영상이 있는 방이 만들어진다', (tester) async {
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

    await tester.tap(find.text('만들기'));
    await tester.pumpAndSettle();

    // 시트나 다이얼로그 없이, 카드 안 입력창에 바로 링크를 붙여넣는다.
    await tester.enterText(find.byKey(const Key('createRoomVideoUrlField')), 'https://youtu.be/abc123');
    await tester.pump();

    // 입력하면 확정(체크) 버튼이 나타난다 — 눌러서 확정한다.
    await tester.tap(find.byIcon(Icons.check_circle));
    await tester.pumpAndSettle();

    // 카드가 링크 정보로 바뀌고, 입력창은 미리보기 + "다시 고르기" 로 바뀐다.
    expect(find.text('https://youtu.be/abc123'), findsOneWidget);
    expect(find.text('YouTube'), findsOneWidget);
    expect(find.text('다시 고르기'), findsOneWidget);
    expect(find.byKey(const Key('createRoomVideoUrlField')), findsNothing);

    await tester.enterText(find.byKey(const Key('createRoomTitleField')), '링크로 만든 방');
    await tester.pump();

    // "상세 설명" 이 여러 줄이라 폼이 길어져 "방 만들기" 버튼이 화면 밖에 있다 — 스크롤해서 짚는다.
    await tester.drag(find.byType(ListView), const Offset(0, -400));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    // 영상이 있는 채로 만들어졌는지 확인.
    expect(find.text('챌린지 영상 1개'), findsOneWidget);
  });
}
