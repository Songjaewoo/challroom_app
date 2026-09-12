import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../controllers/room_edit_controller.dart';
import '../../core/error/error_message.dart';
import '../../core/theme/app_theme.dart';
import '../../models/rooms.dart';
import 'widgets/room_hashtag_field.dart';

/// 방 상세 "⋮" > "방 정보 수정" 으로 들어온다. [initial] 로 현재 값(제목/해시태그/공개 여부)을
/// 미리 채운다 — 방 만들기 화면과 필드는 같지만 영상은 나중에 못 바꿔 그 필드가 없다.
class RoomEditScreen extends ConsumerStatefulWidget {
  const RoomEditScreen({required this.roomId, required this.initial, super.key});

  final int roomId;
  final RoomDetail initial;

  @override
  ConsumerState<RoomEditScreen> createState() => _RoomEditScreenState();
}

class _RoomEditScreenState extends ConsumerState<RoomEditScreen> {
  late final TextEditingController _titleController;
  late var _hashtags = widget.initial.hashtags;
  late var _isPublic = widget.initial.isPublic;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initial.title)..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  bool get _canSubmit => _titleController.text.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final edit = ref.watch(roomEditProvider(widget.roomId));

    // 팝은 여기서 하지 않는다 — `build()` 자체가 `async {}` 라 처음 열릴 때도 loading→data 로
    // 똑같이 바뀌는데, 그걸 "저장 성공"과 구분 못 해 열자마자 튕겨나가는 버그가 있었다.
    // 팝은 `_submit()` 이 실제로 끝난 뒤 명시적으로 한다 — [ProfileEditScreen] 과 같은 패턴.
    ref.listen(roomEditProvider(widget.roomId), (previous, next) {
      if (next case AsyncError(:final error)) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(error.toUserMessage())));
      }
    });

    final busy = edit.isLoading;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: busy ? null : () => context.pop(), icon: const Icon(Icons.close)),
        title: const Text('방 정보 수정'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
          children: [
            const _FieldLabel('방 이름'),
            const SizedBox(height: 6),
            TextField(
              controller: _titleController,
              enabled: !busy,
              decoration: const InputDecoration(hintText: '예: 우리끼리 텐션 챌린지'),
            ),
            const SizedBox(height: 16),
            const _FieldLabel('해시태그'),
            const SizedBox(height: 6),
            RoomHashtagField(hashtags: _hashtags, onChanged: (tags) => setState(() => _hashtags = tags)),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '공개 방',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.ink),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '홈 피드에 노출돼요',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.inkFaint),
                      ),
                    ],
                  ),
                ),
                Switch(value: _isPublic, onChanged: busy ? null : (value) => setState(() => _isPublic = value)),
              ],
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: busy || !_canSubmit ? null : _submit,
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
    );
  }

  Future<void> _submit() async {
    await ref
        .read(roomEditProvider(widget.roomId).notifier)
        .submit(RoomUpdateReq(title: _titleController.text.trim(), hashtags: _hashtags, isPublic: _isPublic));
    if (!mounted) return;

    // 실패했으면 에러 스낵바가 이미 떴다 — 화면에 남아서 다시 시도할 수 있게 한다.
    if (ref.read(roomEditProvider(widget.roomId)).hasError) return;
    context.pop();
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.inkMuted),
    );
  }
}
