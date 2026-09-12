// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rooms.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Room {

 int get id; String get title; List<String> get hashtags;/// 목록 카드에 겹쳐 보여줄 몇 명 — 전체 참여자가 아니다. 인원수는 [participantCount] 를 본다.
 List<ParticipantInfo> get participants; int get participantCount; RoomStatus get status;/// 어느 칩에도 안 묶이는 방일 수 있다 — 그러면 "전체"에서만 보인다.
 RoomCategory? get category; String? get thumbnailUrl;
/// Create a copy of Room
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoomCopyWith<Room> get copyWith => _$RoomCopyWithImpl<Room>(this as Room, _$identity);

  /// Serializes this Room to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Room&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.hashtags, hashtags)&&const DeepCollectionEquality().equals(other.participants, participants)&&(identical(other.participantCount, participantCount) || other.participantCount == participantCount)&&(identical(other.status, status) || other.status == status)&&(identical(other.category, category) || other.category == category)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(hashtags),const DeepCollectionEquality().hash(participants),participantCount,status,category,thumbnailUrl);

@override
String toString() {
  return 'Room(id: $id, title: $title, hashtags: $hashtags, participants: $participants, participantCount: $participantCount, status: $status, category: $category, thumbnailUrl: $thumbnailUrl)';
}


}

/// @nodoc
abstract mixin class $RoomCopyWith<$Res>  {
  factory $RoomCopyWith(Room value, $Res Function(Room) _then) = _$RoomCopyWithImpl;
@useResult
$Res call({
 int id, String title, List<String> hashtags, List<ParticipantInfo> participants, int participantCount, RoomStatus status, RoomCategory? category, String? thumbnailUrl
});




}
/// @nodoc
class _$RoomCopyWithImpl<$Res>
    implements $RoomCopyWith<$Res> {
  _$RoomCopyWithImpl(this._self, this._then);

  final Room _self;
  final $Res Function(Room) _then;

/// Create a copy of Room
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? hashtags = null,Object? participants = null,Object? participantCount = null,Object? status = null,Object? category = freezed,Object? thumbnailUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,hashtags: null == hashtags ? _self.hashtags : hashtags // ignore: cast_nullable_to_non_nullable
as List<String>,participants: null == participants ? _self.participants : participants // ignore: cast_nullable_to_non_nullable
as List<ParticipantInfo>,participantCount: null == participantCount ? _self.participantCount : participantCount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RoomStatus,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as RoomCategory?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Room].
extension RoomPatterns on Room {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Room value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Room() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Room value)  $default,){
final _that = this;
switch (_that) {
case _Room():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Room value)?  $default,){
final _that = this;
switch (_that) {
case _Room() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  List<String> hashtags,  List<ParticipantInfo> participants,  int participantCount,  RoomStatus status,  RoomCategory? category,  String? thumbnailUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Room() when $default != null:
return $default(_that.id,_that.title,_that.hashtags,_that.participants,_that.participantCount,_that.status,_that.category,_that.thumbnailUrl);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  List<String> hashtags,  List<ParticipantInfo> participants,  int participantCount,  RoomStatus status,  RoomCategory? category,  String? thumbnailUrl)  $default,) {final _that = this;
switch (_that) {
case _Room():
return $default(_that.id,_that.title,_that.hashtags,_that.participants,_that.participantCount,_that.status,_that.category,_that.thumbnailUrl);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  List<String> hashtags,  List<ParticipantInfo> participants,  int participantCount,  RoomStatus status,  RoomCategory? category,  String? thumbnailUrl)?  $default,) {final _that = this;
switch (_that) {
case _Room() when $default != null:
return $default(_that.id,_that.title,_that.hashtags,_that.participants,_that.participantCount,_that.status,_that.category,_that.thumbnailUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Room implements Room {
  const _Room({required this.id, required this.title, final  List<String> hashtags = const <String>[], final  List<ParticipantInfo> participants = const <ParticipantInfo>[], required this.participantCount, required this.status, this.category, this.thumbnailUrl}): _hashtags = hashtags,_participants = participants;
  factory _Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);

@override final  int id;
@override final  String title;
 final  List<String> _hashtags;
@override@JsonKey() List<String> get hashtags {
  if (_hashtags is EqualUnmodifiableListView) return _hashtags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hashtags);
}

/// 목록 카드에 겹쳐 보여줄 몇 명 — 전체 참여자가 아니다. 인원수는 [participantCount] 를 본다.
 final  List<ParticipantInfo> _participants;
/// 목록 카드에 겹쳐 보여줄 몇 명 — 전체 참여자가 아니다. 인원수는 [participantCount] 를 본다.
@override@JsonKey() List<ParticipantInfo> get participants {
  if (_participants is EqualUnmodifiableListView) return _participants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_participants);
}

@override final  int participantCount;
@override final  RoomStatus status;
/// 어느 칩에도 안 묶이는 방일 수 있다 — 그러면 "전체"에서만 보인다.
@override final  RoomCategory? category;
@override final  String? thumbnailUrl;

/// Create a copy of Room
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoomCopyWith<_Room> get copyWith => __$RoomCopyWithImpl<_Room>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoomToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Room&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._hashtags, _hashtags)&&const DeepCollectionEquality().equals(other._participants, _participants)&&(identical(other.participantCount, participantCount) || other.participantCount == participantCount)&&(identical(other.status, status) || other.status == status)&&(identical(other.category, category) || other.category == category)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(_hashtags),const DeepCollectionEquality().hash(_participants),participantCount,status,category,thumbnailUrl);

@override
String toString() {
  return 'Room(id: $id, title: $title, hashtags: $hashtags, participants: $participants, participantCount: $participantCount, status: $status, category: $category, thumbnailUrl: $thumbnailUrl)';
}


}

/// @nodoc
abstract mixin class _$RoomCopyWith<$Res> implements $RoomCopyWith<$Res> {
  factory _$RoomCopyWith(_Room value, $Res Function(_Room) _then) = __$RoomCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, List<String> hashtags, List<ParticipantInfo> participants, int participantCount, RoomStatus status, RoomCategory? category, String? thumbnailUrl
});




}
/// @nodoc
class __$RoomCopyWithImpl<$Res>
    implements _$RoomCopyWith<$Res> {
  __$RoomCopyWithImpl(this._self, this._then);

  final _Room _self;
  final $Res Function(_Room) _then;

/// Create a copy of Room
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? hashtags = null,Object? participants = null,Object? participantCount = null,Object? status = null,Object? category = freezed,Object? thumbnailUrl = freezed,}) {
  return _then(_Room(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,hashtags: null == hashtags ? _self._hashtags : hashtags // ignore: cast_nullable_to_non_nullable
as List<String>,participants: null == participants ? _self._participants : participants // ignore: cast_nullable_to_non_nullable
as List<ParticipantInfo>,participantCount: null == participantCount ? _self.participantCount : participantCount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RoomStatus,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as RoomCategory?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$RoomCreateReq {

 String get title; List<String> get hashtags; bool get isPublic;/// "이번 주 챌룸 PICK" 에서 골라 시작한 경우 그 영상 id — 직접 만들면 `null`.
 int? get pickVideoId;
/// Create a copy of RoomCreateReq
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoomCreateReqCopyWith<RoomCreateReq> get copyWith => _$RoomCreateReqCopyWithImpl<RoomCreateReq>(this as RoomCreateReq, _$identity);

  /// Serializes this RoomCreateReq to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoomCreateReq&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.hashtags, hashtags)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic)&&(identical(other.pickVideoId, pickVideoId) || other.pickVideoId == pickVideoId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,const DeepCollectionEquality().hash(hashtags),isPublic,pickVideoId);

@override
String toString() {
  return 'RoomCreateReq(title: $title, hashtags: $hashtags, isPublic: $isPublic, pickVideoId: $pickVideoId)';
}


}

/// @nodoc
abstract mixin class $RoomCreateReqCopyWith<$Res>  {
  factory $RoomCreateReqCopyWith(RoomCreateReq value, $Res Function(RoomCreateReq) _then) = _$RoomCreateReqCopyWithImpl;
@useResult
$Res call({
 String title, List<String> hashtags, bool isPublic, int? pickVideoId
});




}
/// @nodoc
class _$RoomCreateReqCopyWithImpl<$Res>
    implements $RoomCreateReqCopyWith<$Res> {
  _$RoomCreateReqCopyWithImpl(this._self, this._then);

  final RoomCreateReq _self;
  final $Res Function(RoomCreateReq) _then;

/// Create a copy of RoomCreateReq
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? hashtags = null,Object? isPublic = null,Object? pickVideoId = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,hashtags: null == hashtags ? _self.hashtags : hashtags // ignore: cast_nullable_to_non_nullable
as List<String>,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,pickVideoId: freezed == pickVideoId ? _self.pickVideoId : pickVideoId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [RoomCreateReq].
extension RoomCreateReqPatterns on RoomCreateReq {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoomCreateReq value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoomCreateReq() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoomCreateReq value)  $default,){
final _that = this;
switch (_that) {
case _RoomCreateReq():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoomCreateReq value)?  $default,){
final _that = this;
switch (_that) {
case _RoomCreateReq() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  List<String> hashtags,  bool isPublic,  int? pickVideoId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoomCreateReq() when $default != null:
return $default(_that.title,_that.hashtags,_that.isPublic,_that.pickVideoId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  List<String> hashtags,  bool isPublic,  int? pickVideoId)  $default,) {final _that = this;
switch (_that) {
case _RoomCreateReq():
return $default(_that.title,_that.hashtags,_that.isPublic,_that.pickVideoId);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  List<String> hashtags,  bool isPublic,  int? pickVideoId)?  $default,) {final _that = this;
switch (_that) {
case _RoomCreateReq() when $default != null:
return $default(_that.title,_that.hashtags,_that.isPublic,_that.pickVideoId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RoomCreateReq implements RoomCreateReq {
  const _RoomCreateReq({required this.title, final  List<String> hashtags = const <String>[], this.isPublic = true, this.pickVideoId}): _hashtags = hashtags;
  factory _RoomCreateReq.fromJson(Map<String, dynamic> json) => _$RoomCreateReqFromJson(json);

@override final  String title;
 final  List<String> _hashtags;
@override@JsonKey() List<String> get hashtags {
  if (_hashtags is EqualUnmodifiableListView) return _hashtags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hashtags);
}

@override@JsonKey() final  bool isPublic;
/// "이번 주 챌룸 PICK" 에서 골라 시작한 경우 그 영상 id — 직접 만들면 `null`.
@override final  int? pickVideoId;

/// Create a copy of RoomCreateReq
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoomCreateReqCopyWith<_RoomCreateReq> get copyWith => __$RoomCreateReqCopyWithImpl<_RoomCreateReq>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoomCreateReqToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoomCreateReq&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._hashtags, _hashtags)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic)&&(identical(other.pickVideoId, pickVideoId) || other.pickVideoId == pickVideoId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,const DeepCollectionEquality().hash(_hashtags),isPublic,pickVideoId);

@override
String toString() {
  return 'RoomCreateReq(title: $title, hashtags: $hashtags, isPublic: $isPublic, pickVideoId: $pickVideoId)';
}


}

/// @nodoc
abstract mixin class _$RoomCreateReqCopyWith<$Res> implements $RoomCreateReqCopyWith<$Res> {
  factory _$RoomCreateReqCopyWith(_RoomCreateReq value, $Res Function(_RoomCreateReq) _then) = __$RoomCreateReqCopyWithImpl;
@override @useResult
$Res call({
 String title, List<String> hashtags, bool isPublic, int? pickVideoId
});




}
/// @nodoc
class __$RoomCreateReqCopyWithImpl<$Res>
    implements _$RoomCreateReqCopyWith<$Res> {
  __$RoomCreateReqCopyWithImpl(this._self, this._then);

  final _RoomCreateReq _self;
  final $Res Function(_RoomCreateReq) _then;

/// Create a copy of RoomCreateReq
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? hashtags = null,Object? isPublic = null,Object? pickVideoId = freezed,}) {
  return _then(_RoomCreateReq(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,hashtags: null == hashtags ? _self._hashtags : hashtags // ignore: cast_nullable_to_non_nullable
as List<String>,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,pickVideoId: freezed == pickVideoId ? _self.pickVideoId : pickVideoId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$RoomUpdateReq {

 String get title; List<String> get hashtags; bool get isPublic;
/// Create a copy of RoomUpdateReq
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoomUpdateReqCopyWith<RoomUpdateReq> get copyWith => _$RoomUpdateReqCopyWithImpl<RoomUpdateReq>(this as RoomUpdateReq, _$identity);

  /// Serializes this RoomUpdateReq to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoomUpdateReq&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.hashtags, hashtags)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,const DeepCollectionEquality().hash(hashtags),isPublic);

@override
String toString() {
  return 'RoomUpdateReq(title: $title, hashtags: $hashtags, isPublic: $isPublic)';
}


}

/// @nodoc
abstract mixin class $RoomUpdateReqCopyWith<$Res>  {
  factory $RoomUpdateReqCopyWith(RoomUpdateReq value, $Res Function(RoomUpdateReq) _then) = _$RoomUpdateReqCopyWithImpl;
@useResult
$Res call({
 String title, List<String> hashtags, bool isPublic
});




}
/// @nodoc
class _$RoomUpdateReqCopyWithImpl<$Res>
    implements $RoomUpdateReqCopyWith<$Res> {
  _$RoomUpdateReqCopyWithImpl(this._self, this._then);

  final RoomUpdateReq _self;
  final $Res Function(RoomUpdateReq) _then;

/// Create a copy of RoomUpdateReq
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? hashtags = null,Object? isPublic = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,hashtags: null == hashtags ? _self.hashtags : hashtags // ignore: cast_nullable_to_non_nullable
as List<String>,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RoomUpdateReq].
extension RoomUpdateReqPatterns on RoomUpdateReq {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoomUpdateReq value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoomUpdateReq() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoomUpdateReq value)  $default,){
final _that = this;
switch (_that) {
case _RoomUpdateReq():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoomUpdateReq value)?  $default,){
final _that = this;
switch (_that) {
case _RoomUpdateReq() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  List<String> hashtags,  bool isPublic)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoomUpdateReq() when $default != null:
return $default(_that.title,_that.hashtags,_that.isPublic);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  List<String> hashtags,  bool isPublic)  $default,) {final _that = this;
switch (_that) {
case _RoomUpdateReq():
return $default(_that.title,_that.hashtags,_that.isPublic);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  List<String> hashtags,  bool isPublic)?  $default,) {final _that = this;
switch (_that) {
case _RoomUpdateReq() when $default != null:
return $default(_that.title,_that.hashtags,_that.isPublic);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RoomUpdateReq implements RoomUpdateReq {
  const _RoomUpdateReq({required this.title, final  List<String> hashtags = const <String>[], this.isPublic = true}): _hashtags = hashtags;
  factory _RoomUpdateReq.fromJson(Map<String, dynamic> json) => _$RoomUpdateReqFromJson(json);

@override final  String title;
 final  List<String> _hashtags;
@override@JsonKey() List<String> get hashtags {
  if (_hashtags is EqualUnmodifiableListView) return _hashtags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hashtags);
}

@override@JsonKey() final  bool isPublic;

/// Create a copy of RoomUpdateReq
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoomUpdateReqCopyWith<_RoomUpdateReq> get copyWith => __$RoomUpdateReqCopyWithImpl<_RoomUpdateReq>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoomUpdateReqToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoomUpdateReq&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._hashtags, _hashtags)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,const DeepCollectionEquality().hash(_hashtags),isPublic);

@override
String toString() {
  return 'RoomUpdateReq(title: $title, hashtags: $hashtags, isPublic: $isPublic)';
}


}

/// @nodoc
abstract mixin class _$RoomUpdateReqCopyWith<$Res> implements $RoomUpdateReqCopyWith<$Res> {
  factory _$RoomUpdateReqCopyWith(_RoomUpdateReq value, $Res Function(_RoomUpdateReq) _then) = __$RoomUpdateReqCopyWithImpl;
@override @useResult
$Res call({
 String title, List<String> hashtags, bool isPublic
});




}
/// @nodoc
class __$RoomUpdateReqCopyWithImpl<$Res>
    implements _$RoomUpdateReqCopyWith<$Res> {
  __$RoomUpdateReqCopyWithImpl(this._self, this._then);

  final _RoomUpdateReq _self;
  final $Res Function(_RoomUpdateReq) _then;

/// Create a copy of RoomUpdateReq
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? hashtags = null,Object? isPublic = null,}) {
  return _then(_RoomUpdateReq(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,hashtags: null == hashtags ? _self._hashtags : hashtags // ignore: cast_nullable_to_non_nullable
as List<String>,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ParticipantInfo {

 String get nickname; String? get profileImageUrl;/// 이 방의 방장이면 `true`. [RoomMembersScreen] 이 "방장" 배지를 붙이는 데 쓴다.
 bool get isOwner;
/// Create a copy of ParticipantInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParticipantInfoCopyWith<ParticipantInfo> get copyWith => _$ParticipantInfoCopyWithImpl<ParticipantInfo>(this as ParticipantInfo, _$identity);

  /// Serializes this ParticipantInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParticipantInfo&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.profileImageUrl, profileImageUrl) || other.profileImageUrl == profileImageUrl)&&(identical(other.isOwner, isOwner) || other.isOwner == isOwner));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,nickname,profileImageUrl,isOwner);

@override
String toString() {
  return 'ParticipantInfo(nickname: $nickname, profileImageUrl: $profileImageUrl, isOwner: $isOwner)';
}


}

/// @nodoc
abstract mixin class $ParticipantInfoCopyWith<$Res>  {
  factory $ParticipantInfoCopyWith(ParticipantInfo value, $Res Function(ParticipantInfo) _then) = _$ParticipantInfoCopyWithImpl;
@useResult
$Res call({
 String nickname, String? profileImageUrl, bool isOwner
});




}
/// @nodoc
class _$ParticipantInfoCopyWithImpl<$Res>
    implements $ParticipantInfoCopyWith<$Res> {
  _$ParticipantInfoCopyWithImpl(this._self, this._then);

  final ParticipantInfo _self;
  final $Res Function(ParticipantInfo) _then;

/// Create a copy of ParticipantInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nickname = null,Object? profileImageUrl = freezed,Object? isOwner = null,}) {
  return _then(_self.copyWith(
nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,profileImageUrl: freezed == profileImageUrl ? _self.profileImageUrl : profileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,isOwner: null == isOwner ? _self.isOwner : isOwner // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ParticipantInfo].
extension ParticipantInfoPatterns on ParticipantInfo {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ParticipantInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ParticipantInfo() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ParticipantInfo value)  $default,){
final _that = this;
switch (_that) {
case _ParticipantInfo():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ParticipantInfo value)?  $default,){
final _that = this;
switch (_that) {
case _ParticipantInfo() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String nickname,  String? profileImageUrl,  bool isOwner)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ParticipantInfo() when $default != null:
return $default(_that.nickname,_that.profileImageUrl,_that.isOwner);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String nickname,  String? profileImageUrl,  bool isOwner)  $default,) {final _that = this;
switch (_that) {
case _ParticipantInfo():
return $default(_that.nickname,_that.profileImageUrl,_that.isOwner);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String nickname,  String? profileImageUrl,  bool isOwner)?  $default,) {final _that = this;
switch (_that) {
case _ParticipantInfo() when $default != null:
return $default(_that.nickname,_that.profileImageUrl,_that.isOwner);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ParticipantInfo implements ParticipantInfo {
  const _ParticipantInfo({required this.nickname, this.profileImageUrl, this.isOwner = false});
  factory _ParticipantInfo.fromJson(Map<String, dynamic> json) => _$ParticipantInfoFromJson(json);

@override final  String nickname;
@override final  String? profileImageUrl;
/// 이 방의 방장이면 `true`. [RoomMembersScreen] 이 "방장" 배지를 붙이는 데 쓴다.
@override@JsonKey() final  bool isOwner;

/// Create a copy of ParticipantInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParticipantInfoCopyWith<_ParticipantInfo> get copyWith => __$ParticipantInfoCopyWithImpl<_ParticipantInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ParticipantInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParticipantInfo&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.profileImageUrl, profileImageUrl) || other.profileImageUrl == profileImageUrl)&&(identical(other.isOwner, isOwner) || other.isOwner == isOwner));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,nickname,profileImageUrl,isOwner);

@override
String toString() {
  return 'ParticipantInfo(nickname: $nickname, profileImageUrl: $profileImageUrl, isOwner: $isOwner)';
}


}

/// @nodoc
abstract mixin class _$ParticipantInfoCopyWith<$Res> implements $ParticipantInfoCopyWith<$Res> {
  factory _$ParticipantInfoCopyWith(_ParticipantInfo value, $Res Function(_ParticipantInfo) _then) = __$ParticipantInfoCopyWithImpl;
@override @useResult
$Res call({
 String nickname, String? profileImageUrl, bool isOwner
});




}
/// @nodoc
class __$ParticipantInfoCopyWithImpl<$Res>
    implements _$ParticipantInfoCopyWith<$Res> {
  __$ParticipantInfoCopyWithImpl(this._self, this._then);

  final _ParticipantInfo _self;
  final $Res Function(_ParticipantInfo) _then;

/// Create a copy of ParticipantInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nickname = null,Object? profileImageUrl = freezed,Object? isOwner = null,}) {
  return _then(_ParticipantInfo(
nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,profileImageUrl: freezed == profileImageUrl ? _self.profileImageUrl : profileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,isOwner: null == isOwner ? _self.isOwner : isOwner // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$RoomDetail {

 int get id; String get title; List<String> get hashtags; bool get isPublic; List<ParticipantInfo> get members; int get memberCount; List<RoomChallenge> get challenges;/// 로그인한 유저가 이 방의 방장이면 `true` — 멤버 관리(내보내기 등) UI 노출 여부를 가른다.
 bool get isOwnedByMe;/// 방장이 발급한 초대 코드 — 아직 안 만들었으면 `null`. [RoomInviteScreen] 이 보여준다.
 String? get inviteCode;
/// Create a copy of RoomDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoomDetailCopyWith<RoomDetail> get copyWith => _$RoomDetailCopyWithImpl<RoomDetail>(this as RoomDetail, _$identity);

  /// Serializes this RoomDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoomDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.hashtags, hashtags)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic)&&const DeepCollectionEquality().equals(other.members, members)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&const DeepCollectionEquality().equals(other.challenges, challenges)&&(identical(other.isOwnedByMe, isOwnedByMe) || other.isOwnedByMe == isOwnedByMe)&&(identical(other.inviteCode, inviteCode) || other.inviteCode == inviteCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(hashtags),isPublic,const DeepCollectionEquality().hash(members),memberCount,const DeepCollectionEquality().hash(challenges),isOwnedByMe,inviteCode);

@override
String toString() {
  return 'RoomDetail(id: $id, title: $title, hashtags: $hashtags, isPublic: $isPublic, members: $members, memberCount: $memberCount, challenges: $challenges, isOwnedByMe: $isOwnedByMe, inviteCode: $inviteCode)';
}


}

/// @nodoc
abstract mixin class $RoomDetailCopyWith<$Res>  {
  factory $RoomDetailCopyWith(RoomDetail value, $Res Function(RoomDetail) _then) = _$RoomDetailCopyWithImpl;
@useResult
$Res call({
 int id, String title, List<String> hashtags, bool isPublic, List<ParticipantInfo> members, int memberCount, List<RoomChallenge> challenges, bool isOwnedByMe, String? inviteCode
});




}
/// @nodoc
class _$RoomDetailCopyWithImpl<$Res>
    implements $RoomDetailCopyWith<$Res> {
  _$RoomDetailCopyWithImpl(this._self, this._then);

  final RoomDetail _self;
  final $Res Function(RoomDetail) _then;

/// Create a copy of RoomDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? hashtags = null,Object? isPublic = null,Object? members = null,Object? memberCount = null,Object? challenges = null,Object? isOwnedByMe = null,Object? inviteCode = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,hashtags: null == hashtags ? _self.hashtags : hashtags // ignore: cast_nullable_to_non_nullable
as List<String>,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as List<ParticipantInfo>,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,challenges: null == challenges ? _self.challenges : challenges // ignore: cast_nullable_to_non_nullable
as List<RoomChallenge>,isOwnedByMe: null == isOwnedByMe ? _self.isOwnedByMe : isOwnedByMe // ignore: cast_nullable_to_non_nullable
as bool,inviteCode: freezed == inviteCode ? _self.inviteCode : inviteCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RoomDetail].
extension RoomDetailPatterns on RoomDetail {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoomDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoomDetail() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoomDetail value)  $default,){
final _that = this;
switch (_that) {
case _RoomDetail():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoomDetail value)?  $default,){
final _that = this;
switch (_that) {
case _RoomDetail() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  List<String> hashtags,  bool isPublic,  List<ParticipantInfo> members,  int memberCount,  List<RoomChallenge> challenges,  bool isOwnedByMe,  String? inviteCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoomDetail() when $default != null:
return $default(_that.id,_that.title,_that.hashtags,_that.isPublic,_that.members,_that.memberCount,_that.challenges,_that.isOwnedByMe,_that.inviteCode);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  List<String> hashtags,  bool isPublic,  List<ParticipantInfo> members,  int memberCount,  List<RoomChallenge> challenges,  bool isOwnedByMe,  String? inviteCode)  $default,) {final _that = this;
switch (_that) {
case _RoomDetail():
return $default(_that.id,_that.title,_that.hashtags,_that.isPublic,_that.members,_that.memberCount,_that.challenges,_that.isOwnedByMe,_that.inviteCode);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  List<String> hashtags,  bool isPublic,  List<ParticipantInfo> members,  int memberCount,  List<RoomChallenge> challenges,  bool isOwnedByMe,  String? inviteCode)?  $default,) {final _that = this;
switch (_that) {
case _RoomDetail() when $default != null:
return $default(_that.id,_that.title,_that.hashtags,_that.isPublic,_that.members,_that.memberCount,_that.challenges,_that.isOwnedByMe,_that.inviteCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RoomDetail implements RoomDetail {
  const _RoomDetail({required this.id, required this.title, final  List<String> hashtags = const <String>[], this.isPublic = true, final  List<ParticipantInfo> members = const <ParticipantInfo>[], required this.memberCount, final  List<RoomChallenge> challenges = const <RoomChallenge>[], this.isOwnedByMe = false, this.inviteCode}): _hashtags = hashtags,_members = members,_challenges = challenges;
  factory _RoomDetail.fromJson(Map<String, dynamic> json) => _$RoomDetailFromJson(json);

@override final  int id;
@override final  String title;
 final  List<String> _hashtags;
@override@JsonKey() List<String> get hashtags {
  if (_hashtags is EqualUnmodifiableListView) return _hashtags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hashtags);
}

@override@JsonKey() final  bool isPublic;
 final  List<ParticipantInfo> _members;
@override@JsonKey() List<ParticipantInfo> get members {
  if (_members is EqualUnmodifiableListView) return _members;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_members);
}

@override final  int memberCount;
 final  List<RoomChallenge> _challenges;
@override@JsonKey() List<RoomChallenge> get challenges {
  if (_challenges is EqualUnmodifiableListView) return _challenges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_challenges);
}

/// 로그인한 유저가 이 방의 방장이면 `true` — 멤버 관리(내보내기 등) UI 노출 여부를 가른다.
@override@JsonKey() final  bool isOwnedByMe;
/// 방장이 발급한 초대 코드 — 아직 안 만들었으면 `null`. [RoomInviteScreen] 이 보여준다.
@override final  String? inviteCode;

/// Create a copy of RoomDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoomDetailCopyWith<_RoomDetail> get copyWith => __$RoomDetailCopyWithImpl<_RoomDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoomDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoomDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._hashtags, _hashtags)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic)&&const DeepCollectionEquality().equals(other._members, _members)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&const DeepCollectionEquality().equals(other._challenges, _challenges)&&(identical(other.isOwnedByMe, isOwnedByMe) || other.isOwnedByMe == isOwnedByMe)&&(identical(other.inviteCode, inviteCode) || other.inviteCode == inviteCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(_hashtags),isPublic,const DeepCollectionEquality().hash(_members),memberCount,const DeepCollectionEquality().hash(_challenges),isOwnedByMe,inviteCode);

@override
String toString() {
  return 'RoomDetail(id: $id, title: $title, hashtags: $hashtags, isPublic: $isPublic, members: $members, memberCount: $memberCount, challenges: $challenges, isOwnedByMe: $isOwnedByMe, inviteCode: $inviteCode)';
}


}

/// @nodoc
abstract mixin class _$RoomDetailCopyWith<$Res> implements $RoomDetailCopyWith<$Res> {
  factory _$RoomDetailCopyWith(_RoomDetail value, $Res Function(_RoomDetail) _then) = __$RoomDetailCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, List<String> hashtags, bool isPublic, List<ParticipantInfo> members, int memberCount, List<RoomChallenge> challenges, bool isOwnedByMe, String? inviteCode
});




}
/// @nodoc
class __$RoomDetailCopyWithImpl<$Res>
    implements _$RoomDetailCopyWith<$Res> {
  __$RoomDetailCopyWithImpl(this._self, this._then);

  final _RoomDetail _self;
  final $Res Function(_RoomDetail) _then;

/// Create a copy of RoomDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? hashtags = null,Object? isPublic = null,Object? members = null,Object? memberCount = null,Object? challenges = null,Object? isOwnedByMe = null,Object? inviteCode = freezed,}) {
  return _then(_RoomDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,hashtags: null == hashtags ? _self._hashtags : hashtags // ignore: cast_nullable_to_non_nullable
as List<String>,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,members: null == members ? _self._members : members // ignore: cast_nullable_to_non_nullable
as List<ParticipantInfo>,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,challenges: null == challenges ? _self._challenges : challenges // ignore: cast_nullable_to_non_nullable
as List<RoomChallenge>,isOwnedByMe: null == isOwnedByMe ? _self.isOwnedByMe : isOwnedByMe // ignore: cast_nullable_to_non_nullable
as bool,inviteCode: freezed == inviteCode ? _self.inviteCode : inviteCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$RoomChallenge {

 int get id; String get title;/// "YouTube Shorts" 같은 출처 표기.
 String get source; int get submittedCount; int get totalCount; String? get thumbnailUrl;
/// Create a copy of RoomChallenge
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoomChallengeCopyWith<RoomChallenge> get copyWith => _$RoomChallengeCopyWithImpl<RoomChallenge>(this as RoomChallenge, _$identity);

  /// Serializes this RoomChallenge to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoomChallenge&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.source, source) || other.source == source)&&(identical(other.submittedCount, submittedCount) || other.submittedCount == submittedCount)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,source,submittedCount,totalCount,thumbnailUrl);

@override
String toString() {
  return 'RoomChallenge(id: $id, title: $title, source: $source, submittedCount: $submittedCount, totalCount: $totalCount, thumbnailUrl: $thumbnailUrl)';
}


}

/// @nodoc
abstract mixin class $RoomChallengeCopyWith<$Res>  {
  factory $RoomChallengeCopyWith(RoomChallenge value, $Res Function(RoomChallenge) _then) = _$RoomChallengeCopyWithImpl;
@useResult
$Res call({
 int id, String title, String source, int submittedCount, int totalCount, String? thumbnailUrl
});




}
/// @nodoc
class _$RoomChallengeCopyWithImpl<$Res>
    implements $RoomChallengeCopyWith<$Res> {
  _$RoomChallengeCopyWithImpl(this._self, this._then);

  final RoomChallenge _self;
  final $Res Function(RoomChallenge) _then;

/// Create a copy of RoomChallenge
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? source = null,Object? submittedCount = null,Object? totalCount = null,Object? thumbnailUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,submittedCount: null == submittedCount ? _self.submittedCount : submittedCount // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RoomChallenge].
extension RoomChallengePatterns on RoomChallenge {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoomChallenge value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoomChallenge() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoomChallenge value)  $default,){
final _that = this;
switch (_that) {
case _RoomChallenge():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoomChallenge value)?  $default,){
final _that = this;
switch (_that) {
case _RoomChallenge() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String source,  int submittedCount,  int totalCount,  String? thumbnailUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoomChallenge() when $default != null:
return $default(_that.id,_that.title,_that.source,_that.submittedCount,_that.totalCount,_that.thumbnailUrl);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String source,  int submittedCount,  int totalCount,  String? thumbnailUrl)  $default,) {final _that = this;
switch (_that) {
case _RoomChallenge():
return $default(_that.id,_that.title,_that.source,_that.submittedCount,_that.totalCount,_that.thumbnailUrl);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String source,  int submittedCount,  int totalCount,  String? thumbnailUrl)?  $default,) {final _that = this;
switch (_that) {
case _RoomChallenge() when $default != null:
return $default(_that.id,_that.title,_that.source,_that.submittedCount,_that.totalCount,_that.thumbnailUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RoomChallenge implements RoomChallenge {
  const _RoomChallenge({required this.id, required this.title, required this.source, required this.submittedCount, required this.totalCount, this.thumbnailUrl});
  factory _RoomChallenge.fromJson(Map<String, dynamic> json) => _$RoomChallengeFromJson(json);

@override final  int id;
@override final  String title;
/// "YouTube Shorts" 같은 출처 표기.
@override final  String source;
@override final  int submittedCount;
@override final  int totalCount;
@override final  String? thumbnailUrl;

/// Create a copy of RoomChallenge
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoomChallengeCopyWith<_RoomChallenge> get copyWith => __$RoomChallengeCopyWithImpl<_RoomChallenge>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoomChallengeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoomChallenge&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.source, source) || other.source == source)&&(identical(other.submittedCount, submittedCount) || other.submittedCount == submittedCount)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,source,submittedCount,totalCount,thumbnailUrl);

@override
String toString() {
  return 'RoomChallenge(id: $id, title: $title, source: $source, submittedCount: $submittedCount, totalCount: $totalCount, thumbnailUrl: $thumbnailUrl)';
}


}

/// @nodoc
abstract mixin class _$RoomChallengeCopyWith<$Res> implements $RoomChallengeCopyWith<$Res> {
  factory _$RoomChallengeCopyWith(_RoomChallenge value, $Res Function(_RoomChallenge) _then) = __$RoomChallengeCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String source, int submittedCount, int totalCount, String? thumbnailUrl
});




}
/// @nodoc
class __$RoomChallengeCopyWithImpl<$Res>
    implements _$RoomChallengeCopyWith<$Res> {
  __$RoomChallengeCopyWithImpl(this._self, this._then);

  final _RoomChallenge _self;
  final $Res Function(_RoomChallenge) _then;

/// Create a copy of RoomChallenge
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? source = null,Object? submittedCount = null,Object? totalCount = null,Object? thumbnailUrl = freezed,}) {
  return _then(_RoomChallenge(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,submittedCount: null == submittedCount ? _self.submittedCount : submittedCount // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ChallengeDetail {

 int get id; String get title;/// "YouTube Shorts" 같은 출처 표기.
 String get source;/// 방장이 처음 올린 원본(대표) 영상 — 있으면 재생할 수 있다.
 String? get videoUrl; String? get assetPath; int get totalCount; List<Submission> get submissions;/// 원본 영상에 달린 댓글 수. 제출 영상 각각의 댓글 수는 [Submission.commentCount] 를 본다.
 int get commentCount;
/// Create a copy of ChallengeDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChallengeDetailCopyWith<ChallengeDetail> get copyWith => _$ChallengeDetailCopyWithImpl<ChallengeDetail>(this as ChallengeDetail, _$identity);

  /// Serializes this ChallengeDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChallengeDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.source, source) || other.source == source)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&(identical(other.assetPath, assetPath) || other.assetPath == assetPath)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&const DeepCollectionEquality().equals(other.submissions, submissions)&&(identical(other.commentCount, commentCount) || other.commentCount == commentCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,source,videoUrl,assetPath,totalCount,const DeepCollectionEquality().hash(submissions),commentCount);

@override
String toString() {
  return 'ChallengeDetail(id: $id, title: $title, source: $source, videoUrl: $videoUrl, assetPath: $assetPath, totalCount: $totalCount, submissions: $submissions, commentCount: $commentCount)';
}


}

/// @nodoc
abstract mixin class $ChallengeDetailCopyWith<$Res>  {
  factory $ChallengeDetailCopyWith(ChallengeDetail value, $Res Function(ChallengeDetail) _then) = _$ChallengeDetailCopyWithImpl;
@useResult
$Res call({
 int id, String title, String source, String? videoUrl, String? assetPath, int totalCount, List<Submission> submissions, int commentCount
});




}
/// @nodoc
class _$ChallengeDetailCopyWithImpl<$Res>
    implements $ChallengeDetailCopyWith<$Res> {
  _$ChallengeDetailCopyWithImpl(this._self, this._then);

  final ChallengeDetail _self;
  final $Res Function(ChallengeDetail) _then;

/// Create a copy of ChallengeDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? source = null,Object? videoUrl = freezed,Object? assetPath = freezed,Object? totalCount = null,Object? submissions = null,Object? commentCount = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,videoUrl: freezed == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as String?,assetPath: freezed == assetPath ? _self.assetPath : assetPath // ignore: cast_nullable_to_non_nullable
as String?,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,submissions: null == submissions ? _self.submissions : submissions // ignore: cast_nullable_to_non_nullable
as List<Submission>,commentCount: null == commentCount ? _self.commentCount : commentCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ChallengeDetail].
extension ChallengeDetailPatterns on ChallengeDetail {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChallengeDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChallengeDetail() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChallengeDetail value)  $default,){
final _that = this;
switch (_that) {
case _ChallengeDetail():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChallengeDetail value)?  $default,){
final _that = this;
switch (_that) {
case _ChallengeDetail() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String source,  String? videoUrl,  String? assetPath,  int totalCount,  List<Submission> submissions,  int commentCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChallengeDetail() when $default != null:
return $default(_that.id,_that.title,_that.source,_that.videoUrl,_that.assetPath,_that.totalCount,_that.submissions,_that.commentCount);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String source,  String? videoUrl,  String? assetPath,  int totalCount,  List<Submission> submissions,  int commentCount)  $default,) {final _that = this;
switch (_that) {
case _ChallengeDetail():
return $default(_that.id,_that.title,_that.source,_that.videoUrl,_that.assetPath,_that.totalCount,_that.submissions,_that.commentCount);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String source,  String? videoUrl,  String? assetPath,  int totalCount,  List<Submission> submissions,  int commentCount)?  $default,) {final _that = this;
switch (_that) {
case _ChallengeDetail() when $default != null:
return $default(_that.id,_that.title,_that.source,_that.videoUrl,_that.assetPath,_that.totalCount,_that.submissions,_that.commentCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChallengeDetail implements ChallengeDetail {
  const _ChallengeDetail({required this.id, required this.title, required this.source, this.videoUrl, this.assetPath, required this.totalCount, final  List<Submission> submissions = const <Submission>[], this.commentCount = 0}): _submissions = submissions;
  factory _ChallengeDetail.fromJson(Map<String, dynamic> json) => _$ChallengeDetailFromJson(json);

@override final  int id;
@override final  String title;
/// "YouTube Shorts" 같은 출처 표기.
@override final  String source;
/// 방장이 처음 올린 원본(대표) 영상 — 있으면 재생할 수 있다.
@override final  String? videoUrl;
@override final  String? assetPath;
@override final  int totalCount;
 final  List<Submission> _submissions;
@override@JsonKey() List<Submission> get submissions {
  if (_submissions is EqualUnmodifiableListView) return _submissions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_submissions);
}

/// 원본 영상에 달린 댓글 수. 제출 영상 각각의 댓글 수는 [Submission.commentCount] 를 본다.
@override@JsonKey() final  int commentCount;

/// Create a copy of ChallengeDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChallengeDetailCopyWith<_ChallengeDetail> get copyWith => __$ChallengeDetailCopyWithImpl<_ChallengeDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChallengeDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChallengeDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.source, source) || other.source == source)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&(identical(other.assetPath, assetPath) || other.assetPath == assetPath)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&const DeepCollectionEquality().equals(other._submissions, _submissions)&&(identical(other.commentCount, commentCount) || other.commentCount == commentCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,source,videoUrl,assetPath,totalCount,const DeepCollectionEquality().hash(_submissions),commentCount);

@override
String toString() {
  return 'ChallengeDetail(id: $id, title: $title, source: $source, videoUrl: $videoUrl, assetPath: $assetPath, totalCount: $totalCount, submissions: $submissions, commentCount: $commentCount)';
}


}

/// @nodoc
abstract mixin class _$ChallengeDetailCopyWith<$Res> implements $ChallengeDetailCopyWith<$Res> {
  factory _$ChallengeDetailCopyWith(_ChallengeDetail value, $Res Function(_ChallengeDetail) _then) = __$ChallengeDetailCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String source, String? videoUrl, String? assetPath, int totalCount, List<Submission> submissions, int commentCount
});




}
/// @nodoc
class __$ChallengeDetailCopyWithImpl<$Res>
    implements _$ChallengeDetailCopyWith<$Res> {
  __$ChallengeDetailCopyWithImpl(this._self, this._then);

  final _ChallengeDetail _self;
  final $Res Function(_ChallengeDetail) _then;

/// Create a copy of ChallengeDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? source = null,Object? videoUrl = freezed,Object? assetPath = freezed,Object? totalCount = null,Object? submissions = null,Object? commentCount = null,}) {
  return _then(_ChallengeDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,videoUrl: freezed == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as String?,assetPath: freezed == assetPath ? _self.assetPath : assetPath // ignore: cast_nullable_to_non_nullable
as String?,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,submissions: null == submissions ? _self._submissions : submissions // ignore: cast_nullable_to_non_nullable
as List<Submission>,commentCount: null == commentCount ? _self.commentCount : commentCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
