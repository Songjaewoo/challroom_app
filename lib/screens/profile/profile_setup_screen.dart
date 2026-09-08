import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/profile_setup_controller.dart';
import '../../core/error/error_message.dart';
import '../../core/theme/app_theme.dart';
import '../../shared/nickname_validator.dart';
import 'widgets/avatar_picker.dart';

class ProfileSetupScreen extends ConsumerStatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  ConsumerState<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends ConsumerState<ProfileSetupScreen> {
  // 셋 다 서버에 닿기 전까지는 순수 로컬 UI 상태다 — 제출할 때 한 번에 Controller 로 넘긴다.
  final _nicknameController = TextEditingController();
  XFile? _avatar;

  @override
  void initState() {
    super.initState();
    // "다음" 버튼의 활성/비활성만 갈아끼우면 되므로 입력마다 다시 그린다.
    _nicknameController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  bool get _isNicknameValid => NicknameValidator.isValid(_nicknameController.text);

  @override
  Widget build(BuildContext context) {
    final setup = ref.watch(profileSetupProvider);

    ref.listen(profileSetupProvider, (previous, next) {
      if (next case AsyncError(:final error)) {
        ScaffoldMessenger.of(context)
          ..hideCurrentMaterialBanner()
          ..showSnackBar(SnackBar(content: Text(error.toUserMessage())));
      }
    });

    final busy = setup.isLoading;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(onPressed: busy ? null : _cancel, icon: const Icon(Icons.arrow_back), color: AppColors.ink),
              const SizedBox(height: 4),
              Text(
                '프로필을 만들어주세요',
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w500, color: AppColors.ink),
              ),
              const SizedBox(height: 8),
              Text(
                '방 안에서 친구들에게 이렇게 보여요',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.inkMuted),
              ),
              const SizedBox(height: 28),
              Center(
                child: AvatarPicker(image: _avatar, onTap: busy ? null : _pickAvatar),
              ),
              const SizedBox(height: 28),
              TextField(
                controller: _nicknameController,
                enabled: !busy,
                maxLength: 10,
                decoration: const InputDecoration(hintText: '닉네임 입력', counterText: ''),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Text(
                  NicknameValidator.message,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, color: AppColors.inkFaint),
                ),
              ),
              const Spacer(),
              FilledButton(
                onPressed: busy || !_isNicknameValid ? null : _submit,
                child: busy
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.onBrand),
                      )
                    : const Text('다음'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickAvatar() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined, color: AppColors.ink),
              title: const Text('카메라로 촬영', style: TextStyle(color: AppColors.ink)),
              onTap: () => Navigator.pop(sheetContext, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_outlined, color: AppColors.ink),
              title: const Text('앨범에서 선택', style: TextStyle(color: AppColors.ink)),
              onTap: () => Navigator.pop(sheetContext, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
    if (source == null) return;

    final picked = await ImagePicker().pickImage(source: source, maxWidth: 1080, imageQuality: 85);
    if (picked == null || !mounted) return;

    setState(() => _avatar = picked);
  }

  void _cancel() {
    // 여기서 되돌아갈 이전 화면이 없다 — 프로필을 안 채우면 로그인 상태만 남는 게 이상하므로
    // 로그아웃으로 처리해 로그인 화면으로 보낸다.
    unawaited(ref.read(authProvider.notifier).signOut());
  }

  void _submit() {
    unawaited(ref.read(profileSetupProvider.notifier).submit(nickname: _nicknameController.text, avatar: _avatar));
  }
}
