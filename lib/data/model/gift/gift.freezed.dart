// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gift.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
Gift _$GiftFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'regular':
          return RegularGift.fromJson(
            json
          );
                case 'coin':
          return CoinGift.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'Gift',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$Gift {

 String get name; GiftRarity get rarity;
/// Create a copy of Gift
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GiftCopyWith<Gift> get copyWith => _$GiftCopyWithImpl<Gift>(this as Gift, _$identity);

  /// Serializes this Gift to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Gift&&(identical(other.name, name) || other.name == name)&&(identical(other.rarity, rarity) || other.rarity == rarity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,rarity);

@override
String toString() {
  return 'Gift(name: $name, rarity: $rarity)';
}


}

/// @nodoc
abstract mixin class $GiftCopyWith<$Res>  {
  factory $GiftCopyWith(Gift value, $Res Function(Gift) _then) = _$GiftCopyWithImpl;
@useResult
$Res call({
 String name, GiftRarity rarity
});




}
/// @nodoc
class _$GiftCopyWithImpl<$Res>
    implements $GiftCopyWith<$Res> {
  _$GiftCopyWithImpl(this._self, this._then);

  final Gift _self;
  final $Res Function(Gift) _then;

/// Create a copy of Gift
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? rarity = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,rarity: null == rarity ? _self.rarity : rarity // ignore: cast_nullable_to_non_nullable
as GiftRarity,
  ));
}

}


/// Adds pattern-matching-related methods to [Gift].
extension GiftPatterns on Gift {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RegularGift value)?  regular,TResult Function( CoinGift value)?  coin,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RegularGift() when regular != null:
return regular(_that);case CoinGift() when coin != null:
return coin(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RegularGift value)  regular,required TResult Function( CoinGift value)  coin,}){
final _that = this;
switch (_that) {
case RegularGift():
return regular(_that);case CoinGift():
return coin(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RegularGift value)?  regular,TResult? Function( CoinGift value)?  coin,}){
final _that = this;
switch (_that) {
case RegularGift() when regular != null:
return regular(_that);case CoinGift() when coin != null:
return coin(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String name,  String? imagePath,  GiftRarity rarity)?  regular,TResult Function( String name,  int value,  GiftRarity rarity)?  coin,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RegularGift() when regular != null:
return regular(_that.name,_that.imagePath,_that.rarity);case CoinGift() when coin != null:
return coin(_that.name,_that.value,_that.rarity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String name,  String? imagePath,  GiftRarity rarity)  regular,required TResult Function( String name,  int value,  GiftRarity rarity)  coin,}) {final _that = this;
switch (_that) {
case RegularGift():
return regular(_that.name,_that.imagePath,_that.rarity);case CoinGift():
return coin(_that.name,_that.value,_that.rarity);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String name,  String? imagePath,  GiftRarity rarity)?  regular,TResult? Function( String name,  int value,  GiftRarity rarity)?  coin,}) {final _that = this;
switch (_that) {
case RegularGift() when regular != null:
return regular(_that.name,_that.imagePath,_that.rarity);case CoinGift() when coin != null:
return coin(_that.name,_that.value,_that.rarity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class RegularGift implements Gift {
  const RegularGift({required this.name, this.imagePath, required this.rarity, final  String? $type}): $type = $type ?? 'regular';
  factory RegularGift.fromJson(Map<String, dynamic> json) => _$RegularGiftFromJson(json);

@override final  String name;
 final  String? imagePath;
@override final  GiftRarity rarity;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of Gift
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegularGiftCopyWith<RegularGift> get copyWith => _$RegularGiftCopyWithImpl<RegularGift>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegularGiftToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegularGift&&(identical(other.name, name) || other.name == name)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.rarity, rarity) || other.rarity == rarity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,imagePath,rarity);

@override
String toString() {
  return 'Gift.regular(name: $name, imagePath: $imagePath, rarity: $rarity)';
}


}

/// @nodoc
abstract mixin class $RegularGiftCopyWith<$Res> implements $GiftCopyWith<$Res> {
  factory $RegularGiftCopyWith(RegularGift value, $Res Function(RegularGift) _then) = _$RegularGiftCopyWithImpl;
@override @useResult
$Res call({
 String name, String? imagePath, GiftRarity rarity
});




}
/// @nodoc
class _$RegularGiftCopyWithImpl<$Res>
    implements $RegularGiftCopyWith<$Res> {
  _$RegularGiftCopyWithImpl(this._self, this._then);

  final RegularGift _self;
  final $Res Function(RegularGift) _then;

/// Create a copy of Gift
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? imagePath = freezed,Object? rarity = null,}) {
  return _then(RegularGift(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,rarity: null == rarity ? _self.rarity : rarity // ignore: cast_nullable_to_non_nullable
as GiftRarity,
  ));
}


}

/// @nodoc
@JsonSerializable()

class CoinGift implements Gift {
  const CoinGift({required this.name, required this.value, required this.rarity, final  String? $type}): $type = $type ?? 'coin';
  factory CoinGift.fromJson(Map<String, dynamic> json) => _$CoinGiftFromJson(json);

@override final  String name;
 final  int value;
@override final  GiftRarity rarity;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of Gift
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoinGiftCopyWith<CoinGift> get copyWith => _$CoinGiftCopyWithImpl<CoinGift>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CoinGiftToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoinGift&&(identical(other.name, name) || other.name == name)&&(identical(other.value, value) || other.value == value)&&(identical(other.rarity, rarity) || other.rarity == rarity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,value,rarity);

@override
String toString() {
  return 'Gift.coin(name: $name, value: $value, rarity: $rarity)';
}


}

/// @nodoc
abstract mixin class $CoinGiftCopyWith<$Res> implements $GiftCopyWith<$Res> {
  factory $CoinGiftCopyWith(CoinGift value, $Res Function(CoinGift) _then) = _$CoinGiftCopyWithImpl;
@override @useResult
$Res call({
 String name, int value, GiftRarity rarity
});




}
/// @nodoc
class _$CoinGiftCopyWithImpl<$Res>
    implements $CoinGiftCopyWith<$Res> {
  _$CoinGiftCopyWithImpl(this._self, this._then);

  final CoinGift _self;
  final $Res Function(CoinGift) _then;

/// Create a copy of Gift
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? value = null,Object? rarity = null,}) {
  return _then(CoinGift(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,rarity: null == rarity ? _self.rarity : rarity // ignore: cast_nullable_to_non_nullable
as GiftRarity,
  ));
}


}

// dart format on
