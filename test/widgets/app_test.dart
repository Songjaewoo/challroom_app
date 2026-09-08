import 'package:challroom_app/core/auth/social_auth_service.dart';
import 'package:challroom_app/core/storage/token_storage.dart';
import 'package:challroom_app/main.dart';
import 'package:challroom_app/models/enums.dart';
import 'package:challroom_app/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _NoTokenStorage extends Mock implements TokenStorage {}

void main() {
  late _NoTokenStorage storage;

  setUp(() {
    storage = _NoTokenStorage();
    when(storage.readAccessToken).thenAnswer((_) async => null);
  });

  testWidgets('저장된 토큰이 없으면 로그인 화면으로 간다', (tester) async {
    await tester.pumpWidget(
      ProviderScope(overrides: [tokenStorageProvider.overrideWithValue(storage)], child: const App()),
    );
    await tester.pumpAndSettle();

    expect(find.text('챌룸'), findsOneWidget);
    expect(find.text('카카오로 시작하기'), findsOneWidget);
  });

  testWidgets('소셜 로그인 버튼 4종이 순서대로 보인다', (tester) async {
    await tester.pumpWidget(
      ProviderScope(overrides: [tokenStorageProvider.overrideWithValue(storage)], child: const App()),
    );
    await tester.pumpAndSettle();

    for (final provider in SocialProvider.values) {
      expect(find.text(provider.buttonLabel), findsOneWidget);
    }
  });

  testWidgets('SDK 미연동 상태에서 버튼을 누르면 에러 스낵바가 뜬다', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          tokenStorageProvider.overrideWithValue(storage),
          socialAuthServiceProvider.overrideWithValue(const UnavailableSocialAuthService()),
        ],
        child: const App(),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('카카오로 시작하기'));
    await tester.pumpAndSettle();

    expect(find.text('카카오 로그인은 아직 연결 전이에요.'), findsOneWidget);
  });
}
