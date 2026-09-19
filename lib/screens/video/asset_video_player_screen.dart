import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

import '../../core/router/app_router.dart';
import '../../core/theme/app_theme.dart';
import '../../models/reports.dart';

/// [AssetVideoPlayerScreen] 으로 넘길 때 쓰는 값 — 라우터의 `extra` 로 그대로 전달한다.
/// PICK 영상·챌린지 원본 영상 등 번들 파일을 재생하는 곳이면 어디서나 이 타입을 쓴다.
///
/// [reportTarget] 이 있으면 AppBar 에 "⋮" 신고 메뉴가 뜬다 — "이번 주 챌룸 PICK" 미리보기처럼
/// 누가 올린 콘텐츠가 아닌 영상은 `null` 로 둬서 신고 메뉴 자체를 안 보여준다.
typedef AssetVideoArgs = ({String title, String assetPath, ReportTarget? reportTarget});

/// 앱에 번들된 영상이든, 사용자가 기기에서 직접 업로드한 영상이든, 서버가 호스팅하는
/// 영상이든 네이티브 플레이어로 재생한다. [assetPath] 가 `assets/` 로 시작하면 앱 번들
/// 자산으로, `http(s)://` 로 시작하면 서버가 들고 있는 영상 파일(원격 URL)로, 그 외엔
/// (방 만들기에서 "직접 업로드"로 고른) 기기 파일 경로로 취급한다.
///
/// 외부 링크(유튜브·인스타·틱톡)는 각 플랫폼 약관·임베드 제한 때문에
/// [openVideoInAppBrowser] 로 인앱 브라우저에 맡긴다 — 이 화면은 우리가 실제로
/// 파일을 갖고 있는 영상 전용이다.
class AssetVideoPlayerScreen extends StatefulWidget {
  const AssetVideoPlayerScreen({required this.title, required this.assetPath, this.reportTarget, super.key});

  final String title;
  final String assetPath;

  /// 있으면 AppBar 에 "⋮" 신고 메뉴가 뜬다.
  final ReportTarget? reportTarget;

  @override
  State<AssetVideoPlayerScreen> createState() => _AssetVideoPlayerScreenState();
}

class _AssetVideoPlayerScreenState extends State<AssetVideoPlayerScreen> {
  late final VideoPlayerController _controller;
  late final Future<void> _initialize;

  @override
  void initState() {
    super.initState();
    final path = widget.assetPath;
    _controller = switch (path) {
      _ when path.startsWith('assets/') => VideoPlayerController.asset(path),
      _ when path.startsWith('http://') || path.startsWith('https://') =>
        VideoPlayerController.networkUrl(Uri.parse(path)),
      _ => VideoPlayerController.file(File(path)),
    };
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
      appBar: AppBar(
        title: Text(widget.title, maxLines: 1, overflow: TextOverflow.ellipsis),
        actions: [
          if (widget.reportTarget case final target?)
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              color: AppColors.surface,
              surfaceTintColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: AppColors.border),
              ),
              onSelected: (_) => _report(target),
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: 'report',
                  child: Text('신고하기', style: TextStyle(fontSize: 15, color: AppColors.danger)),
                ),
              ],
            ),
        ],
      ),
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

  void _report(ReportTarget target) {
    context.push(RoutePath.report, extra: (target: target, targetLabel: widget.title));
  }
}
