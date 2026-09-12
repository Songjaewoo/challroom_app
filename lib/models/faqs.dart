import 'package:freezed_annotation/freezed_annotation.dart';

part 'faqs.freezed.dart';
part 'faqs.g.dart';

/// 자주 묻는 질문 하나. 목록이 이미 답변까지 들고 있어서, 상세 화면은 다시 조회하지 않고
/// 목록에서 탭한 값을 그대로(`extra`) 받아 보여준다.
@freezed
abstract class Faq with _$Faq {
  const factory Faq({
    required int id,
    required String question,
    required String answer,

    /// 목록에서 묶어 보여줄 분류 — "계정", "방/챌린지" 처럼.
    required String category,
  }) = _Faq;

  factory Faq.fromJson(Map<String, dynamic> json) => _$FaqFromJson(json);
}
