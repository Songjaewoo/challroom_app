import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../models/rooms.dart';
import '../avatar_color.dart';

/// 참여자 몇 명을 겹친 원형 배지로 보여준다. 방 목록 카드가 쓴다.
class ParticipantAvatarStack extends StatelessWidget {
  const ParticipantAvatarStack({required this.participants, this.max = 3, super.key});

  final List<ParticipantInfo> participants;
  final int max;

  static const _diameter = 18.0;
  static const _overlap = 6.0;

  @override
  Widget build(BuildContext context) {
    final shown = participants.take(max).toList();
    if (shown.isEmpty) return const SizedBox.shrink();

    const step = _diameter - _overlap;

    return SizedBox(
      width: _diameter + (shown.length - 1) * step,
      height: _diameter,
      child: Stack(
        children: [
          for (var i = 0; i < shown.length; i++)
            Positioned(
              left: i * step,
              child: _Bubble(nickname: shown[i].nickname),
            ),
        ],
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.nickname});

  final String nickname;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ParticipantAvatarStack._diameter,
      height: ParticipantAvatarStack._diameter,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: avatarColorFor(nickname),
        border: Border.all(color: AppColors.surface, width: 1.5),
      ),
      child: Text(
        nickname.substring(0, 1),
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.onBrand),
      ),
    );
  }
}
