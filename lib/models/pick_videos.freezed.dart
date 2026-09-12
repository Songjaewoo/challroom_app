// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pick_videos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PickVideo {

 int get id; String get title;/// "YouTube Shorts", "직접 업로드" 같은 출처 표기.
 String get source; String? get videoUrl; String? get assetPath; String? get thumbnailUrl;
/// Create a copy of PickVideo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PickVideoCopyWith<PickVideo> get copyWith => _$PickVideoCopyWithImpl<PickVideo>(this as PickVideo, _$identity);

  /// Serializes this PickVideo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PickVideo&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.source, source) || other.source == source)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&(identical(other.assetPath, assetPath) || other.assetPath == assetPath)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,source,videoUrl,assetPath,thumbnailUrl);

@override
String toString() {
  return 'PickVideo(id: $id, title: $title, source: $source, videoUrl: $videoUrl, assetPath: $assetPath, thumbnailUrl: $thumbnailUrl)';
}


}

/// @nodoc
abstract mixin class $PickVideoCopyWith<$Res>  {
  factory $PickVideoCopyWith(PickVideo value, $Res Function(PickVideo) _then) = _$PickVideoCopyWithImpl;
@useResult
$Res call({
 int id, String title, String source, String? videoUrl, String? assetPath, String? thumbnailUrl
});




}
/// @nodoc
class _$PickVideoCopyWithImpl<$Res>
    implements $PickVideoCopyWith<$Res> {
  _$PickVideoCopyWithImpl(this._self, this._then);

  final PickVideo _self;
  final $Res Function(PickVideo) _then;

/// Create a copy of PickVideo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? source = null,Object? videoUrl = freezed,Object? assetPath = freezed,Object? thumbnailUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,videoUrl: freezed == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as String?,assetPath: freezed == assetPath ? _self.assetPath : assetPath // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PickVideo].
extension PickVideoPatterns on PickVideo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PickVideo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PickVideo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PickVideo value)  $default,){
final _that = this;
switch (_that) {
case _PickVideo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PickVideo value)?  $default,){
final _that = this;
switch (_that) {
case _PickVideo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String source,  String? videoUrl,  String? assetPath,  String? thumbnailUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PickVideo() when $default != null:
return $default(_that.id,_that.title,_that.source,_that.videoUrl,_that.assetPath,_that.thumbnailUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String source,  String? videoUrl,  String? assetPath,  String? thumbnailUrl)  $default,) {final _that = this;
switch (_that) {
case _PickVideo():
return $default(_that.id,_that.title,_that.source,_that.videoUrl,_that.assetPath,_that.thumbnailUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String source,  String? videoUrl,  String? assetPath,  String? thumbnailUrl)?  $default,) {final _that = this;
switch (_that) {
case _PickVideo() when $default != null:
return $default(_that.id,_that.title,_that.source,_that.videoUrl,_that.assetPath,_that.thumbnailUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PickVideo implements PickVideo {
  const _PickVideo({required this.id, required this.title, required this.source, this.videoUrl, this.assetPath, this.thumbnailUrl});
  factory _PickVideo.fromJson(Map<String, dynamic> json) => _$PickVideoFromJson(json);

@override final  int id;
@override final  String title;
/// "YouTube Shorts", "직접 업로드" 같은 출처 표기.
@override final  String source;
@override final  String? videoUrl;
@override final  String? assetPath;
@override final  String? thumbnailUrl;

/// Create a copy of PickVideo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PickVideoCopyWith<_PickVideo> get copyWith => __$PickVideoCopyWithImpl<_PickVideo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PickVideoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PickVideo&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.source, source) || other.source == source)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&(identical(other.assetPath, assetPath) || other.assetPath == assetPath)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,source,videoUrl,assetPath,thumbnailUrl);

@override
String toString() {
  return 'PickVideo(id: $id, title: $title, source: $source, videoUrl: $videoUrl, assetPath: $assetPath, thumbnailUrl: $thumbnailUrl)';
}


}

/// @nodoc
abstract mixin class _$PickVideoCopyWith<$Res> implements $PickVideoCopyWith<$Res> {
  factory _$PickVideoCopyWith(_PickVideo value, $Res Function(_PickVideo) _then) = __$PickVideoCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String source, String? videoUrl, String? assetPath, String? thumbnailUrl
});




}
/// @nodoc
class __$PickVideoCopyWithImpl<$Res>
    implements _$PickVideoCopyWith<$Res> {
  __$PickVideoCopyWithImpl(this._self, this._then);

  final _PickVideo _self;
  final $Res Function(_PickVideo) _then;

/// Create a copy of PickVideo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? source = null,Object? videoUrl = freezed,Object? assetPath = freezed,Object? thumbnailUrl = freezed,}) {
  return _then(_PickVideo(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,videoUrl: freezed == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as String?,assetPath: freezed == assetPath ? _self.assetPath : assetPath // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
