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

 int get balance;
/// Create a copy of WheelState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WheelStateCopyWith<WheelState> get copyWith => _$WheelStateCopyWithImpl<WheelState>(this as WheelState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WheelState&&(identical(other.balance, balance) || other.balance == balance));
}


@override
int get hashCode => Object.hash(runtimeType,balance);

@override
String toString() {
  return 'WheelState(balance: $balance)';
}


}

/// @nodoc
abstract mixin class $WheelStateCopyWith<$Res>  {
  factory $WheelStateCopyWith(WheelState value, $Res Function(WheelState) _then) = _$WheelStateCopyWithImpl;
@useResult
$Res call({
 int balance
});




}
/// @nodoc
class _$WheelStateCopyWithImpl<$Res>
    implements $WheelStateCopyWith<$Res> {
  _$WheelStateCopyWithImpl(this._self, this._then);

  final WheelState _self;
  final $Res Function(WheelState) _then;

/// Create a copy of WheelState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? balance = null,}) {
  return _then(_self.copyWith(
balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( WheelIdle value)?  idle,TResult Function( WheelSpinning value)?  spinning,TResult Function( WheelLanding value)?  landing,TResult Function( WheelStopped value)?  stopped,required TResult orElse(),}){
final _that = this;
switch (_that) {
case WheelIdle() when idle != null:
return idle(_that);case WheelSpinning() when spinning != null:
return spinning(_that);case WheelLanding() when landing != null:
return landing(_that);case WheelStopped() when stopped != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( WheelIdle value)  idle,required TResult Function( WheelSpinning value)  spinning,required TResult Function( WheelLanding value)  landing,required TResult Function( WheelStopped value)  stopped,}){
final _that = this;
switch (_that) {
case WheelIdle():
return idle(_that);case WheelSpinning():
return spinning(_that);case WheelLanding():
return landing(_that);case WheelStopped():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( WheelIdle value)?  idle,TResult? Function( WheelSpinning value)?  spinning,TResult? Function( WheelLanding value)?  landing,TResult? Function( WheelStopped value)?  stopped,}){
final _that = this;
switch (_that) {
case WheelIdle() when idle != null:
return idle(_that);case WheelSpinning() when spinning != null:
return spinning(_that);case WheelLanding() when landing != null:
return landing(_that);case WheelStopped() when stopped != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int balance,  double? savedDegrees)?  idle,TResult Function( int balance)?  spinning,TResult Function( int balance,  Gift targetGift)?  landing,TResult Function( int balance,  Gift wonGift)?  stopped,required TResult orElse(),}) {final _that = this;
switch (_that) {
case WheelIdle() when idle != null:
return idle(_that.balance,_that.savedDegrees);case WheelSpinning() when spinning != null:
return spinning(_that.balance);case WheelLanding() when landing != null:
return landing(_that.balance,_that.targetGift);case WheelStopped() when stopped != null:
return stopped(_that.balance,_that.wonGift);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int balance,  double? savedDegrees)  idle,required TResult Function( int balance)  spinning,required TResult Function( int balance,  Gift targetGift)  landing,required TResult Function( int balance,  Gift wonGift)  stopped,}) {final _that = this;
switch (_that) {
case WheelIdle():
return idle(_that.balance,_that.savedDegrees);case WheelSpinning():
return spinning(_that.balance);case WheelLanding():
return landing(_that.balance,_that.targetGift);case WheelStopped():
return stopped(_that.balance,_that.wonGift);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int balance,  double? savedDegrees)?  idle,TResult? Function( int balance)?  spinning,TResult? Function( int balance,  Gift targetGift)?  landing,TResult? Function( int balance,  Gift wonGift)?  stopped,}) {final _that = this;
switch (_that) {
case WheelIdle() when idle != null:
return idle(_that.balance,_that.savedDegrees);case WheelSpinning() when spinning != null:
return spinning(_that.balance);case WheelLanding() when landing != null:
return landing(_that.balance,_that.targetGift);case WheelStopped() when stopped != null:
return stopped(_that.balance,_that.wonGift);case _:
  return null;

}
}

}

/// @nodoc


class WheelIdle implements WheelState {
  const WheelIdle({required this.balance, this.savedDegrees});
  

@override final  int balance;
 final  double? savedDegrees;

/// Create a copy of WheelState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WheelIdleCopyWith<WheelIdle> get copyWith => _$WheelIdleCopyWithImpl<WheelIdle>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WheelIdle&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.savedDegrees, savedDegrees) || other.savedDegrees == savedDegrees));
}


@override
int get hashCode => Object.hash(runtimeType,balance,savedDegrees);

@override
String toString() {
  return 'WheelState.idle(balance: $balance, savedDegrees: $savedDegrees)';
}


}

/// @nodoc
abstract mixin class $WheelIdleCopyWith<$Res> implements $WheelStateCopyWith<$Res> {
  factory $WheelIdleCopyWith(WheelIdle value, $Res Function(WheelIdle) _then) = _$WheelIdleCopyWithImpl;
@override @useResult
$Res call({
 int balance, double? savedDegrees
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
@override @pragma('vm:prefer-inline') $Res call({Object? balance = null,Object? savedDegrees = freezed,}) {
  return _then(WheelIdle(
balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as int,savedDegrees: freezed == savedDegrees ? _self.savedDegrees : savedDegrees // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

/// @nodoc


class WheelSpinning implements WheelState {
  const WheelSpinning({required this.balance});
  

@override final  int balance;

/// Create a copy of WheelState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WheelSpinningCopyWith<WheelSpinning> get copyWith => _$WheelSpinningCopyWithImpl<WheelSpinning>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WheelSpinning&&(identical(other.balance, balance) || other.balance == balance));
}


@override
int get hashCode => Object.hash(runtimeType,balance);

@override
String toString() {
  return 'WheelState.spinning(balance: $balance)';
}


}

/// @nodoc
abstract mixin class $WheelSpinningCopyWith<$Res> implements $WheelStateCopyWith<$Res> {
  factory $WheelSpinningCopyWith(WheelSpinning value, $Res Function(WheelSpinning) _then) = _$WheelSpinningCopyWithImpl;
@override @useResult
$Res call({
 int balance
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
@override @pragma('vm:prefer-inline') $Res call({Object? balance = null,}) {
  return _then(WheelSpinning(
balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class WheelLanding implements WheelState {
  const WheelLanding({required this.balance, required this.targetGift});
  

@override final  int balance;
 final  Gift targetGift;

/// Create a copy of WheelState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WheelLandingCopyWith<WheelLanding> get copyWith => _$WheelLandingCopyWithImpl<WheelLanding>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WheelLanding&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.targetGift, targetGift) || other.targetGift == targetGift));
}


@override
int get hashCode => Object.hash(runtimeType,balance,targetGift);

@override
String toString() {
  return 'WheelState.landing(balance: $balance, targetGift: $targetGift)';
}


}

/// @nodoc
abstract mixin class $WheelLandingCopyWith<$Res> implements $WheelStateCopyWith<$Res> {
  factory $WheelLandingCopyWith(WheelLanding value, $Res Function(WheelLanding) _then) = _$WheelLandingCopyWithImpl;
@override @useResult
$Res call({
 int balance, Gift targetGift
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
@override @pragma('vm:prefer-inline') $Res call({Object? balance = null,Object? targetGift = null,}) {
  return _then(WheelLanding(
balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as int,targetGift: null == targetGift ? _self.targetGift : targetGift // ignore: cast_nullable_to_non_nullable
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
  const WheelStopped({required this.balance, required this.wonGift});
  

@override final  int balance;
 final  Gift wonGift;

/// Create a copy of WheelState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WheelStoppedCopyWith<WheelStopped> get copyWith => _$WheelStoppedCopyWithImpl<WheelStopped>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WheelStopped&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.wonGift, wonGift) || other.wonGift == wonGift));
}


@override
int get hashCode => Object.hash(runtimeType,balance,wonGift);

@override
String toString() {
  return 'WheelState.stopped(balance: $balance, wonGift: $wonGift)';
}


}

/// @nodoc
abstract mixin class $WheelStoppedCopyWith<$Res> implements $WheelStateCopyWith<$Res> {
  factory $WheelStoppedCopyWith(WheelStopped value, $Res Function(WheelStopped) _then) = _$WheelStoppedCopyWithImpl;
@override @useResult
$Res call({
 int balance, Gift wonGift
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
@override @pragma('vm:prefer-inline') $Res call({Object? balance = null,Object? wonGift = null,}) {
  return _then(WheelStopped(
balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as int,wonGift: null == wonGift ? _self.wonGift : wonGift // ignore: cast_nullable_to_non_nullable
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

// dart format on
