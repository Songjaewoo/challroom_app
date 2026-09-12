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
  testWidgets('방 카드를 탭하면 방 상세 화면으로 이동해 챌린지 목록을 보여준다', (tester) async {
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

    expect(find.text('우리끼리 텐션 챌린지'), findsOneWidget);

    await tester.tap(find.text('우리끼리 텐션 챌린지'));
    await tester.pumpAndSettle();

    expect(find.text('챌린지 영상 3개'), findsOneWidget);
    expect(find.text('멤버 4명'), findsOneWidget);
    expect(find.text('3초 텐션 올리기'), findsOneWidget);
    expect(find.text('2/4명 제출 완료'), findsOneWidget);
  });
}
