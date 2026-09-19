import 'package:freezed_annotation/freezed_annotation.dart';

part 'pick_videos.freezed.dart';
part 'pick_videos.g.dart';

/// 홈 화면 상단 "이번 주 챌룸 PICK" — 탭하면 영상을 보여주고, "+" 를 누르면 이 영상으로
/// 방 만들기를 시작한다.
///
/// [videoUrl] 과 [assetPath] 중 **정확히 하나만** 채운다:
/// - 유튜브·인스타·틱톡 같은 외부 링크는 [videoUrl] — 인앱 브라우저로 연다
/// - 우리가 실제로 파일을 갖고 있는 영상은 [assetPath] — 네이티브 플레이어로 재생한다.
///   [assetPath] 가 있으면 [videoUrl] 보다 우선한다. 세 가지 형태가 올 수 있다:
///   앱 번들 자산(`assets/...`), 기기의 로컬 파일 경로, 서버가 호스팅하는 영상의
///   `http(s)://` URL(실서버 PICK 중 `source` 가 `upload` 인 것 — 유튜브 등과 달리
///   우리가 파일을 직접 서빙하니 임베드/인앱 브라우저가 아니라 네이티브 플레이어로
///   재생해야 한다). [AssetVideoPlayerScreen] 이 이 셋을 구분해서 처리한다.
@freezed
abstract class PickVideo with _$PickVideo {
  const factory PickVideo({
    required int id,
    required String title,

    /// "YouTube Shorts", "직접 업로드" 같은 출처 표기.
    required String source,
    String? videoUrl,
    String? assetPath,
    String? thumbnailUrl,

    /// 기기에서 직접 업로드한 영상에서 그 자리에서 추출한 미리보기 이미지 — 로컬 파일 경로.
    /// [thumbnailUrl] 은 서버가 내려주는 원격 썸네일용이라, 우리가 그 자리에서 만든 로컬
    /// 파일은 구분해서 담는다.
    String? thumbnailPath,
  }) = _PickVideo;

  factory PickVideo.fromJson(Map<String, dynamic> json) => _$PickVideoFromJson(json);
}
