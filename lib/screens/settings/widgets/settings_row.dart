import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

/// 설정 화면의 리스트 한 줄 — 아이콘 + 라벨 + (선택) 값 텍스트 + (선택) trailing 위젯.
/// [trailing] 이 없고 [onTap] 이 있으면 자동으로 화살표(>)를 붙인다.
class SettingsRow extends StatelessWidget {
  const SettingsRow({required this.icon, required this.label, this.trailingText, this.trailing, this.onTap, super.key});

  final IconData icon;
  final String label;
  final String? trailingText;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        child: Row(
          children: [
            Icon(icon, size: 22, color: AppColors.inkMuted),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.ink),
              ),
            ),
            if (trailingText != null) ...[
              Text(trailingText!, style: const TextStyle(fontSize: 14, color: AppColors.inkMuted)),
              const SizedBox(width: 6),
            ],
            if (trailing != null)
              trailing!
            else if (onTap != null)
              const Icon(Icons.chevron_right_rounded, size: 20, color: AppColors.inkFaint),
          ],
        ),
      ),
    );
  }
}

/// [SettingsRow] 들을 한 면 색으로 묶고 사이에 구분선을 넣는다.
class SettingsGroup extends StatelessWidget {
  const SettingsGroup({required this.children, super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: AppColors.accentSoft, borderRadius: BorderRadius.circular(14)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Column(
          children: [
            for (var i = 0; i < children.length; i++) ...[
              children[i],
              if (i != children.length - 1) const Divider(height: 0.5, thickness: 0.5, color: AppColors.border),
            ],
          ],
        ),
      ),
    );
  }
}

/// "계정", "이용 안내" 같은 섹션 라벨.
class SettingsSectionLabel extends StatelessWidget {
  const SettingsSectionLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w500, color: AppColors.inkMuted),
      ),
    );
  }
}
