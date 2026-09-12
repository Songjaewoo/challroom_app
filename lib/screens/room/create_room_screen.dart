import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../controllers/create_room_controller.dart';
import '../../core/error/error_message.dart';
import '../../core/router/app_router.dart';
import '../../core/theme/app_theme.dart';
import '../../models/pick_videos.dart';
import '../../models/rooms.dart';
import '../../shared/coming_soon.dart';
import 'widgets/room_hashtag_field.dart';

/// "이번 주 챌룸 PICK" 의 "+" 로 들어오면 [initialPickVideo] 가 채워진 채로 시작하고,
/// 바텀 네비게이션 "만들기" 탭으로 들어오면 `null` 로 시작해 영상 없이도 만들 수 있다.
class CreateRoomScreen extends ConsumerStatefulWidget {
  const CreateRoomScreen({this.initialPickVideo, super.key});

  final PickVideo? initialPickVideo;

  @override
  ConsumerState<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends ConsumerState<CreateRoomScreen> {
  final _titleController = TextEditingController();
  var _hashtags = <String>[];
  var _isPublic = true;
  PickVideo? _pickVideo;

  @override
  void initState() {
    super.initState();
    _pickVideo = widget.initialPickVideo;
    _titleController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  bool get _canSubmit => _titleController.text.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final create = ref.watch(createRoomProvider);

    ref.listen(createRoomProvider, (previous, next) {
      if (next case AsyncData(value: final room?)) {
        // pop 뒤에 곧바로 push 하면 타이밍이 꼬일 수 있다 — 방 만들기 화면 자체를
        // 방 상세로 교체한다.
        context.pushReplacement(RoutePath.roomDetailOf(room.id));
        return;
      }
      if (next case AsyncError(:final error)) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(error.toUserMessage())));
      }
    });

    final busy = create.isLoading;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: busy ? null : () => context.pop(), icon: const Icon(Icons.close)),
        title: const Text('방 만들기'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
          children: [
            const _FieldLabel('챌린지 영상'),
            const SizedBox(height: 6),
            _PickVideoCard(video: _pickVideo, onChange: () => showComingSoon(context, '영상 선택')),
            const SizedBox(height: 16),
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
                  : const Text('방 만들기'),
            ),
          ],
        ),
      ),
    );
  }

  void _submit() {
    unawaited(
      ref
          .read(createRoomProvider.notifier)
          .submit(
            RoomCreateReq(
              title: _titleController.text.trim(),
              hashtags: _hashtags,
              isPublic: _isPublic,
              pickVideoId: _pickVideo?.id,
            ),
          ),
    );
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

class _PickVideoCard extends StatelessWidget {
  const _PickVideoCard({required this.video, required this.onChange});

  final PickVideo? video;
  final VoidCallback onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 74,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: AppColors.accentSoft, borderRadius: BorderRadius.circular(8)),
            child: Icon(
              video == null ? Icons.videocam_outlined : Icons.play_arrow_rounded,
              size: 18,
              color: AppColors.inkMuted,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  video?.title ?? '영상을 선택해 주세요',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.ink),
                ),
                if (video != null) ...[
                  const SizedBox(height: 4),
                  Text(video!.source, style: const TextStyle(fontSize: 11, color: AppColors.inkFaint)),
                ],
              ],
            ),
          ),
          GestureDetector(
            onTap: onChange,
            child: Text(video == null ? '선택' : '변경', style: const TextStyle(fontSize: 12, color: AppColors.primary)),
          ),
        ],
      ),
    );
  }
}
