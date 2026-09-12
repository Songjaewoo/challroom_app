import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// 영상 URL을 인앱 브라우저(iOS `SFSafariViewController` / Android Custom Tabs)로 연다.
///
/// 유튜브 `/embed/` iframe 은 제작자가 임베드를 막아둔 영상(Shorts 에 흔하다)에서
/// "오류 코드: 152-4" 같은 재생 불가 화면만 띄운다. 실제 유튜브 페이지를 그대로 열면
/// 임베드 제한·연령 제한·로그인 필요 같은 경우를 유튜브 자신이 알아서 처리해 준다 —
/// 우리가 따로 플레이어를 만들 필요가 없다.
Future<void> openVideoInAppBrowser(BuildContext context, String url) async {
  final uri = Uri.tryParse(url);
  final opened = uri != null && await launchUrl(uri, mode: LaunchMode.inAppBrowserView);

  if (!opened && context.mounted) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('영상을 열 수 없어요.')));
  }
}
