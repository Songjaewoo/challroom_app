import 'package:freezed_annotation/freezed_annotation.dart';

part 'notices.freezed.dart';
part 'notices.g.dart';

/// 공지사항 하나. 목록이 이미 본문까지 들고 있어서, 상세 화면은 다시 조회하지 않고
/// 목록에서 탭한 값을 그대로(`extra`) 받아 보여준다.
@freezed
abstract class Notice with _$Notice {
  const factory Notice({
    required int id,
    required String title,
    required String content,
    required DateTime createdAt,

    /// 목록 맨 위에 "공지" 배지와 함께 고정해 보여줄지.
    @Default(false) bool isPinned,
  }) = _Notice;

  factory Notice.fromJson(Map<String, dynamic> json) => _$NoticeFromJson(json);
}
