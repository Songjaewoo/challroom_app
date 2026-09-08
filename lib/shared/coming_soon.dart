import 'package:flutter/material.dart';

/// 아직 안 만든 기능(방 만들기·검색·알림 등) 자리에 임시로 붙이는 안내.
void showComingSoon(BuildContext context, [String feature = '이 기능']) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text('$feature은 곧 만나요!')));
}
