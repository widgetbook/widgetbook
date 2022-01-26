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

  _ThemingState call(
      {List<WidgetbookTheme> themes = const <WidgetbookTheme>[]}) {
    return _ThemingState(
      themes: themes,
    );
  }
}

/// @nodoc
const $ThemingState = _$ThemingStateTearOff();

/// @nodoc
mixin _$ThemingState {
  List<WidgetbookTheme> get themes => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ThemingStateCopyWith<ThemingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThemingStateCopyWith<$Res> {
  factory $ThemingStateCopyWith(
          ThemingState value, $Res Function(ThemingState) then) =
      _$ThemingStateCopyWithImpl<$Res>;
  $Res call({List<WidgetbookTheme> themes});
}

/// @nodoc
class _$ThemingStateCopyWithImpl<$Res> implements $ThemingStateCopyWith<$Res> {
  _$ThemingStateCopyWithImpl(this._value, this._then);

  final ThemingState _value;
  // ignore: unused_field
  final $Res Function(ThemingState) _then;

  @override
  $Res call({
    Object? themes = freezed,
  }) {
    return _then(_value.copyWith(
      themes: themes == freezed
          ? _value.themes
          : themes // ignore: cast_nullable_to_non_nullable
              as List<WidgetbookTheme>,
    ));
  }
}

/// @nodoc
abstract class _$ThemingStateCopyWith<$Res>
    implements $ThemingStateCopyWith<$Res> {
  factory _$ThemingStateCopyWith(
          _ThemingState value, $Res Function(_ThemingState) then) =
      __$ThemingStateCopyWithImpl<$Res>;
  @override
  $Res call({List<WidgetbookTheme> themes});
}

/// @nodoc
class __$ThemingStateCopyWithImpl<$Res> extends _$ThemingStateCopyWithImpl<$Res>
    implements _$ThemingStateCopyWith<$Res> {
  __$ThemingStateCopyWithImpl(
      _ThemingState _value, $Res Function(_ThemingState) _then)
      : super(_value, (v) => _then(v as _ThemingState));

  @override
  _ThemingState get _value => super._value as _ThemingState;

  @override
  $Res call({
    Object? themes = freezed,
  }) {
    return _then(_ThemingState(
      themes: themes == freezed
          ? _value.themes
          : themes // ignore: cast_nullable_to_non_nullable
              as List<WidgetbookTheme>,
    ));
  }
}

/// @nodoc

class _$_ThemingState implements _ThemingState {
  _$_ThemingState({this.themes = const <WidgetbookTheme>[]});

  @JsonKey()
  @override
  final List<WidgetbookTheme> themes;

  @override
  String toString() {
    return 'ThemingState(themes: $themes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ThemingState &&
            const DeepCollectionEquality().equals(other.themes, themes));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(themes));

  @JsonKey(ignore: true)
  @override
  _$ThemingStateCopyWith<_ThemingState> get copyWith =>
      __$ThemingStateCopyWithImpl<_ThemingState>(this, _$identity);
}

abstract class _ThemingState implements ThemingState {
  factory _ThemingState({List<WidgetbookTheme> themes}) = _$_ThemingState;

  @override
  List<WidgetbookTheme> get themes;
  @override
  @JsonKey(ignore: true)
  _$ThemingStateCopyWith<_ThemingState> get copyWith =>
      throw _privateConstructorUsedError;
}
