// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'tool_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ToolStateTearOff {
  const _$ToolStateTearOff();

  _ToolState call({SelectionMode mode = SelectionMode.normal}) {
    return _ToolState(
      mode: mode,
    );
  }
}

/// @nodoc
const $ToolState = _$ToolStateTearOff();

/// @nodoc
mixin _$ToolState {
  SelectionMode get mode => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ToolStateCopyWith<ToolState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ToolStateCopyWith<$Res> {
  factory $ToolStateCopyWith(ToolState value, $Res Function(ToolState) then) =
      _$ToolStateCopyWithImpl<$Res>;
  $Res call({SelectionMode mode});
}

/// @nodoc
class _$ToolStateCopyWithImpl<$Res> implements $ToolStateCopyWith<$Res> {
  _$ToolStateCopyWithImpl(this._value, this._then);

  final ToolState _value;
  // ignore: unused_field
  final $Res Function(ToolState) _then;

  @override
  $Res call({
    Object? mode = freezed,
  }) {
    return _then(_value.copyWith(
      mode: mode == freezed
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as SelectionMode,
    ));
  }
}

/// @nodoc
abstract class _$ToolStateCopyWith<$Res> implements $ToolStateCopyWith<$Res> {
  factory _$ToolStateCopyWith(
          _ToolState value, $Res Function(_ToolState) then) =
      __$ToolStateCopyWithImpl<$Res>;
  @override
  $Res call({SelectionMode mode});
}

/// @nodoc
class __$ToolStateCopyWithImpl<$Res> extends _$ToolStateCopyWithImpl<$Res>
    implements _$ToolStateCopyWith<$Res> {
  __$ToolStateCopyWithImpl(_ToolState _value, $Res Function(_ToolState) _then)
      : super(_value, (v) => _then(v as _ToolState));

  @override
  _ToolState get _value => super._value as _ToolState;

  @override
  $Res call({
    Object? mode = freezed,
  }) {
    return _then(_ToolState(
      mode: mode == freezed
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as SelectionMode,
    ));
  }
}

/// @nodoc

class _$_ToolState implements _ToolState {
  _$_ToolState({this.mode = SelectionMode.normal});

  @JsonKey()
  @override
  final SelectionMode mode;

  @override
  String toString() {
    return 'ToolState(mode: $mode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ToolState &&
            const DeepCollectionEquality().equals(other.mode, mode));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(mode));

  @JsonKey(ignore: true)
  @override
  _$ToolStateCopyWith<_ToolState> get copyWith =>
      __$ToolStateCopyWithImpl<_ToolState>(this, _$identity);
}

abstract class _ToolState implements ToolState {
  factory _ToolState({SelectionMode mode}) = _$_ToolState;

  @override
  SelectionMode get mode;
  @override
  @JsonKey(ignore: true)
  _$ToolStateCopyWith<_ToolState> get copyWith =>
      throw _privateConstructorUsedError;
}
