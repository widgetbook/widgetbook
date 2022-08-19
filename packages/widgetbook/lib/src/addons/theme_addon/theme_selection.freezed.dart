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
mixin _$ThemeSelection {
  List<ThemeData> get themes => throw _privateConstructorUsedError;
  Set<ThemeData> get activeThemes => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ThemeSelectionCopyWith<ThemeSelection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThemeSelectionCopyWith<$Res> {
  factory $ThemeSelectionCopyWith(
          ThemeSelection value, $Res Function(ThemeSelection) then) =
      _$ThemeSelectionCopyWithImpl<$Res>;
  $Res call({List<ThemeData> themes, Set<ThemeData> activeThemes});
}

/// @nodoc
class _$ThemeSelectionCopyWithImpl<$Res>
    implements $ThemeSelectionCopyWith<$Res> {
  _$ThemeSelectionCopyWithImpl(this._value, this._then);

  final ThemeSelection _value;
  // ignore: unused_field
  final $Res Function(ThemeSelection) _then;

  @override
  $Res call({
    Object? themes = freezed,
    Object? activeThemes = freezed,
  }) {
    return _then(_value.copyWith(
      themes: themes == freezed
          ? _value.themes
          : themes // ignore: cast_nullable_to_non_nullable
              as List<ThemeData>,
      activeThemes: activeThemes == freezed
          ? _value.activeThemes
          : activeThemes // ignore: cast_nullable_to_non_nullable
              as Set<ThemeData>,
    ));
  }
}

/// @nodoc
abstract class _$$_ThemeSelectionCopyWith<$Res>
    implements $ThemeSelectionCopyWith<$Res> {
  factory _$$_ThemeSelectionCopyWith(
          _$_ThemeSelection value, $Res Function(_$_ThemeSelection) then) =
      __$$_ThemeSelectionCopyWithImpl<$Res>;
  @override
  $Res call({List<ThemeData> themes, Set<ThemeData> activeThemes});
}

/// @nodoc
class __$$_ThemeSelectionCopyWithImpl<$Res>
    extends _$ThemeSelectionCopyWithImpl<$Res>
    implements _$$_ThemeSelectionCopyWith<$Res> {
  __$$_ThemeSelectionCopyWithImpl(
      _$_ThemeSelection _value, $Res Function(_$_ThemeSelection) _then)
      : super(_value, (v) => _then(v as _$_ThemeSelection));

  @override
  _$_ThemeSelection get _value => super._value as _$_ThemeSelection;

  @override
  $Res call({
    Object? themes = freezed,
    Object? activeThemes = freezed,
  }) {
    return _then(_$_ThemeSelection(
      themes: themes == freezed
          ? _value._themes
          : themes // ignore: cast_nullable_to_non_nullable
              as List<ThemeData>,
      activeThemes: activeThemes == freezed
          ? _value._activeThemes
          : activeThemes // ignore: cast_nullable_to_non_nullable
              as Set<ThemeData>,
    ));
  }
}

/// @nodoc

class _$_ThemeSelection implements _ThemeSelection {
  _$_ThemeSelection(
      {required final List<ThemeData> themes,
      required final Set<ThemeData> activeThemes})
      : _themes = themes,
        _activeThemes = activeThemes;

  final List<ThemeData> _themes;
  @override
  List<ThemeData> get themes {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_themes);
  }

  final Set<ThemeData> _activeThemes;
  @override
  Set<ThemeData> get activeThemes {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_activeThemes);
  }

  @override
  String toString() {
    return 'ThemeSelection(themes: $themes, activeThemes: $activeThemes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ThemeSelection &&
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
  _$$_ThemeSelectionCopyWith<_$_ThemeSelection> get copyWith =>
      __$$_ThemeSelectionCopyWithImpl<_$_ThemeSelection>(this, _$identity);
}

abstract class _ThemeSelection implements ThemeSelection {
  factory _ThemeSelection(
      {required final List<ThemeData> themes,
      required final Set<ThemeData> activeThemes}) = _$_ThemeSelection;

  @override
  List<ThemeData> get themes => throw _privateConstructorUsedError;
  @override
  Set<ThemeData> get activeThemes => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ThemeSelectionCopyWith<_$_ThemeSelection> get copyWith =>
      throw _privateConstructorUsedError;
}
