import 'package:freezed_annotation/freezed_annotation.dart';

part 'paged.freezed.dart';
part 'paged.g.dart';

/// 페이지네이션 응답. 도메인마다 `XxxPage` 를 만들지 않고 이 하나를 쓴다.
///
/// ```dart
/// Paged<Room>.fromJson(json, (e) => Room.fromJson(e! as Map<String, dynamic>));
/// ```
@Freezed(genericArgumentFactories: true)
abstract class Paged<T> with _$Paged<T> {
  const factory Paged({required List<T> items, required int total, required int totalPages}) = _Paged<T>;

  factory Paged.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) => _$PagedFromJson(json, fromJsonT);
}
