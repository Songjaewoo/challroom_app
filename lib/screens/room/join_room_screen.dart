import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../controllers/join_room_controller.dart';
import '../../core/error/error_message.dart';
import '../../core/router/app_router.dart';
import '../../core/theme/app_theme.dart';

/// 초대 코드를 입력해 방에 들어간다 — "내 방" 탭의 "코드로 참여" 로 들어온다.
class JoinRoomScreen extends ConsumerStatefulWidget {
  const JoinRoomScreen({super.key});

  @override
  ConsumerState<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends ConsumerState<JoinRoomScreen> {
  final _codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _codeController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  bool get _canSubmit => _codeController.text.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final join = ref.watch(joinRoomProvider);

    ref.listen(joinRoomProvider, (previous, next) {
      // `build()` 도 처음에 `null` 을 내놓으니, 값이 있을 때(널 아닐 때)만 이동으로 본다 —
      // 열리자마자 이동해버리는 걸 막는다.
      if (next case AsyncData(value: final room?)) {
        context.pushReplacement(RoutePath.roomDetailOf(room.id));
        return;
      }
      if (next case AsyncError(:final error)) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(error.toUserMessage())));
      }
    });

    final busy = join.isLoading;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: busy ? null : () => context.pop(), icon: const Icon(Icons.close)),
        title: const Text('코드로 방 참여'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '친구에게 받은 초대 코드를 입력하세요',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.ink),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _codeController,
                enabled: !busy,
                autofocus: true,
                textCapitalization: TextCapitalization.characters,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 6,
                  color: AppColors.ink,
                ),
                decoration: const InputDecoration(hintText: 'ABCD12'),
                onSubmitted: (_) => _canSubmit ? _submit() : null,
              ),
              const Spacer(),
              FilledButton(
                onPressed: busy || !_canSubmit ? null : _submit,
                child: busy
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.onBrand),
                      )
                    : const Text('입장하기'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    unawaited(ref.read(joinRoomProvider.notifier).submit(_codeController.text));
  }
}
