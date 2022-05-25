// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'translate_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TranslateState {
  Offset get offset => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TranslateStateCopyWith<TranslateState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TranslateStateCopyWith<$Res> {
  factory $TranslateStateCopyWith(
          TranslateState value, $Res Function(TranslateState) then) =
      _$TranslateStateCopyWithImpl<$Res>;
  $Res call({Offset offset});
}

/// @nodoc
class _$TranslateStateCopyWithImpl<$Res>
    implements $TranslateStateCopyWith<$Res> {
  _$TranslateStateCopyWithImpl(this._value, this._then);

  final TranslateState _value;
  // ignore: unused_field
  final $Res Function(TranslateState) _then;

  @override
  $Res call({
    Object? offset = freezed,
  }) {
    return _then(_value.copyWith(
      offset: offset == freezed
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as Offset,
    ));
  }
}

/// @nodoc
abstract class _$$_TranslateStateCopyWith<$Res>
    implements $TranslateStateCopyWith<$Res> {
  factory _$$_TranslateStateCopyWith(
          _$_TranslateState value, $Res Function(_$_TranslateState) then) =
      __$$_TranslateStateCopyWithImpl<$Res>;
  @override
  $Res call({Offset offset});
}

/// @nodoc
class __$$_TranslateStateCopyWithImpl<$Res>
    extends _$TranslateStateCopyWithImpl<$Res>
    implements _$$_TranslateStateCopyWith<$Res> {
  __$$_TranslateStateCopyWithImpl(
      _$_TranslateState _value, $Res Function(_$_TranslateState) _then)
      : super(_value, (v) => _then(v as _$_TranslateState));

  @override
  _$_TranslateState get _value => super._value as _$_TranslateState;

  @override
  $Res call({
    Object? offset = freezed,
  }) {
    return _then(_$_TranslateState(
      offset: offset == freezed
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as Offset,
    ));
  }
}

/// @nodoc

class _$_TranslateState implements _TranslateState {
  _$_TranslateState({this.offset = Offset.zero});

  @override
  @JsonKey()
  final Offset offset;

  @override
  String toString() {
    return 'TranslateState(offset: $offset)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TranslateState &&
            const DeepCollectionEquality().equals(other.offset, offset));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(offset));

  @JsonKey(ignore: true)
  @override
  _$$_TranslateStateCopyWith<_$_TranslateState> get copyWith =>
      __$$_TranslateStateCopyWithImpl<_$_TranslateState>(this, _$identity);
}

abstract class _TranslateState implements TranslateState {
  factory _TranslateState({final Offset offset}) = _$_TranslateState;

  @override
  Offset get offset => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_TranslateStateCopyWith<_$_TranslateState> get copyWith =>
      throw _privateConstructorUsedError;
}
