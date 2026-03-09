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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( WheelIdle value)?  idle,TResult Function( WheelSpinning value)?  spinning,TResult Function( WheelStopped value)?  stopped,required TResult orElse(),}){
final _that = this;
switch (_that) {
case WheelIdle() when idle != null:
return idle(_that);case WheelSpinning() when spinning != null:
return spinning(_that);case WheelStopped() when stopped != null:
return stopped(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( WheelIdle value)  idle,required TResult Function( WheelSpinning value)  spinning,required TResult Function( WheelStopped value)  stopped,}){
final _that = this;
switch (_that) {
case WheelIdle():
return idle(_that);case WheelSpinning():
return spinning(_that);case WheelStopped():
return stopped(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( WheelIdle value)?  idle,TResult? Function( WheelSpinning value)?  spinning,TResult? Function( WheelStopped value)?  stopped,}){
final _that = this;
switch (_that) {
case WheelIdle() when idle != null:
return idle(_that);case WheelSpinning() when spinning != null:
return spinning(_that);case WheelStopped() when stopped != null:
return stopped(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function( double targetDegrees)?  spinning,TResult Function( double targetDegrees)?  stopped,required TResult orElse(),}) {final _that = this;
switch (_that) {
case WheelIdle() when idle != null:
return idle();case WheelSpinning() when spinning != null:
return spinning(_that.targetDegrees);case WheelStopped() when stopped != null:
return stopped(_that.targetDegrees);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function( double targetDegrees)  spinning,required TResult Function( double targetDegrees)  stopped,}) {final _that = this;
switch (_that) {
case WheelIdle():
return idle();case WheelSpinning():
return spinning(_that.targetDegrees);case WheelStopped():
return stopped(_that.targetDegrees);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function( double targetDegrees)?  spinning,TResult? Function( double targetDegrees)?  stopped,}) {final _that = this;
switch (_that) {
case WheelIdle() when idle != null:
return idle();case WheelSpinning() when spinning != null:
return spinning(_that.targetDegrees);case WheelStopped() when stopped != null:
return stopped(_that.targetDegrees);case _:
  return null;

}
}

}

/// @nodoc


class WheelIdle implements WheelState {
  const WheelIdle();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WheelIdle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WheelState.idle()';
}


}




/// @nodoc


class WheelSpinning implements WheelState {
  const WheelSpinning({required this.targetDegrees});
  

 final  double targetDegrees;

/// Create a copy of WheelState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WheelSpinningCopyWith<WheelSpinning> get copyWith => _$WheelSpinningCopyWithImpl<WheelSpinning>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WheelSpinning&&(identical(other.targetDegrees, targetDegrees) || other.targetDegrees == targetDegrees));
}


@override
int get hashCode => Object.hash(runtimeType,targetDegrees);

@override
String toString() {
  return 'WheelState.spinning(targetDegrees: $targetDegrees)';
}


}

/// @nodoc
abstract mixin class $WheelSpinningCopyWith<$Res> implements $WheelStateCopyWith<$Res> {
  factory $WheelSpinningCopyWith(WheelSpinning value, $Res Function(WheelSpinning) _then) = _$WheelSpinningCopyWithImpl;
@useResult
$Res call({
 double targetDegrees
});




}
/// @nodoc
class _$WheelSpinningCopyWithImpl<$Res>
    implements $WheelSpinningCopyWith<$Res> {
  _$WheelSpinningCopyWithImpl(this._self, this._then);

  final WheelSpinning _self;
  final $Res Function(WheelSpinning) _then;

/// Create a copy of WheelState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? targetDegrees = null,}) {
  return _then(WheelSpinning(
targetDegrees: null == targetDegrees ? _self.targetDegrees : targetDegrees // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc


class WheelStopped implements WheelState {
  const WheelStopped({required this.targetDegrees});
  

 final  double targetDegrees;

/// Create a copy of WheelState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WheelStoppedCopyWith<WheelStopped> get copyWith => _$WheelStoppedCopyWithImpl<WheelStopped>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WheelStopped&&(identical(other.targetDegrees, targetDegrees) || other.targetDegrees == targetDegrees));
}


@override
int get hashCode => Object.hash(runtimeType,targetDegrees);

@override
String toString() {
  return 'WheelState.stopped(targetDegrees: $targetDegrees)';
}


}

/// @nodoc
abstract mixin class $WheelStoppedCopyWith<$Res> implements $WheelStateCopyWith<$Res> {
  factory $WheelStoppedCopyWith(WheelStopped value, $Res Function(WheelStopped) _then) = _$WheelStoppedCopyWithImpl;
@useResult
$Res call({
 double targetDegrees
});




}
/// @nodoc
class _$WheelStoppedCopyWithImpl<$Res>
    implements $WheelStoppedCopyWith<$Res> {
  _$WheelStoppedCopyWithImpl(this._self, this._then);

  final WheelStopped _self;
  final $Res Function(WheelStopped) _then;

/// Create a copy of WheelState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? targetDegrees = null,}) {
  return _then(WheelStopped(
targetDegrees: null == targetDegrees ? _self.targetDegrees : targetDegrees // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
