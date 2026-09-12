import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

/// 해시태그 칩 + 입력 — 칩을 지우거나(x) 텍스트를 입력하고 엔터로 새 태그를 추가한다.
class RoomHashtagField extends StatefulWidget {
  const RoomHashtagField({required this.hashtags, required this.onChanged, super.key});

  final List<String> hashtags;
  final ValueChanged<List<String>> onChanged;

  @override
  State<RoomHashtagField> createState() => _RoomHashtagFieldState();
}

class _RoomHashtagFieldState extends State<RoomHashtagField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      constraints: const BoxConstraints(minHeight: 44),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Wrap(
        spacing: 6,
        runSpacing: 6,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          for (final tag in widget.hashtags) _HashtagChip(tag: tag, onRemove: () => _remove(tag)),
          SizedBox(
            width: 90,
            child: TextField(
              controller: _controller,
              style: const TextStyle(fontSize: 12, color: AppColors.ink),
              decoration: const InputDecoration(
                isDense: true,
                filled: false,
                border: InputBorder.none,
                hintText: '태그 추가',
                hintStyle: TextStyle(fontSize: 12, color: AppColors.inkFaint),
                contentPadding: EdgeInsets.zero,
              ),
              onSubmitted: _add,
            ),
          ),
        ],
      ),
    );
  }

  void _add(String value) {
    final tag = value.trim().replaceFirst(RegExp('^#'), '');
    _controller.clear();
    if (tag.isEmpty || widget.hashtags.contains(tag)) return;
    widget.onChanged([...widget.hashtags, tag]);
  }

  void _remove(String tag) {
    widget.onChanged(widget.hashtags.where((t) => t != tag).toList());
  }
}

class _HashtagChip extends StatelessWidget {
  const _HashtagChip({required this.tag, required this.onRemove});

  final String tag;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: AppColors.primarySoft, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('#$tag', style: const TextStyle(fontSize: 12, color: AppColors.primary)),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onRemove,
            child: const Icon(Icons.close, size: 11, color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}
