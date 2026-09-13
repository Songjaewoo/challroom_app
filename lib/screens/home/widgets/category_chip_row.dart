import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/home_controller.dart';
import '../../../core/theme/app_theme.dart';
import '../../../models/enums.dart';

/// "전체" + [RoomCategory] 칩 한 줄. 선택 상태는 [selectedRoomCategoryProvider] 가 들고 있다.
class CategoryChipRow extends ConsumerWidget {
  const CategoryChipRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedRoomCategoryProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 칩 자체 높이만 여기서 잡는다 — 아래 여백은 별도 SizedBox 로 빼서, 폰트가 바뀌어도
        // 글자가 잘리지 않게(예전엔 여백을 이 안에 욱여넣어서 실제 글자 자리가 너무 좁았다).
        SizedBox(
          height: 40,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            scrollDirection: Axis.horizontal,
            children: [
              _Chip(
                label: '전체',
                selected: selected == null,
                onTap: () => ref.read(selectedRoomCategoryProvider.notifier).select(null),
              ),
              for (final category in RoomCategory.values) ...[
                const SizedBox(width: 8),
                _Chip(
                  label: category.label,
                  selected: selected == category,
                  onTap: () => ref.read(selectedRoomCategoryProvider.notifier).select(category),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 14),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.accentSoft,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13.5,
            height: 1,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            color: selected ? AppColors.onBrand : AppColors.inkMuted,
          ),
        ),
      ),
    );
  }
}
