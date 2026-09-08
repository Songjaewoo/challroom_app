import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import 'widgets/home_feed_view.dart';

/// 바텀 네비게이션 4탭의 셸. "홈" 탭만 실제 콘텐츠가 있고 나머지는 준비 중이다.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _tabIndex = 0;

  static const _tabs = [
    HomeFeedView(),
    _ComingSoonTab(label: '내 방'),
    _ComingSoonTab(label: '방 만들기'),
    _ComingSoonTab(label: '프로필'),
  ];

  static const _items = [
    BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: '홈'),
    BottomNavigationBarItem(icon: Icon(Icons.meeting_room_outlined), label: '내 방'),
    BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), label: '만들기'),
    BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: '프로필'),
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
            onTap: (index) => setState(() => _tabIndex = index),
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
}

class _ComingSoonTab extends StatelessWidget {
  const _ComingSoonTab({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('$label 화면은 곧 열려요', style: const TextStyle(fontSize: 13, color: AppColors.inkMuted)),
    );
  }
}
