// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'zoom_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ZoomState {
  double get zoomLevel => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ZoomStateCopyWith<ZoomState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ZoomStateCopyWith<$Res> {
  factory $ZoomStateCopyWith(ZoomState value, $Res Function(ZoomState) then) =
      _$ZoomStateCopyWithImpl<$Res>;
  $Res call({double zoomLevel});
}

/// @nodoc
class _$ZoomStateCopyWithImpl<$Res> implements $ZoomStateCopyWith<$Res> {
  _$ZoomStateCopyWithImpl(this._value, this._then);

  final ZoomState _value;
  // ignore: unused_field
  final $Res Function(ZoomState) _then;

  @override
  $Res call({
    Object? zoomLevel = freezed,
  }) {
    return _then(_value.copyWith(
      zoomLevel: zoomLevel == freezed
          ? _value.zoomLevel
          : zoomLevel // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
abstract class _$$_ZoomStateCopyWith<$Res> implements $ZoomStateCopyWith<$Res> {
  factory _$$_ZoomStateCopyWith(
          _$_ZoomState value, $Res Function(_$_ZoomState) then) =
      __$$_ZoomStateCopyWithImpl<$Res>;
  @override
  $Res call({double zoomLevel});
}

/// @nodoc
class __$$_ZoomStateCopyWithImpl<$Res> extends _$ZoomStateCopyWithImpl<$Res>
    implements _$$_ZoomStateCopyWith<$Res> {
  __$$_ZoomStateCopyWithImpl(
      _$_ZoomState _value, $Res Function(_$_ZoomState) _then)
      : super(_value, (v) => _then(v as _$_ZoomState));

  @override
  _$_ZoomState get _value => super._value as _$_ZoomState;

  @override
  $Res call({
    Object? zoomLevel = freezed,
  }) {
    return _then(_$_ZoomState(
      zoomLevel: zoomLevel == freezed
          ? _value.zoomLevel
          : zoomLevel // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$_ZoomState implements _ZoomState {
  _$_ZoomState({this.zoomLevel = 1});

  @override
  @JsonKey()
  final double zoomLevel;

  @override
  String toString() {
    return 'ZoomState(zoomLevel: $zoomLevel)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ZoomState &&
            const DeepCollectionEquality().equals(other.zoomLevel, zoomLevel));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(zoomLevel));

  @JsonKey(ignore: true)
  @override
  _$$_ZoomStateCopyWith<_$_ZoomState> get copyWith =>
      __$$_ZoomStateCopyWithImpl<_$_ZoomState>(this, _$identity);
}

abstract class _ZoomState implements ZoomState {
  factory _ZoomState({final double zoomLevel}) = _$_ZoomState;

  @override
  double get zoomLevel => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ZoomStateCopyWith<_$_ZoomState> get copyWith =>
      throw _privateConstructorUsedError;
}
