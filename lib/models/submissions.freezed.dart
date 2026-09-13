// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'submissions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Submission {

 int get id; String get nickname; String? get videoUrl; String? get assetPath; String? get thumbnailUrl; int get commentCount; int get likeCount;/// 로그인한 유저가 이 영상에 좋아요를 눌러놨으면 `true` — 하트를 채워서 보여준다.
 bool get isLikedByMe;
/// Create a copy of Submission
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubmissionCopyWith<Submission> get copyWith => _$SubmissionCopyWithImpl<Submission>(this as Submission, _$identity);

  /// Serializes this Submission to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Submission&&(identical(other.id, id) || other.id == id)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&(identical(other.assetPath, assetPath) || other.assetPath == assetPath)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.commentCount, commentCount) || other.commentCount == commentCount)&&(identical(other.likeCount, likeCount) || other.likeCount == likeCount)&&(identical(other.isLikedByMe, isLikedByMe) || other.isLikedByMe == isLikedByMe));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nickname,videoUrl,assetPath,thumbnailUrl,commentCount,likeCount,isLikedByMe);

@override
String toString() {
  return 'Submission(id: $id, nickname: $nickname, videoUrl: $videoUrl, assetPath: $assetPath, thumbnailUrl: $thumbnailUrl, commentCount: $commentCount, likeCount: $likeCount, isLikedByMe: $isLikedByMe)';
}


}

/// @nodoc
abstract mixin class $SubmissionCopyWith<$Res>  {
  factory $SubmissionCopyWith(Submission value, $Res Function(Submission) _then) = _$SubmissionCopyWithImpl;
@useResult
$Res call({
 int id, String nickname, String? videoUrl, String? assetPath, String? thumbnailUrl, int commentCount, int likeCount, bool isLikedByMe
});




}
/// @nodoc
class _$SubmissionCopyWithImpl<$Res>
    implements $SubmissionCopyWith<$Res> {
  _$SubmissionCopyWithImpl(this._self, this._then);

  final Submission _self;
  final $Res Function(Submission) _then;

/// Create a copy of Submission
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nickname = null,Object? videoUrl = freezed,Object? assetPath = freezed,Object? thumbnailUrl = freezed,Object? commentCount = null,Object? likeCount = null,Object? isLikedByMe = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,videoUrl: freezed == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as String?,assetPath: freezed == assetPath ? _self.assetPath : assetPath // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,commentCount: null == commentCount ? _self.commentCount : commentCount // ignore: cast_nullable_to_non_nullable
as int,likeCount: null == likeCount ? _self.likeCount : likeCount // ignore: cast_nullable_to_non_nullable
as int,isLikedByMe: null == isLikedByMe ? _self.isLikedByMe : isLikedByMe // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Submission].
extension SubmissionPatterns on Submission {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Submission value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Submission() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Submission value)  $default,){
final _that = this;
switch (_that) {
case _Submission():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Submission value)?  $default,){
final _that = this;
switch (_that) {
case _Submission() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String nickname,  String? videoUrl,  String? assetPath,  String? thumbnailUrl,  int commentCount,  int likeCount,  bool isLikedByMe)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Submission() when $default != null:
return $default(_that.id,_that.nickname,_that.videoUrl,_that.assetPath,_that.thumbnailUrl,_that.commentCount,_that.likeCount,_that.isLikedByMe);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String nickname,  String? videoUrl,  String? assetPath,  String? thumbnailUrl,  int commentCount,  int likeCount,  bool isLikedByMe)  $default,) {final _that = this;
switch (_that) {
case _Submission():
return $default(_that.id,_that.nickname,_that.videoUrl,_that.assetPath,_that.thumbnailUrl,_that.commentCount,_that.likeCount,_that.isLikedByMe);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String nickname,  String? videoUrl,  String? assetPath,  String? thumbnailUrl,  int commentCount,  int likeCount,  bool isLikedByMe)?  $default,) {final _that = this;
switch (_that) {
case _Submission() when $default != null:
return $default(_that.id,_that.nickname,_that.videoUrl,_that.assetPath,_that.thumbnailUrl,_that.commentCount,_that.likeCount,_that.isLikedByMe);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Submission implements Submission {
  const _Submission({required this.id, required this.nickname, this.videoUrl, this.assetPath, this.thumbnailUrl, this.commentCount = 0, this.likeCount = 0, this.isLikedByMe = false});
  factory _Submission.fromJson(Map<String, dynamic> json) => _$SubmissionFromJson(json);

@override final  int id;
@override final  String nickname;
@override final  String? videoUrl;
@override final  String? assetPath;
@override final  String? thumbnailUrl;
@override@JsonKey() final  int commentCount;
@override@JsonKey() final  int likeCount;
/// 로그인한 유저가 이 영상에 좋아요를 눌러놨으면 `true` — 하트를 채워서 보여준다.
@override@JsonKey() final  bool isLikedByMe;

/// Create a copy of Submission
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubmissionCopyWith<_Submission> get copyWith => __$SubmissionCopyWithImpl<_Submission>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubmissionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Submission&&(identical(other.id, id) || other.id == id)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&(identical(other.assetPath, assetPath) || other.assetPath == assetPath)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.commentCount, commentCount) || other.commentCount == commentCount)&&(identical(other.likeCount, likeCount) || other.likeCount == likeCount)&&(identical(other.isLikedByMe, isLikedByMe) || other.isLikedByMe == isLikedByMe));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nickname,videoUrl,assetPath,thumbnailUrl,commentCount,likeCount,isLikedByMe);

@override
String toString() {
  return 'Submission(id: $id, nickname: $nickname, videoUrl: $videoUrl, assetPath: $assetPath, thumbnailUrl: $thumbnailUrl, commentCount: $commentCount, likeCount: $likeCount, isLikedByMe: $isLikedByMe)';
}


}

/// @nodoc
abstract mixin class _$SubmissionCopyWith<$Res> implements $SubmissionCopyWith<$Res> {
  factory _$SubmissionCopyWith(_Submission value, $Res Function(_Submission) _then) = __$SubmissionCopyWithImpl;
@override @useResult
$Res call({
 int id, String nickname, String? videoUrl, String? assetPath, String? thumbnailUrl, int commentCount, int likeCount, bool isLikedByMe
});




}
/// @nodoc
class __$SubmissionCopyWithImpl<$Res>
    implements _$SubmissionCopyWith<$Res> {
  __$SubmissionCopyWithImpl(this._self, this._then);

  final _Submission _self;
  final $Res Function(_Submission) _then;

/// Create a copy of Submission
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nickname = null,Object? videoUrl = freezed,Object? assetPath = freezed,Object? thumbnailUrl = freezed,Object? commentCount = null,Object? likeCount = null,Object? isLikedByMe = null,}) {
  return _then(_Submission(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,videoUrl: freezed == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as String?,assetPath: freezed == assetPath ? _self.assetPath : assetPath // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,commentCount: null == commentCount ? _self.commentCount : commentCount // ignore: cast_nullable_to_non_nullable
as int,likeCount: null == likeCount ? _self.likeCount : likeCount // ignore: cast_nullable_to_non_nullable
as int,isLikedByMe: null == isLikedByMe ? _self.isLikedByMe : isLikedByMe // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
