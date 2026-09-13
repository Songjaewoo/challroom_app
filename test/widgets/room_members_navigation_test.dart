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

// 로컬 목업의 1번 방(우리끼리 텐션 챌린지)은 데모로 미리 방장 방으로 심어져 있고, 시드
// 멤버 중 '하늘'이 있어서 그 유저로 로그인하면 "내가 방장" 케이스를 바로 볼 수 있다.
const _user = User(id: 1, provider: SocialProvider.kakao, nickname: '하늘');

void main() {
  testWidgets('방장인 방에서 "멤버" 를 탭하면 관리 화면으로 가고, 다른 멤버를 내보낼 수 있다', (tester) async {
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

    // 홈 -> 방 상세.
    await tester.tap(find.text('우리끼리 텐션 챌린지'));
    await tester.pumpAndSettle();
    expect(find.text('멤버 4명'), findsOneWidget);

    // 방 상세 -> 멤버 관리.
    await tester.tap(find.text('멤버 4명'));
    await tester.pumpAndSettle();

    expect(find.text('멤버'), findsWidgets); // AppBar 타이틀
    expect(find.text('초대 코드가 아직 없어요'), findsOneWidget); // 방장이라 보인다(뎁스를 줄이려고 이 화면 안에 있다).
    expect(find.text('방장'), findsOneWidget); // 배지 — 로그인한 '하늘' 자리에만 붙는다.
    expect(find.text('내보내기'), findsWidgets); // 나 말고 다른 멤버들.

    // 코드를 만들면 6자리 코드가 바로 뜬다(별도 화면 이동 없이).
    await tester.tap(find.text('코드 만들기'));
    await tester.pumpAndSettle();
    expect(find.text('초대 코드가 아직 없어요'), findsNothing);
    expect(find.text('이 코드로 초대하세요'), findsOneWidget);

    // 민지를 내보낸다.
    await tester.tap(find.text('내보내기').first);
    await tester.pumpAndSettle();
    expect(find.text('멤버 내보내기'), findsOneWidget); // 확인 다이얼로그.

    await tester.tap(find.text('내보내기').last);
    await tester.pumpAndSettle();

    expect(find.text('우리끼리 텐션 챌린지 · 멤버 3명'), findsOneWidget);
  });

  testWidgets('방장이 아닌 방에서는 멤버 목록만 보이고 관리 UI 는 없다', (tester) async {
    final storage = _TokenStorage();
    final userRepo = _UserRepository();
    when(storage.readAccessToken).thenAnswer((_) async => 'saved-token');
    // 2번 방(눈빛 승부 한판 붙자)의 시드 멤버가 아닌 닉네임으로 로그인 — 방장이 아니다.
    when(userRepo.fetchMe).thenAnswer((_) async => const User(id: 2, provider: SocialProvider.kakao, nickname: '현우'));

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

    // 홈의 ListView 는 자식을 미리 다 만들어서 `scrollUntilVisible` 은 이미 찾았다고 오판한다
    // — 실제 뷰포트 기준으로 스크롤하는 `ensureVisible` 을 쓴다.
    await tester.ensureVisible(find.text('눈빛 승부 한판 붙자'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('눈빛 승부 한판 붙자'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('멤버 2명'));
    await tester.pumpAndSettle();

    expect(find.text('초대 코드가 아직 없어요'), findsNothing);
    expect(find.text('내보내기'), findsNothing);
  });

  testWidgets('방장이 신청을 수락하면 멤버로 편입되고, 거절하면 목록에서 사라진다', (tester) async {
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
    await tester.tap(find.text('멤버 4명'));
    await tester.pumpAndSettle();

    // 1번 방(방장 '하늘')엔 데모로 '유진'/'태호' 가 신청 대기 중으로 심어져 있다.
    expect(find.text('신청 대기 중 (2)'), findsOneWidget);
    expect(find.text('유진'), findsOneWidget);
    expect(find.text('태호'), findsOneWidget);

    // 유진을 수락 — 확인 다이얼로그를 거쳐 대기 목록에서 빠지고 멤버로 들어간다.
    await tester.tap(find.text('수락').first);
    await tester.pumpAndSettle();
    expect(find.text('신청 수락'), findsOneWidget);

    await tester.tap(find.text('수락하기'));
    await tester.pumpAndSettle();

    expect(find.text('신청 대기 중 (1)'), findsOneWidget);
    expect(find.text('우리끼리 텐션 챌린지 · 멤버 5명'), findsOneWidget);

    // 태호를 거절 — 확인 다이얼로그를 거쳐 목록에서 사라지고, 멤버로는 안 들어간다.
    await tester.tap(find.text('거절').first);
    await tester.pumpAndSettle();
    expect(find.text('신청 거절'), findsOneWidget);

    await tester.tap(find.text('거절하기'));
    await tester.pumpAndSettle();

    expect(find.text('신청 대기 중 (0)'), findsNothing); // 다 처리되면 섹션 자체가 사라진다.
    expect(find.text('태호'), findsNothing);
    expect(find.text('우리끼리 텐션 챌린지 · 멤버 5명'), findsOneWidget); // 거절은 인원수를 안 바꾼다.
  });
}
