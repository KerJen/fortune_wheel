// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WheelState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WheelState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WheelState()';
}


}

/// @nodoc
class $WheelStateCopyWith<$Res>  {
$WheelStateCopyWith(WheelState _, $Res Function(WheelState) __);
}


/// Adds pattern-matching-related methods to [WheelState].
extension WheelStatePatterns on WheelState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( WheelIdle value)?  idle,TResult Function( WheelSpinning value)?  spinning,TResult Function( WheelLanding value)?  landing,TResult Function( WheelStopped value)?  stopped,TResult Function( WheelFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case WheelIdle() when idle != null:
return idle(_that);case WheelSpinning() when spinning != null:
return spinning(_that);case WheelLanding() when landing != null:
return landing(_that);case WheelStopped() when stopped != null:
return stopped(_that);case WheelFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( WheelIdle value)  idle,required TResult Function( WheelSpinning value)  spinning,required TResult Function( WheelLanding value)  landing,required TResult Function( WheelStopped value)  stopped,required TResult Function( WheelFailure value)  failure,}){
final _that = this;
switch (_that) {
case WheelIdle():
return idle(_that);case WheelSpinning():
return spinning(_that);case WheelLanding():
return landing(_that);case WheelStopped():
return stopped(_that);case WheelFailure():
return failure(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( WheelIdle value)?  idle,TResult? Function( WheelSpinning value)?  spinning,TResult? Function( WheelLanding value)?  landing,TResult? Function( WheelStopped value)?  stopped,TResult? Function( WheelFailure value)?  failure,}){
final _that = this;
switch (_that) {
case WheelIdle() when idle != null:
return idle(_that);case WheelSpinning() when spinning != null:
return spinning(_that);case WheelLanding() when landing != null:
return landing(_that);case WheelStopped() when stopped != null:
return stopped(_that);case WheelFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( double? savedDegrees)?  idle,TResult Function()?  spinning,TResult Function( Gift targetGift)?  landing,TResult Function( Gift wonGift)?  stopped,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case WheelIdle() when idle != null:
return idle(_that.savedDegrees);case WheelSpinning() when spinning != null:
return spinning();case WheelLanding() when landing != null:
return landing(_that.targetGift);case WheelStopped() when stopped != null:
return stopped(_that.wonGift);case WheelFailure() when failure != null:
return failure(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( double? savedDegrees)  idle,required TResult Function()  spinning,required TResult Function( Gift targetGift)  landing,required TResult Function( Gift wonGift)  stopped,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case WheelIdle():
return idle(_that.savedDegrees);case WheelSpinning():
return spinning();case WheelLanding():
return landing(_that.targetGift);case WheelStopped():
return stopped(_that.wonGift);case WheelFailure():
return failure(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( double? savedDegrees)?  idle,TResult? Function()?  spinning,TResult? Function( Gift targetGift)?  landing,TResult? Function( Gift wonGift)?  stopped,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case WheelIdle() when idle != null:
return idle(_that.savedDegrees);case WheelSpinning() when spinning != null:
return spinning();case WheelLanding() when landing != null:
return landing(_that.targetGift);case WheelStopped() when stopped != null:
return stopped(_that.wonGift);case WheelFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class WheelIdle implements WheelState {
  const WheelIdle({this.savedDegrees});
  

 final  double? savedDegrees;

/// Create a copy of WheelState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WheelIdleCopyWith<WheelIdle> get copyWith => _$WheelIdleCopyWithImpl<WheelIdle>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WheelIdle&&(identical(other.savedDegrees, savedDegrees) || other.savedDegrees == savedDegrees));
}


@override
int get hashCode => Object.hash(runtimeType,savedDegrees);

@override
String toString() {
  return 'WheelState.idle(savedDegrees: $savedDegrees)';
}


}

/// @nodoc
abstract mixin class $WheelIdleCopyWith<$Res> implements $WheelStateCopyWith<$Res> {
  factory $WheelIdleCopyWith(WheelIdle value, $Res Function(WheelIdle) _then) = _$WheelIdleCopyWithImpl;
@useResult
$Res call({
 double? savedDegrees
});




}
/// @nodoc
class _$WheelIdleCopyWithImpl<$Res>
    implements $WheelIdleCopyWith<$Res> {
  _$WheelIdleCopyWithImpl(this._self, this._then);

  final WheelIdle _self;
  final $Res Function(WheelIdle) _then;

/// Create a copy of WheelState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? savedDegrees = freezed,}) {
  return _then(WheelIdle(
savedDegrees: freezed == savedDegrees ? _self.savedDegrees : savedDegrees // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

/// @nodoc


class WheelSpinning implements WheelState {
  const WheelSpinning();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WheelSpinning);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WheelState.spinning()';
}


}




/// @nodoc


class WheelLanding implements WheelState {
  const WheelLanding({required this.targetGift});
  

 final  Gift targetGift;

/// Create a copy of WheelState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WheelLandingCopyWith<WheelLanding> get copyWith => _$WheelLandingCopyWithImpl<WheelLanding>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WheelLanding&&(identical(other.targetGift, targetGift) || other.targetGift == targetGift));
}


@override
int get hashCode => Object.hash(runtimeType,targetGift);

@override
String toString() {
  return 'WheelState.landing(targetGift: $targetGift)';
}


}

/// @nodoc
abstract mixin class $WheelLandingCopyWith<$Res> implements $WheelStateCopyWith<$Res> {
  factory $WheelLandingCopyWith(WheelLanding value, $Res Function(WheelLanding) _then) = _$WheelLandingCopyWithImpl;
@useResult
$Res call({
 Gift targetGift
});


$GiftCopyWith<$Res> get targetGift;

}
/// @nodoc
class _$WheelLandingCopyWithImpl<$Res>
    implements $WheelLandingCopyWith<$Res> {
  _$WheelLandingCopyWithImpl(this._self, this._then);

  final WheelLanding _self;
  final $Res Function(WheelLanding) _then;

/// Create a copy of WheelState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? targetGift = null,}) {
  return _then(WheelLanding(
targetGift: null == targetGift ? _self.targetGift : targetGift // ignore: cast_nullable_to_non_nullable
as Gift,
  ));
}

/// Create a copy of WheelState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GiftCopyWith<$Res> get targetGift {
  
  return $GiftCopyWith<$Res>(_self.targetGift, (value) {
    return _then(_self.copyWith(targetGift: value));
  });
}
}

/// @nodoc


class WheelStopped implements WheelState {
  const WheelStopped({required this.wonGift});
  

 final  Gift wonGift;

/// Create a copy of WheelState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WheelStoppedCopyWith<WheelStopped> get copyWith => _$WheelStoppedCopyWithImpl<WheelStopped>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WheelStopped&&(identical(other.wonGift, wonGift) || other.wonGift == wonGift));
}


@override
int get hashCode => Object.hash(runtimeType,wonGift);

@override
String toString() {
  return 'WheelState.stopped(wonGift: $wonGift)';
}


}

/// @nodoc
abstract mixin class $WheelStoppedCopyWith<$Res> implements $WheelStateCopyWith<$Res> {
  factory $WheelStoppedCopyWith(WheelStopped value, $Res Function(WheelStopped) _then) = _$WheelStoppedCopyWithImpl;
@useResult
$Res call({
 Gift wonGift
});


$GiftCopyWith<$Res> get wonGift;

}
/// @nodoc
class _$WheelStoppedCopyWithImpl<$Res>
    implements $WheelStoppedCopyWith<$Res> {
  _$WheelStoppedCopyWithImpl(this._self, this._then);

  final WheelStopped _self;
  final $Res Function(WheelStopped) _then;

/// Create a copy of WheelState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? wonGift = null,}) {
  return _then(WheelStopped(
wonGift: null == wonGift ? _self.wonGift : wonGift // ignore: cast_nullable_to_non_nullable
as Gift,
  ));
}

/// Create a copy of WheelState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GiftCopyWith<$Res> get wonGift {
  
  return $GiftCopyWith<$Res>(_self.wonGift, (value) {
    return _then(_self.copyWith(wonGift: value));
  });
}
}

/// @nodoc


class WheelFailure implements WheelState {
  const WheelFailure({required this.message});
  

 final  String message;

/// Create a copy of WheelState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WheelFailureCopyWith<WheelFailure> get copyWith => _$WheelFailureCopyWithImpl<WheelFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WheelFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'WheelState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $WheelFailureCopyWith<$Res> implements $WheelStateCopyWith<$Res> {
  factory $WheelFailureCopyWith(WheelFailure value, $Res Function(WheelFailure) _then) = _$WheelFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$WheelFailureCopyWithImpl<$Res>
    implements $WheelFailureCopyWith<$Res> {
  _$WheelFailureCopyWithImpl(this._self, this._then);

  final WheelFailure _self;
  final $Res Function(WheelFailure) _then;

/// Create a copy of WheelState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(WheelFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
