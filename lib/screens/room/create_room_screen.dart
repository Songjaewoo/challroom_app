import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../controllers/create_room_controller.dart';
import '../../core/error/error_message.dart';
import '../../core/router/app_router.dart';
import '../../core/theme/app_theme.dart';
import '../../models/pick_videos.dart';
import '../../models/rooms.dart';
import '../../shared/widgets/thumbnail_frame.dart';
import 'widgets/room_hashtag_field.dart';

/// "이번 주 챌룸 PICK" 의 "+" 로 들어오면 [initialPickVideo] 가 채워진 채로 시작하고,
/// 바텀 네비게이션 "만들기" 탭으로 들어오면 `null` 로 시작해 영상 없이도 만들 수 있다.
/// 영상이 없거나 마음에 안 들면 화면 안에서 링크를 붙여넣거나 기기 영상을 직접 올릴 수 있다.
class CreateRoomScreen extends ConsumerStatefulWidget {
  const CreateRoomScreen({this.initialPickVideo, super.key});

  final PickVideo? initialPickVideo;

  @override
  ConsumerState<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends ConsumerState<CreateRoomScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _videoUrlController = TextEditingController();
  var _hashtags = <String>[];
  var _isPublic = true;
  PickVideo? _pickVideo;

  /// `_pickVideo` 가 "이번 주 챌룸 PICK" 에서 그대로 넘어온 값인지, 화면 안에서
  /// 링크/업로드로 직접 채운 값인지 — 제출할 때 `pickVideoId` 로 보낼지
  /// `videoUrl`/`assetPath` 로 보낼지를 가른다.
  var _isCustomVideo = false;

  @override
  void initState() {
    super.initState();
    _pickVideo = widget.initialPickVideo;
    _titleController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _videoUrlController.dispose();
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
            const SizedBox(height: 7),
            _PickVideoCard(
              video: _pickVideo,
              urlController: _videoUrlController,
              enabled: !busy,
              onUrlSubmitted: _submitVideoUrl,
              onUpload: _uploadVideoFile,
              onClear: _clearVideo,
            ),
            const SizedBox(height: 18),
            const _FieldLabel('방 이름'),
            const SizedBox(height: 7),
            TextField(
              key: const Key('createRoomTitleField'),
              controller: _titleController,
              enabled: !busy,
              style: const TextStyle(fontSize: 16),
              decoration: const InputDecoration(hintText: '예: 우리끼리 텐션 챌린지'),
            ),
            const SizedBox(height: 18),
            const _FieldLabel('상세 설명'),
            const SizedBox(height: 7),
            TextField(
              controller: _descriptionController,
              enabled: !busy,
              minLines: 3,
              maxLines: 6,
              style: const TextStyle(fontSize: 15.5),
              decoration: const InputDecoration(hintText: '어떤 챌린지인지, 어떻게 참여하면 되는지 알려주세요 (선택)'),
            ),
            const SizedBox(height: 18),
            const _FieldLabel('해시태그'),
            const SizedBox(height: 7),
            RoomHashtagField(hashtags: _hashtags, onChanged: (tags) => setState(() => _hashtags = tags)),
            const SizedBox(height: 22),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '공개 방',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.ink),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '홈 피드에 노출돼요',
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(fontSize: 13.5, color: AppColors.inkFaint),
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

  /// URL 입력 필드에서 바로 확정 — 다이얼로그/시트 없이 그 자리에서 카드가 바뀐다.
  void _submitVideoUrl(String raw) {
    final url = raw.trim();
    if (url.isEmpty) return;

    setState(() {
      _pickVideo = PickVideo(id: 0, title: url, source: _sourceLabelFor(url), videoUrl: url);
      _isCustomVideo = true;
    });
    _videoUrlController.clear();
    FocusScope.of(context).unfocus();
  }

  /// "직접 업로드" 를 탭하면 곧바로 갤러리가 뜬다 — 중간에 고르는 시트를 거치지 않는다.
  Future<void> _uploadVideoFile() async {
    final file = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (file == null || !mounted) return;

    setState(() {
      _pickVideo = PickVideo(id: 0, title: file.name, source: '직접 업로드', assetPath: file.path);
      _isCustomVideo = true;
    });

    // 우리가 실제로 파일을 갖고 있는 영상이라 그 자리에서 미리보기 이미지를 뽑을 수 있다 —
    // (링크로 받은 영상은 파일이 없어서 이 방식으로는 못 뽑는다). 시간이 걸릴 수 있어 카드는
    // 먼저 텍스트로 보여주고, 다 되면 이미지로 바꿔 끼운다. 실패해도 업로드 자체는 막지 않는다.
    try {
      final thumbnailPath = await VideoThumbnail.thumbnailFile(
        video: file.path,
        thumbnailPath: Directory.systemTemp.path,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 200,
        quality: 70,
      );
      if (!mounted || _pickVideo?.assetPath != file.path) return;
      setState(() => _pickVideo = _pickVideo?.copyWith(thumbnailPath: thumbnailPath));
    } on Object {
      // 썸네일은 있으면 좋은 정도라 실패해도 조용히 넘어간다 — 카드는 기본 아이콘으로 남는다.
    }
  }

  void _clearVideo() {
    setState(() {
      _pickVideo = null;
      _isCustomVideo = false;
    });
    _videoUrlController.clear();
  }

  String _sourceLabelFor(String url) {
    final lower = url.toLowerCase();
    if (lower.contains('youtube') || lower.contains('youtu.be')) return 'YouTube';
    if (lower.contains('instagram')) return 'Instagram';
    if (lower.contains('tiktok')) return 'TikTok';
    return '링크';
  }

  void _submit() {
    final video = _pickVideo;
    final description = _descriptionController.text.trim();
    unawaited(
      ref
          .read(createRoomProvider.notifier)
          .submit(
            RoomCreateReq(
              title: _titleController.text.trim(),
              description: description.isEmpty ? null : description,
              hashtags: _hashtags,
              isPublic: _isPublic,
              pickVideoId: video != null && !_isCustomVideo ? video.id : null,
              videoUrl: video != null && _isCustomVideo ? video.videoUrl : null,
              assetPath: video != null && _isCustomVideo ? video.assetPath : null,
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
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.inkMuted),
    );
  }
}

/// 영상을 아직 안 골랐으면 — 시트나 다이얼로그로 한 단계 더 들어가지 않고 — 이 카드
/// 안에서 곧바로 링크를 붙여넣거나 "직접 업로드"를 눌러 갤러리를 띄운다.
/// 영상을 고른 뒤에는 미리보기로 바뀌고, "다시 고르기"를 누르면 그 자리에서 입력 상태로 돌아간다.
class _PickVideoCard extends StatelessWidget {
  const _PickVideoCard({
    required this.video,
    required this.urlController,
    required this.enabled,
    required this.onUrlSubmitted,
    required this.onUpload,
    required this.onClear,
  });

  final PickVideo? video;
  final TextEditingController urlController;
  final bool enabled;
  final ValueChanged<String> onUrlSubmitted;
  final VoidCallback onUpload;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final chosen = video;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: AppColors.accentSoft, borderRadius: BorderRadius.circular(14)),
      child: chosen == null ? _buildInput(context) : _buildPreview(chosen),
    );
  }

  Widget _buildInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                key: const Key('createRoomVideoUrlField'),
                controller: urlController,
                enabled: enabled,
                style: const TextStyle(fontSize: 15, color: AppColors.ink),
                textInputAction: TextInputAction.done,
                onSubmitted: onUrlSubmitted,
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: AppColors.surface,
                  hintText: '유튜브·인스타그램·틱톡 링크를 붙여넣어요',
                  hintStyle: const TextStyle(fontSize: 13.5, color: AppColors.inkFaint),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                  // 뭔가 입력했을 때만 확정 버튼이 나온다 — 평소엔 입력창만 깔끔하게 보인다.
                  suffixIcon: ValueListenableBuilder<TextEditingValue>(
                    valueListenable: urlController,
                    builder: (context, value, _) {
                      if (value.text.trim().isEmpty) return const SizedBox.shrink();
                      return IconButton(
                        icon: const Icon(Icons.check_circle, color: AppColors.primary),
                        onPressed: enabled ? () => onUrlSubmitted(value.text) : null,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: enabled ? onUpload : null,
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 영상을 "추가"하는 액션이라 진행형 CTA(핑크)와 구분해서 코랄(logoMid)을 쓴다.
              Icon(Icons.upload_file_outlined, size: 17, color: AppColors.logoMid),
              SizedBox(width: 5),
              Text(
                '기기에서 직접 업로드',
                style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w500, color: AppColors.logoMid),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPreview(PickVideo chosen) {
    final thumbnailPath = chosen.thumbnailPath;
    return Row(
      children: [
        ThumbnailFrame(
          width: 46,
          height: 78,
          radius: 8,
          child: Container(
            alignment: Alignment.center,
            // 영상 미리보기 자리 — 카드보다 한 단 낮춰서(surface) 안으로 들어간 느낌을 준다.
            color: AppColors.surface,
            // 기기에서 직접 올린 영상은 그 자리에서 뽑은 실제 프레임을 보여준다 — 링크로 받은
            // 영상은 우리가 파일을 갖고 있지 않아 이 방식으로는 못 뽑아서 기본 아이콘으로 남는다.
            child: thumbnailPath != null
                ? Image.file(File(thumbnailPath), fit: BoxFit.cover, width: 46, height: 78)
                : const Icon(Icons.play_arrow_rounded, size: 22, color: AppColors.inkMuted),
          ),
        ),
        const SizedBox(width: 11),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                chosen.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.ink),
              ),
              const SizedBox(height: 4),
              Text(chosen.source, style: const TextStyle(fontSize: 13.5, color: AppColors.inkFaint)),
            ],
          ),
        ),
        GestureDetector(
          onTap: enabled ? onClear : null,
          child: const Text(
            '다시 고르기',
            style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w500, color: AppColors.logoMid),
          ),
        ),
      ],
    );
  }
}
