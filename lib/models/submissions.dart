import 'package:freezed_annotation/freezed_annotation.dart';

part 'submissions.freezed.dart';
part 'submissions.g.dart';

/// 챌린지 하나에 누가 올린 영상 한 편. [ChallengeDetail] 의 목록에 들어간다.
@freezed
abstract class Submission with _$Submission {
  const factory Submission({
    required int id,
    required String nickname,
    String? videoUrl,
    String? assetPath,
    String? thumbnailUrl,
    @Default(0) int commentCount,
  }) = _Submission;

  factory Submission.fromJson(Map<String, dynamic> json) => _$SubmissionFromJson(json);
}
