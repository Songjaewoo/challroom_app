import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../core/theme/app_theme.dart';

/// [AssetVideoPlayerScreen] 으로 넘길 때 쓰는 값 — 라우터의 `extra` 로 그대로 전달한다.
/// PICK 영상·챌린지 원본 영상 등 번들 파일을 재생하는 곳이면 어디서나 이 타입을 쓴다.
typedef AssetVideoArgs = ({String title, String assetPath});

/// 앱에 번들된(사용자가 올린) 영상을 네이티브 플레이어로 재생한다.
///
/// 외부 링크(유튜브·인스타·틱톡)는 각 플랫폼 약관·임베드 제한 때문에
/// [openVideoInAppBrowser] 로 인앱 브라우저에 맡긴다 — 이 화면은 우리가 실제로
/// 파일을 갖고 있는 영상 전용이다.
class AssetVideoPlayerScreen extends StatefulWidget {
  const AssetVideoPlayerScreen({required this.title, required this.assetPath, super.key});

  final String title;
  final String assetPath;

  @override
  State<AssetVideoPlayerScreen> createState() => _AssetVideoPlayerScreenState();
}

class _AssetVideoPlayerScreenState extends State<AssetVideoPlayerScreen> {
  late final VideoPlayerController _controller;
  late final Future<void> _initialize;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.assetPath);
    _initialize = _controller.initialize().then((_) {
      _controller.setLooping(true);
      unawaited(_controller.play());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title, maxLines: 1, overflow: TextOverflow.ellipsis)),
      body: FutureBuilder<void>(
        future: _initialize,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator(strokeWidth: 2));
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('영상을 불러오지 못했어요.', style: TextStyle(color: AppColors.inkMuted)),
            );
          }

          return Center(
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: GestureDetector(
                onTap: _togglePlay,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    VideoPlayer(_controller),
                    ValueListenableBuilder<VideoPlayerValue>(
                      valueListenable: _controller,
                      builder: (context, value, _) => AnimatedOpacity(
                        opacity: value.isPlaying ? 0 : 1,
                        duration: const Duration(milliseconds: 150),
                        child: const Icon(Icons.play_arrow_rounded, size: 64, color: AppColors.onBrand),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
          child: VideoProgressIndicator(
            _controller,
            allowScrubbing: true,
            padding: EdgeInsets.zero,
            colors: const VideoProgressColors(
              playedColor: AppColors.primary,
              bufferedColor: AppColors.border,
              backgroundColor: AppColors.accentSoft,
            ),
          ),
        ),
      ),
    );
  }

  void _togglePlay() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      unawaited(_controller.play());
    }
  }
}
