import 'package:challroom_app/core/storage/token_storage.dart';
import 'package:challroom_app/main.dart';
import 'package:challroom_app/models/enums.dart';
import 'package:challroom_app/models/users.dart';
import 'package:challroom_app/providers.dart';
import 'package:challroom_app/repositories/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _TokenStorage extends Mock implements TokenStorage {}

class _UserRepository extends Mock implements UserRepository {}

const _user = User(id: 1, provider: SocialProvider.kakao, nickname: '하늘');

void main() {
  testWidgets('방 상세에서 챌린지 카드를 탭하면 재생 대신 제출 영상 모아보는 화면으로 간다', (tester) async {
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

    // 홈 -> 방 상세
    await tester.tap(find.text('우리끼리 텐션 챌린지'));
    await tester.pumpAndSettle();
    expect(find.text('3초 텐션 올리기'), findsOneWidget);

    // 방 상세 -> 챌린지 상세
    await tester.tap(find.text('3초 텐션 올리기'));
    await tester.pumpAndSettle();

    expect(find.text('제출된 영상'), findsOneWidget);
    expect(find.text('2/4명 제출 완료'), findsOneWidget);
    expect(find.text('민지'), findsOneWidget);
    expect(find.text('따라 찍기'), findsOneWidget);
    // 재생 화면(AppBar 만 있고 body 는 비디오)으로 가면 안 된다 — 제출 영상 그리드가 보여야 한다.
    expect(find.text('영상을 불러오지 못했어요.'), findsNothing);
  });
}
