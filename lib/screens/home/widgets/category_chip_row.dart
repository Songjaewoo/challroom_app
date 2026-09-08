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

    return SizedBox(
      height: 34,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(18, 0, 18, 12),
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
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.accentSoft,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: selected ? FontWeight.w500 : FontWeight.normal,
            color: selected ? AppColors.onBrand : AppColors.inkMuted,
          ),
        ),
      ),
    );
  }
}
