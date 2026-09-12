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
  testWidgets('번들 영상 카드를 탭하면 네이티브 플레이어 화면으로 이동한다(외부 링크로 새지 않는다)', (tester) async {
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

    expect(find.text('이번 주 챌룸 PICK'), findsOneWidget);

    await tester.tap(find.text('직접 업로드'));
    // 로딩 스피너가 무한 애니메이션이라 pumpAndSettle 은 영영 안 멈춘다 — 유한하게 pump 한다.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    // 네이티브 비디오 플레이어 화면(제목이 AppBar 로 올라갔는지)으로 옮겨왔는지만 본다 —
    // 실제 재생은 플랫폼 채널이 필요해 위젯 테스트 환경에선 검증하지 않는다.
    // (이전 화면도 Navigator 스택에 그대로 남아 있어 카드 제목이 하나 더 잡히므로 AppBar 안만 본다.)
    expect(find.descendant(of: find.byType(AppBar), matching: find.text('직접 업로드')), findsOneWidget);
  });
}
