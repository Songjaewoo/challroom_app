// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auths.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SocialLoginReq {

@JsonKey(name: 'token') String get accessToken;
/// Create a copy of SocialLoginReq
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialLoginReqCopyWith<SocialLoginReq> get copyWith => _$SocialLoginReqCopyWithImpl<SocialLoginReq>(this as SocialLoginReq, _$identity);

  /// Serializes this SocialLoginReq to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialLoginReq&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken);

@override
String toString() {
  return 'SocialLoginReq(accessToken: $accessToken)';
}


}

/// @nodoc
abstract mixin class $SocialLoginReqCopyWith<$Res>  {
  factory $SocialLoginReqCopyWith(SocialLoginReq value, $Res Function(SocialLoginReq) _then) = _$SocialLoginReqCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'token') String accessToken
});




}
/// @nodoc
class _$SocialLoginReqCopyWithImpl<$Res>
    implements $SocialLoginReqCopyWith<$Res> {
  _$SocialLoginReqCopyWithImpl(this._self, this._then);

  final SocialLoginReq _self;
  final $Res Function(SocialLoginReq) _then;

/// Create a copy of SocialLoginReq
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accessToken = null,}) {
  return _then(_self.copyWith(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SocialLoginReq].
extension SocialLoginReqPatterns on SocialLoginReq {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SocialLoginReq value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SocialLoginReq() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SocialLoginReq value)  $default,){
final _that = this;
switch (_that) {
case _SocialLoginReq():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SocialLoginReq value)?  $default,){
final _that = this;
switch (_that) {
case _SocialLoginReq() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'token')  String accessToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SocialLoginReq() when $default != null:
return $default(_that.accessToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'token')  String accessToken)  $default,) {final _that = this;
switch (_that) {
case _SocialLoginReq():
return $default(_that.accessToken);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'token')  String accessToken)?  $default,) {final _that = this;
switch (_that) {
case _SocialLoginReq() when $default != null:
return $default(_that.accessToken);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SocialLoginReq implements SocialLoginReq {
  const _SocialLoginReq({@JsonKey(name: 'token') required this.accessToken});
  factory _SocialLoginReq.fromJson(Map<String, dynamic> json) => _$SocialLoginReqFromJson(json);

@override@JsonKey(name: 'token') final  String accessToken;

/// Create a copy of SocialLoginReq
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialLoginReqCopyWith<_SocialLoginReq> get copyWith => __$SocialLoginReqCopyWithImpl<_SocialLoginReq>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SocialLoginReqToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialLoginReq&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken);

@override
String toString() {
  return 'SocialLoginReq(accessToken: $accessToken)';
}


}

/// @nodoc
abstract mixin class _$SocialLoginReqCopyWith<$Res> implements $SocialLoginReqCopyWith<$Res> {
  factory _$SocialLoginReqCopyWith(_SocialLoginReq value, $Res Function(_SocialLoginReq) _then) = __$SocialLoginReqCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'token') String accessToken
});




}
/// @nodoc
class __$SocialLoginReqCopyWithImpl<$Res>
    implements _$SocialLoginReqCopyWith<$Res> {
  __$SocialLoginReqCopyWithImpl(this._self, this._then);

  final _SocialLoginReq _self;
  final $Res Function(_SocialLoginReq) _then;

/// Create a copy of SocialLoginReq
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accessToken = null,}) {
  return _then(_SocialLoginReq(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$AuthResult {

 User get user; String get accessToken; String get refreshToken;/// 신규 가입이거나 닉네임을 아직 안 정한 유저면 `true` — 다만 라우터는 이 값 대신
/// `user.nickname` 이 비어 있는지로 온보딩 여부를 가른다(서버 재조회 때도 같은 기준을
/// 쓰려고). 응답 그대로 담아만 둔다.
 bool get isNewUser;
/// Create a copy of AuthResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthResultCopyWith<AuthResult> get copyWith => _$AuthResultCopyWithImpl<AuthResult>(this as AuthResult, _$identity);

  /// Serializes this AuthResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthResult&&(identical(other.user, user) || other.user == user)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.isNewUser, isNewUser) || other.isNewUser == isNewUser));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,accessToken,refreshToken,isNewUser);

@override
String toString() {
  return 'AuthResult(user: $user, accessToken: $accessToken, refreshToken: $refreshToken, isNewUser: $isNewUser)';
}


}

/// @nodoc
abstract mixin class $AuthResultCopyWith<$Res>  {
  factory $AuthResultCopyWith(AuthResult value, $Res Function(AuthResult) _then) = _$AuthResultCopyWithImpl;
@useResult
$Res call({
 User user, String accessToken, String refreshToken, bool isNewUser
});


$UserCopyWith<$Res> get user;

}
/// @nodoc
class _$AuthResultCopyWithImpl<$Res>
    implements $AuthResultCopyWith<$Res> {
  _$AuthResultCopyWithImpl(this._self, this._then);

  final AuthResult _self;
  final $Res Function(AuthResult) _then;

/// Create a copy of AuthResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = null,Object? accessToken = null,Object? refreshToken = null,Object? isNewUser = null,}) {
  return _then(_self.copyWith(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User,accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,isNewUser: null == isNewUser ? _self.isNewUser : isNewUser // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of AuthResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get user {
  
  return $UserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [AuthResult].
extension AuthResultPatterns on AuthResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthResult value)  $default,){
final _that = this;
switch (_that) {
case _AuthResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthResult value)?  $default,){
final _that = this;
switch (_that) {
case _AuthResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( User user,  String accessToken,  String refreshToken,  bool isNewUser)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthResult() when $default != null:
return $default(_that.user,_that.accessToken,_that.refreshToken,_that.isNewUser);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( User user,  String accessToken,  String refreshToken,  bool isNewUser)  $default,) {final _that = this;
switch (_that) {
case _AuthResult():
return $default(_that.user,_that.accessToken,_that.refreshToken,_that.isNewUser);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( User user,  String accessToken,  String refreshToken,  bool isNewUser)?  $default,) {final _that = this;
switch (_that) {
case _AuthResult() when $default != null:
return $default(_that.user,_that.accessToken,_that.refreshToken,_that.isNewUser);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthResult implements AuthResult {
  const _AuthResult({required this.user, required this.accessToken, required this.refreshToken, this.isNewUser = false});
  factory _AuthResult.fromJson(Map<String, dynamic> json) => _$AuthResultFromJson(json);

@override final  User user;
@override final  String accessToken;
@override final  String refreshToken;
/// 신규 가입이거나 닉네임을 아직 안 정한 유저면 `true` — 다만 라우터는 이 값 대신
/// `user.nickname` 이 비어 있는지로 온보딩 여부를 가른다(서버 재조회 때도 같은 기준을
/// 쓰려고). 응답 그대로 담아만 둔다.
@override@JsonKey() final  bool isNewUser;

/// Create a copy of AuthResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthResultCopyWith<_AuthResult> get copyWith => __$AuthResultCopyWithImpl<_AuthResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthResult&&(identical(other.user, user) || other.user == user)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.isNewUser, isNewUser) || other.isNewUser == isNewUser));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,accessToken,refreshToken,isNewUser);

@override
String toString() {
  return 'AuthResult(user: $user, accessToken: $accessToken, refreshToken: $refreshToken, isNewUser: $isNewUser)';
}


}

/// @nodoc
abstract mixin class _$AuthResultCopyWith<$Res> implements $AuthResultCopyWith<$Res> {
  factory _$AuthResultCopyWith(_AuthResult value, $Res Function(_AuthResult) _then) = __$AuthResultCopyWithImpl;
@override @useResult
$Res call({
 User user, String accessToken, String refreshToken, bool isNewUser
});


@override $UserCopyWith<$Res> get user;

}
/// @nodoc
class __$AuthResultCopyWithImpl<$Res>
    implements _$AuthResultCopyWith<$Res> {
  __$AuthResultCopyWithImpl(this._self, this._then);

  final _AuthResult _self;
  final $Res Function(_AuthResult) _then;

/// Create a copy of AuthResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = null,Object? accessToken = null,Object? refreshToken = null,Object? isNewUser = null,}) {
  return _then(_AuthResult(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User,accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,isNewUser: null == isNewUser ? _self.isNewUser : isNewUser // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of AuthResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get user {
  
  return $UserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on
