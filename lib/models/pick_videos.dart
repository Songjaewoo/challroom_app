import 'package:freezed_annotation/freezed_annotation.dart';

part 'pick_videos.freezed.dart';
part 'pick_videos.g.dart';

/// 홈 화면 상단 "이번 주 챌룸 PICK" — 탭하면 영상을 보여주고, "+" 를 누르면 이 영상으로
/// 방 만들기를 시작한다.
///
/// [videoUrl] 과 [assetPath] 중 **정확히 하나만** 채운다:
/// - 유튜브·인스타·틱톡 같은 외부 링크는 [videoUrl] — 인앱 브라우저로 연다
/// - 우리가 실제로 파일을 갖고 있는(사용자가 올린) 영상은 [assetPath] — 네이티브
///   플레이어로 재생한다. [assetPath] 가 있으면 [videoUrl] 보다 우선한다.
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
  }) = _PickVideo;

  factory PickVideo.fromJson(Map<String, dynamic> json) => _$PickVideoFromJson(json);
}
