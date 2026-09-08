import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'rooms.freezed.dart';
part 'rooms.g.dart';

@freezed
abstract class Room with _$Room {
  const factory Room({
    required int id,
    required String title,
    @Default(<String>[]) List<String> hashtags,

    /// 목록 카드에 겹쳐 보여줄 몇 명 — 전체 참여자가 아니다. 인원수는 [participantCount] 를 본다.
    @Default(<ParticipantInfo>[]) List<ParticipantInfo> participants,
    required int participantCount,
    required RoomStatus status,

    /// 어느 칩에도 안 묶이는 방일 수 있다 — 그러면 "전체"에서만 보인다.
    RoomCategory? category,
    String? thumbnailUrl,
  }) = _Room;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
}

@freezed
abstract class ParticipantInfo with _$ParticipantInfo {
  const factory ParticipantInfo({required String nickname, String? profileImageUrl}) = _ParticipantInfo;

  factory ParticipantInfo.fromJson(Map<String, dynamic> json) => _$ParticipantInfoFromJson(json);
}
