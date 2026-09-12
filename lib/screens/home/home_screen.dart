import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/app_router.dart';
import '../../core/theme/app_theme.dart';
import '../room/my_rooms_screen.dart';
import '../settings/settings_screen.dart';
import 'widgets/home_feed_view.dart';

/// 바텀 네비게이션 4탭의 셸. "만들기"는 탭이 아니라 액션이다 — 눌러도 탭이 안 바뀌고
/// 방 만들기 화면을 모달로 띄운다.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _tabIndex = 0;

  static const _tabs = [
    HomeFeedView(),
    MyRoomsScreen(),
    SizedBox.shrink(), // "만들기" 는 액션이라 이 자리로 탭이 넘어올 일이 없다.
    SettingsScreen(),
  ];

  static const _items = [
    BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: '홈'),
    BottomNavigationBarItem(icon: Icon(Icons.meeting_room_outlined), label: '내 방'),
    BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), label: '만들기'),
    BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: '설정'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: IndexedStack(index: _tabIndex, children: _tabs),
      ),
      bottomNavigationBar: DecoratedBox(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: SafeArea(
          top: false,
          child: BottomNavigationBar(
            currentIndex: _tabIndex,
            onTap: _onTabTap,
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.surface,
            elevation: 0,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.inkMuted,
            selectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
            unselectedLabelStyle: const TextStyle(fontSize: 10),
            items: _items,
          ),
        ),
      ),
    );
  }

  void _onTabTap(int index) {
    // "만들기" 는 탭 콘텐츠가 없는 액션이다 — 현재 탭은 그대로 두고 화면만 띄운다.
    if (index == 2) {
      context.push(RoutePath.createRoom);
      return;
    }
    setState(() => _tabIndex = index);
  }
}
