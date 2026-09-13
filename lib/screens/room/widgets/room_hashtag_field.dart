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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      constraints: const BoxConstraints(minHeight: 48),
      decoration: BoxDecoration(color: AppColors.accentSoft, borderRadius: BorderRadius.circular(10)),
      // 칩이 없을 때(입력창만 있을 때)는 `Wrap` 의 내용 높이가 `minHeight` 보다 작아서, 정렬을
      // 안 해주면 위쪽에 붙어 버린다 — 세로 중앙 정렬을 명시한다.
      alignment: Alignment.centerLeft,
      child: Wrap(
        spacing: 7,
        runSpacing: 7,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          for (final tag in widget.hashtags) _HashtagChip(tag: tag, onRemove: () => _remove(tag)),
          SizedBox(
            width: 100,
            child: TextField(
              controller: _controller,
              style: const TextStyle(fontSize: 15, color: AppColors.ink),
              // `isDense` 만으로는 InputDecorator 가 기본으로 잡아두는 위아래 여백이 안 없어져
              // 옆 칩(Chip)과 세로 중앙이 안 맞았다 — `isCollapsed` 로 그 여백까지 없앤다.
              decoration: const InputDecoration(
                isCollapsed: true,
                filled: false,
                border: InputBorder.none,
                hintText: '태그 추가',
                hintStyle: TextStyle(fontSize: 15, color: AppColors.inkFaint),
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
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
      decoration: BoxDecoration(color: AppColors.primarySoft, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('#$tag', style: const TextStyle(fontSize: 15, color: AppColors.primary)),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onRemove,
            child: const Icon(Icons.close, size: 15, color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}
