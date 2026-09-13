import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../controllers/auth_controller.dart';
import '../../core/error/error_message.dart';
import '../../core/router/app_router.dart';
import '../../core/theme/app_theme.dart';
import '../../shared/coming_soon.dart';
import 'widgets/settings_profile_card.dart';
import 'widgets/settings_row.dart';

/// 바텀 네비게이션 "설정" 탭. 로그인 정보·로그아웃·공지사항·자주 묻는 질문은 실제로 동작하고,
/// 아직 없는 화면(약관 등)은 [showComingSoon] 으로 안내한다.
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  // 알림 on/off 는 아직 서버에 저장할 곳이 없다 — 화면을 나가면 초기화되는 순수 로컬 상태.
  var _notificationsEnabled = true;
  String? _version;

  @override
  void initState() {
    super.initState();
    unawaited(_loadVersion());
  }

  Future<void> _loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    if (!mounted) return;
    setState(() => _version = info.version);
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    final user = auth.value;

    ref.listen(authProvider, (previous, next) {
      if (next case AsyncError(:final error)) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(error.toUserMessage())));
      }
    });

    final busy = auth.isLoading;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(18, 12, 18, 4),
            child: Text(
              '설정',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.ink),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 28),
              children: [
                SettingsProfileCard(
                  // 라우터가 닉네임 없는 유저는 애초에 이 화면에 못 오게 막는다 —
                  // 그래도 첫 아바타 글자를 뽑아야 하니 빈 문자열은 방어적으로 걸러낸다.
                  nickname: user?.nickname?.isNotEmpty == true ? user!.nickname! : '유저',
                  onTap: () => context.push(RoutePath.profileEdit),
                ),
                const SizedBox(height: 24),
                const SettingsSectionLabel('계정'),
                SettingsGroup(
                  children: [
                    SettingsRow(
                      icon: Icons.account_circle_outlined,
                      label: '로그인 계정',
                      trailingText: user?.provider.label,
                      onTap: () => showComingSoon(context, '로그인 계정 관리'),
                    ),
                    SettingsRow(
                      icon: Icons.notifications_outlined,
                      label: '알림',
                      trailing: Switch(
                        value: _notificationsEnabled,
                        onChanged: (value) => setState(() => _notificationsEnabled = value),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const SettingsSectionLabel('이용 안내'),
                SettingsGroup(
                  children: [
                    SettingsRow(
                      icon: Icons.campaign_outlined,
                      label: '공지사항',
                      onTap: () => context.push(RoutePath.noticeList),
                    ),
                    SettingsRow(
                      icon: Icons.help_outline,
                      label: '자주 묻는 질문',
                      onTap: () => context.push(RoutePath.faqList),
                    ),
                    SettingsRow(
                      icon: Icons.description_outlined,
                      label: '이용약관',
                      onTap: () => showComingSoon(context, '이용약관'),
                    ),
                    SettingsRow(
                      icon: Icons.privacy_tip_outlined,
                      label: '개인정보처리방침',
                      onTap: () => showComingSoon(context, '개인정보처리방침'),
                    ),
                    SettingsRow(
                      icon: Icons.code_rounded,
                      label: '오픈소스 라이선스',
                      onTap: () => unawaited(_showLicenses(context)),
                    ),
                    SettingsRow(icon: Icons.info_outline, label: '버전', trailingText: _version ?? ''),
                  ],
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: busy ? null : () => unawaited(ref.read(authProvider.notifier).signOut()),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(46),
                      side: const BorderSide(color: AppColors.border),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: busy
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.inkMuted),
                          )
                        : const Text(
                            '로그아웃',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.ink),
                          ),
                  ),
                ),
                const SizedBox(height: 14),
                Center(
                  child: GestureDetector(
                    onTap: () => showComingSoon(context, '회원 탈퇴'),
                    child: const Text(
                      '회원 탈퇴',
                      style: TextStyle(fontSize: 13, color: AppColors.inkFaint, decoration: TextDecoration.underline),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showLicenses(BuildContext context) async {
    final version = _version ?? (await PackageInfo.fromPlatform()).version;
    if (!context.mounted) return;
    showLicensePage(context: context, applicationName: '챌룸', applicationVersion: version);
  }
}
