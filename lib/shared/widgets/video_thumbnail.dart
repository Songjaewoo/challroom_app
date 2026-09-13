import 'package:flutter/material.dart';

/// [url] 이 있으면 그 이미지를, 없거나 로드에 실패하면 순환 색 배경 위에 재생 아이콘을
/// 보여준다. 방/챌린지 목록 카드가 공통으로 쓰는 [ThumbnailFrame] 의 안쪽 내용물.
class VideoThumbnail extends StatelessWidget {
  const VideoThumbnail({required this.url, required this.style, this.iconSize = 20, super.key});

  final String? url;
  final ({Color background, Color accent}) style;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final placeholder = Container(
      color: style.background,
      alignment: Alignment.center,
      child: Icon(Icons.play_arrow_rounded, size: iconSize, color: style.accent),
    );

    final url = this.url;
    if (url == null || url.isEmpty) return placeholder;

    return Image.network(url, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => placeholder);
  }
}
