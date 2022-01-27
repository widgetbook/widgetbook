// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'theming_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ThemingStateTearOff {
  const _$ThemingStateTearOff();

  _ThemingState<T> call<T>({required List<WidgetbookTheme<T>> themes}) {
    return _ThemingState<T>(
      themes: themes,
    );
  }
}

/// @nodoc
const $ThemingState = _$ThemingStateTearOff();

/// @nodoc
mixin _$ThemingState<T> {
  List<WidgetbookTheme<T>> get themes => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ThemingStateCopyWith<T, ThemingState<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThemingStateCopyWith<T, $Res> {
  factory $ThemingStateCopyWith(
          ThemingState<T> value, $Res Function(ThemingState<T>) then) =
      _$ThemingStateCopyWithImpl<T, $Res>;
  $Res call({List<WidgetbookTheme<T>> themes});
}

/// @nodoc
class _$ThemingStateCopyWithImpl<T, $Res>
    implements $ThemingStateCopyWith<T, $Res> {
  _$ThemingStateCopyWithImpl(this._value, this._then);

  final ThemingState<T> _value;
  // ignore: unused_field
  final $Res Function(ThemingState<T>) _then;

  @override
  $Res call({
    Object? themes = freezed,
  }) {
    return _then(_value.copyWith(
      themes: themes == freezed
          ? _value.themes
          : themes // ignore: cast_nullable_to_non_nullable
              as List<WidgetbookTheme<T>>,
    ));
  }
}

/// @nodoc
abstract class _$ThemingStateCopyWith<T, $Res>
    implements $ThemingStateCopyWith<T, $Res> {
  factory _$ThemingStateCopyWith(
          _ThemingState<T> value, $Res Function(_ThemingState<T>) then) =
      __$ThemingStateCopyWithImpl<T, $Res>;
  @override
  $Res call({List<WidgetbookTheme<T>> themes});
}

/// @nodoc
class __$ThemingStateCopyWithImpl<T, $Res>
    extends _$ThemingStateCopyWithImpl<T, $Res>
    implements _$ThemingStateCopyWith<T, $Res> {
  __$ThemingStateCopyWithImpl(
      _ThemingState<T> _value, $Res Function(_ThemingState<T>) _then)
      : super(_value, (v) => _then(v as _ThemingState<T>));

  @override
  _ThemingState<T> get _value => super._value as _ThemingState<T>;

  @override
  $Res call({
    Object? themes = freezed,
  }) {
    return _then(_ThemingState<T>(
      themes: themes == freezed
          ? _value.themes
          : themes // ignore: cast_nullable_to_non_nullable
              as List<WidgetbookTheme<T>>,
    ));
  }
}

/// @nodoc

class _$_ThemingState<T> implements _ThemingState<T> {
  _$_ThemingState({required this.themes});

  @override
  final List<WidgetbookTheme<T>> themes;

  @override
  String toString() {
    return 'ThemingState<$T>(themes: $themes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ThemingState<T> &&
            const DeepCollectionEquality().equals(other.themes, themes));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(themes));

  @JsonKey(ignore: true)
  @override
  _$ThemingStateCopyWith<T, _ThemingState<T>> get copyWith =>
      __$ThemingStateCopyWithImpl<T, _ThemingState<T>>(this, _$identity);
}

abstract class _ThemingState<T> implements ThemingState<T> {
  factory _ThemingState({required List<WidgetbookTheme<T>> themes}) =
      _$_ThemingState<T>;

  @override
  List<WidgetbookTheme<T>> get themes;
  @override
  @JsonKey(ignore: true)
  _$ThemingStateCopyWith<T, _ThemingState<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
