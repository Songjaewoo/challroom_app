import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../models/rooms.dart';

/// 방 상세 AppBar "⋮" 로 여는 액션.
enum RoomSettingsAction {
  editRoom('방 정보 수정', destructive: false),
  deleteRoom('방 삭제', destructive: true),
  report('신고하기', destructive: false),
  leave('방 나가기', destructive: true);

  const RoomSettingsAction(this.label, {required this.destructive});

  final String label;
  final bool destructive;
}

/// 방 자체에 대한 설정 — 방장/멤버가 서로 다른 항목을 본다.
/// 멤버 강퇴 같은 "멤버 관리"는 이미 "멤버 N명" 을 눌러 별도 화면으로 뺐으니 여기 섞지 않는다.
///
/// - 방장: 방 정보 수정, 방 삭제
/// - 멤버: 신고하기, 방 나가기
///
/// 바텀시트 대신 아이콘 자리에서 바로 펼쳐지는 팝업 메뉴다 — 누른 위치 근처에서 바로
/// 뜨는 게 매번 화면 아래에서 시트를 올리는 것보다 손이 덜 가고 빠르다.
class RoomSettingsMenuButton extends StatelessWidget {
  const RoomSettingsMenuButton({required this.room, required this.onSelected, super.key});

  /// 아직 방 데이터가 로딩 중이면 `null` — 그동안은 버튼이 비활성 상태다
  /// (방장 여부를 몰라 무슨 항목을 보여줄지 정할 수 없다).
  final RoomDetail? room;
  final ValueChanged<RoomSettingsAction> onSelected;

  @override
  Widget build(BuildContext context) {
    final room = this.room;

    return PopupMenuButton<RoomSettingsAction>(
      enabled: room != null,
      icon: const Icon(Icons.more_vert),
      color: AppColors.surface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.border),
      ),
      onSelected: onSelected,
      itemBuilder: (context) {
        final actions = room!.isOwnedByMe
            ? const [RoomSettingsAction.editRoom, RoomSettingsAction.deleteRoom]
            : const [RoomSettingsAction.report, RoomSettingsAction.leave];

        return [
          for (final action in actions)
            PopupMenuItem(
              value: action,
              child: Text(
                action.label,
                style: TextStyle(
                  fontSize: 15,
                  color: action.destructive ? AppColors.primary : AppColors.ink,
                ),
              ),
            ),
        ];
      },
    );
  }
}
