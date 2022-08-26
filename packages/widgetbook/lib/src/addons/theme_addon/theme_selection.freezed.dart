// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'theme_selection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ThemeSelection<T> {
  List<WidgetbookTheme<T>> get themes => throw _privateConstructorUsedError;
  Set<WidgetbookTheme<T>> get activeThemes =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ThemeSelectionCopyWith<T, ThemeSelection<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThemeSelectionCopyWith<T, $Res> {
  factory $ThemeSelectionCopyWith(
          ThemeSelection<T> value, $Res Function(ThemeSelection<T>) then) =
      _$ThemeSelectionCopyWithImpl<T, $Res>;
  $Res call(
      {List<WidgetbookTheme<T>> themes, Set<WidgetbookTheme<T>> activeThemes});
}

/// @nodoc
class _$ThemeSelectionCopyWithImpl<T, $Res>
    implements $ThemeSelectionCopyWith<T, $Res> {
  _$ThemeSelectionCopyWithImpl(this._value, this._then);

  final ThemeSelection<T> _value;
  // ignore: unused_field
  final $Res Function(ThemeSelection<T>) _then;

  @override
  $Res call({
    Object? themes = freezed,
    Object? activeThemes = freezed,
  }) {
    return _then(_value.copyWith(
      themes: themes == freezed
          ? _value.themes
          : themes // ignore: cast_nullable_to_non_nullable
              as List<WidgetbookTheme<T>>,
      activeThemes: activeThemes == freezed
          ? _value.activeThemes
          : activeThemes // ignore: cast_nullable_to_non_nullable
              as Set<WidgetbookTheme<T>>,
    ));
  }
}

/// @nodoc
abstract class _$$_ThemeSelectionCopyWith<T, $Res>
    implements $ThemeSelectionCopyWith<T, $Res> {
  factory _$$_ThemeSelectionCopyWith(_$_ThemeSelection<T> value,
          $Res Function(_$_ThemeSelection<T>) then) =
      __$$_ThemeSelectionCopyWithImpl<T, $Res>;
  @override
  $Res call(
      {List<WidgetbookTheme<T>> themes, Set<WidgetbookTheme<T>> activeThemes});
}

/// @nodoc
class __$$_ThemeSelectionCopyWithImpl<T, $Res>
    extends _$ThemeSelectionCopyWithImpl<T, $Res>
    implements _$$_ThemeSelectionCopyWith<T, $Res> {
  __$$_ThemeSelectionCopyWithImpl(
      _$_ThemeSelection<T> _value, $Res Function(_$_ThemeSelection<T>) _then)
      : super(_value, (v) => _then(v as _$_ThemeSelection<T>));

  @override
  _$_ThemeSelection<T> get _value => super._value as _$_ThemeSelection<T>;

  @override
  $Res call({
    Object? themes = freezed,
    Object? activeThemes = freezed,
  }) {
    return _then(_$_ThemeSelection<T>(
      themes: themes == freezed
          ? _value._themes
          : themes // ignore: cast_nullable_to_non_nullable
              as List<WidgetbookTheme<T>>,
      activeThemes: activeThemes == freezed
          ? _value._activeThemes
          : activeThemes // ignore: cast_nullable_to_non_nullable
              as Set<WidgetbookTheme<T>>,
    ));
  }
}

/// @nodoc

class _$_ThemeSelection<T> implements _ThemeSelection<T> {
  _$_ThemeSelection(
      {required final List<WidgetbookTheme<T>> themes,
      required final Set<WidgetbookTheme<T>> activeThemes})
      : _themes = themes,
        _activeThemes = activeThemes;

  final List<WidgetbookTheme<T>> _themes;
  @override
  List<WidgetbookTheme<T>> get themes {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_themes);
  }

  final Set<WidgetbookTheme<T>> _activeThemes;
  @override
  Set<WidgetbookTheme<T>> get activeThemes {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_activeThemes);
  }

  @override
  String toString() {
    return 'ThemeSelection<$T>(themes: $themes, activeThemes: $activeThemes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ThemeSelection<T> &&
            const DeepCollectionEquality().equals(other._themes, _themes) &&
            const DeepCollectionEquality()
                .equals(other._activeThemes, _activeThemes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_themes),
      const DeepCollectionEquality().hash(_activeThemes));

  @JsonKey(ignore: true)
  @override
  _$$_ThemeSelectionCopyWith<T, _$_ThemeSelection<T>> get copyWith =>
      __$$_ThemeSelectionCopyWithImpl<T, _$_ThemeSelection<T>>(
          this, _$identity);
}

abstract class _ThemeSelection<T> implements ThemeSelection<T> {
  factory _ThemeSelection(
          {required final List<WidgetbookTheme<T>> themes,
          required final Set<WidgetbookTheme<T>> activeThemes}) =
      _$_ThemeSelection<T>;

  @override
  List<WidgetbookTheme<T>> get themes => throw _privateConstructorUsedError;
  @override
  Set<WidgetbookTheme<T>> get activeThemes =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ThemeSelectionCopyWith<T, _$_ThemeSelection<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
