import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/auth_controller.dart';
import '../../core/error/error_message.dart';
import '../../core/theme/app_theme.dart';
import '../../models/enums.dart';
import '../../shared/widgets/app_logo_mark.dart';
import 'widgets/social_login_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  /// 어느 버튼을 눌렀는지 — 그 버튼에만 스피너를 돌리기 위한 순수 로컬 UI 상태.
  SocialProvider? _pending;

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);

    ref.listen(authProvider, (previous, next) {
      if (next.isLoading) return;
      setState(() => _pending = null);

      if (next case AsyncError(:final error)) {
        ScaffoldMessenger.of(context)
          ..hideCurrentMaterialBanner()
          ..showSnackBar(SnackBar(content: Text(error.toUserMessage())));
      }
    });

    final busy = auth.isLoading;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 28, 28, 24),
          child: Column(
            children: [
              const Expanded(child: _Brand()),
              for (final provider in SocialProvider.values) ...[
                SocialLoginButton(
                  provider: provider,
                  isLoading: _pending == provider,
                  onPressed: busy ? null : () => _signIn(provider),
                ),
                const SizedBox(height: 10),
              ],
              const SizedBox(height: 2),
              Text(
                '계속 진행 시 이용약관 및 개인정보처리방침에 동의합니다',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 13.5, color: AppColors.inkFaint),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signIn(SocialProvider provider) {
    setState(() => _pending = provider);
    unawaited(ref.read(authProvider.notifier).signIn(provider));
  }
}

/// 로고 · 앱 이름 · 한 줄 소개.
class _Brand extends StatelessWidget {
  const _Brand();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const AppLogoMark(),
        const SizedBox(height: 20),
        Text(
          '챌룸',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w500, color: AppColors.ink),
        ),
        const SizedBox(height: 10),
        Text('우리끼리 찍는 챌린지 방', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.inkMuted)),
      ],
    );
  }
}
