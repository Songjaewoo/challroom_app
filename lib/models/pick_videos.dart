import 'package:freezed_annotation/freezed_annotation.dart';

part 'pick_videos.freezed.dart';
part 'pick_videos.g.dart';

/// 홈 화면 상단 "이번 주 챌룸 PICK" — 탭하면 이 영상으로 방 만들기를 시작한다.
@freezed
abstract class PickVideo with _$PickVideo {
  const factory PickVideo({
    required int id,
    required String title,

    /// "YouTube Shorts" 같은 출처 표기.
    required String source,
    String? thumbnailUrl,
  }) = _PickVideo;

  factory PickVideo.fromJson(Map<String, dynamic> json) => _$PickVideoFromJson(json);
}
