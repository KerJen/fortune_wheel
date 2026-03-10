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
mixin _$InventoryState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InventoryState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'InventoryState()';
}


}

/// @nodoc
class $InventoryStateCopyWith<$Res>  {
$InventoryStateCopyWith(InventoryState _, $Res Function(InventoryState) __);
}


/// Adds pattern-matching-related methods to [InventoryState].
extension InventoryStatePatterns on InventoryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( InventoryLoading value)?  loading,TResult Function( InventoryLoaded value)?  loaded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case InventoryLoading() when loading != null:
return loading(_that);case InventoryLoaded() when loaded != null:
return loaded(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( InventoryLoading value)  loading,required TResult Function( InventoryLoaded value)  loaded,}){
final _that = this;
switch (_that) {
case InventoryLoading():
return loading(_that);case InventoryLoaded():
return loaded(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( InventoryLoading value)?  loading,TResult? Function( InventoryLoaded value)?  loaded,}){
final _that = this;
switch (_that) {
case InventoryLoading() when loading != null:
return loading(_that);case InventoryLoaded() when loaded != null:
return loaded(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( List<InventoryItem> items)?  loaded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case InventoryLoading() when loading != null:
return loading();case InventoryLoaded() when loaded != null:
return loaded(_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( List<InventoryItem> items)  loaded,}) {final _that = this;
switch (_that) {
case InventoryLoading():
return loading();case InventoryLoaded():
return loaded(_that.items);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( List<InventoryItem> items)?  loaded,}) {final _that = this;
switch (_that) {
case InventoryLoading() when loading != null:
return loading();case InventoryLoaded() when loaded != null:
return loaded(_that.items);case _:
  return null;

}
}

}

/// @nodoc


class InventoryLoading implements InventoryState {
  const InventoryLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InventoryLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'InventoryState.loading()';
}


}




/// @nodoc


class InventoryLoaded implements InventoryState {
  const InventoryLoaded({required final  List<InventoryItem> items}): _items = items;
  

 final  List<InventoryItem> _items;
 List<InventoryItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of InventoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InventoryLoadedCopyWith<InventoryLoaded> get copyWith => _$InventoryLoadedCopyWithImpl<InventoryLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InventoryLoaded&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'InventoryState.loaded(items: $items)';
}


}

/// @nodoc
abstract mixin class $InventoryLoadedCopyWith<$Res> implements $InventoryStateCopyWith<$Res> {
  factory $InventoryLoadedCopyWith(InventoryLoaded value, $Res Function(InventoryLoaded) _then) = _$InventoryLoadedCopyWithImpl;
@useResult
$Res call({
 List<InventoryItem> items
});




}
/// @nodoc
class _$InventoryLoadedCopyWithImpl<$Res>
    implements $InventoryLoadedCopyWith<$Res> {
  _$InventoryLoadedCopyWithImpl(this._self, this._then);

  final InventoryLoaded _self;
  final $Res Function(InventoryLoaded) _then;

/// Create a copy of InventoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(InventoryLoaded(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<InventoryItem>,
  ));
}


}

// dart format on
