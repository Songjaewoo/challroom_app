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

/// 설정 > 프로필 카드에서 들어오는 편집 화면. 현재 닉네임·프로필 사진이 미리 채워져
/// 있다는 점, "취소"가 그냥 뒤로 가기라는 점만 온보딩([ProfileSetupScreen])과 다르다 —
/// 저장 로직은 [profileSetupProvider] 를 그대로 재사용한다.
class ProfileEditScreen extends ConsumerStatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  ConsumerState<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends ConsumerState<ProfileEditScreen> {
  late final TextEditingController _nicknameController;
  XFile? _avatar;

  @override
  void initState() {
    super.initState();
    _nicknameController = TextEditingController(text: ref.read(authProvider).value?.nickname ?? '')
      ..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  bool get _isNicknameValid => NicknameValidator.isValid(_nicknameController.text);

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider).value;
    final setup = ref.watch(profileSetupProvider);

    ref.listen(profileSetupProvider, (previous, next) {
      if (next case AsyncError(:final error)) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(error.toUserMessage())));
      }
    });

    final busy = setup.isLoading;

    return Scaffold(
      appBar: AppBar(title: const Text('프로필 편집')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: AvatarPicker(
                  image: _avatar,
                  existingImageUrl: user?.profileImageUrl,
                  onTap: busy ? null : _pickAvatar,
                ),
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
                    : const Text('저장'),
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

  Future<void> _submit() async {
    await ref.read(profileSetupProvider.notifier).submit(nickname: _nicknameController.text, avatar: _avatar);
    if (!mounted) return;

    // 실패했으면 에러 스낵바가 이미 떴다 — 화면에 남아서 다시 시도할 수 있게 한다.
    if (ref.read(profileSetupProvider).hasError) return;

    // submit() 안의 authProvider.refresh() 가 방금 라우터의 refreshListenable 을 건드렸다
    // — 그 재평가가 이번 프레임에서 아직 정착 중일 때 바로 pop 하면 GoRouter 가 자기
    // currentConfiguration 을 못 따라와 pop 이 씹힌다. 한 프레임 미뤄서 부른다.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) Navigator.of(context).maybePop();
    });
  }
}
