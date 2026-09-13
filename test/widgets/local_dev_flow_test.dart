import 'package:challroom_app/core/dev/local_backend.dart';
import 'package:challroom_app/core/storage/token_storage.dart';
import 'package:challroom_app/main.dart';
import 'package:challroom_app/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _TokenStorage extends Mock implements TokenStorage {}

/// `API_BASE_URL` 없이(지금 기본값) 로그인 → 프로필 설정 → 홈까지 실제 라우팅으로
/// 이어지는지 본다. `authRepositoryProvider` / `userRepositoryProvider` 는 오버라이드하지
/// 않는다 — providers.dart 가 `apiBaseUrl.isEmpty` 일 때 고르는 로컬 목업 경로가 바로 이
/// 테스트의 대상이다. `socialAuthServiceProvider` 만은 예외로 [LocalSocialAuthService] 로
/// 고정한다 — 카카오·네이버는 [HybridSocialAuthService] 가 `apiBaseUrl` 과 무관하게 항상
/// 실제 네이티브 SDK 로 보내는데, 위젯 테스트엔 그 플랫폼 채널이 없어 탭하자마자 멈춘다.
/// 실기기에서 secure storage 는 되지만 위젯 테스트 환경엔 없어서 저장소만 목으로 바꾼다.
void main() {
  testWidgets('로그인 버튼을 누르면 프로필 설정 화면으로, 완료하면 홈으로 간다', (tester) async {
    // 실기기 secure storage 를 흉내낸다 — saveTokens 가 저장한 값을 readAccessToken 이
    // 그대로 돌려줘야, 프로필 저장 뒤 authProvider.refresh() 가 다시 build() 를 돌릴 때도
    // 로그인 상태가 유지된다. 단순 스텁(항상 null)이면 여기서 로그아웃으로 오판한다.
    String? savedToken;
    final storage = _TokenStorage();
    when(storage.readAccessToken).thenAnswer((_) async => savedToken);
    when(
      () => storage.saveTokens(
        accessToken: any(named: 'accessToken'),
        refreshToken: any(named: 'refreshToken'),
      ),
    ).thenAnswer((invocation) async {
      savedToken = invocation.namedArguments[#accessToken] as String;
    });

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          tokenStorageProvider.overrideWithValue(storage),
          socialAuthServiceProvider.overrideWithValue(const LocalSocialAuthService()),
        ],
        child: const App(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('카카오로 시작하기'), findsOneWidget);

    await tester.tap(find.text('카카오로 시작하기'));
    await tester.pumpAndSettle();

    expect(find.text('프로필을 만들어주세요'), findsOneWidget);

    await tester.enterText(find.byType(TextField), '하늘');
    await tester.pump();
    await tester.tap(find.text('다음'));
    await tester.pumpAndSettle();

    expect(find.text('이번 주 챌룸 PICK'), findsOneWidget);
  });
}
