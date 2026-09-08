import 'package:flutter/material.dart';

/// `AsyncValue.loading` 을 그리는 공용 위젯.
class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) => const Center(child: CircularProgressIndicator());
}
