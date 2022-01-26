// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'widgetbook_theme.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$WidgetbookThemeTearOff {
  const _$WidgetbookThemeTearOff();

  _WidgetbookTheme<T> call<T>(
      {required String name, required IconData icon, required T data}) {
    return _WidgetbookTheme<T>(
      name: name,
      icon: icon,
      data: data,
    );
  }
}

/// @nodoc
const $WidgetbookTheme = _$WidgetbookThemeTearOff();

/// @nodoc
mixin _$WidgetbookTheme<T> {
  String get name => throw _privateConstructorUsedError;
  IconData get icon => throw _privateConstructorUsedError;
  T get data => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WidgetbookThemeCopyWith<T, WidgetbookTheme<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WidgetbookThemeCopyWith<T, $Res> {
  factory $WidgetbookThemeCopyWith(
          WidgetbookTheme<T> value, $Res Function(WidgetbookTheme<T>) then) =
      _$WidgetbookThemeCopyWithImpl<T, $Res>;
  $Res call({String name, IconData icon, T data});
}

/// @nodoc
class _$WidgetbookThemeCopyWithImpl<T, $Res>
    implements $WidgetbookThemeCopyWith<T, $Res> {
  _$WidgetbookThemeCopyWithImpl(this._value, this._then);

  final WidgetbookTheme<T> _value;
  // ignore: unused_field
  final $Res Function(WidgetbookTheme<T>) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? icon = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      icon: icon == freezed
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc
abstract class _$WidgetbookThemeCopyWith<T, $Res>
    implements $WidgetbookThemeCopyWith<T, $Res> {
  factory _$WidgetbookThemeCopyWith(
          _WidgetbookTheme<T> value, $Res Function(_WidgetbookTheme<T>) then) =
      __$WidgetbookThemeCopyWithImpl<T, $Res>;
  @override
  $Res call({String name, IconData icon, T data});
}

/// @nodoc
class __$WidgetbookThemeCopyWithImpl<T, $Res>
    extends _$WidgetbookThemeCopyWithImpl<T, $Res>
    implements _$WidgetbookThemeCopyWith<T, $Res> {
  __$WidgetbookThemeCopyWithImpl(
      _WidgetbookTheme<T> _value, $Res Function(_WidgetbookTheme<T>) _then)
      : super(_value, (v) => _then(v as _WidgetbookTheme<T>));

  @override
  _WidgetbookTheme<T> get _value => super._value as _WidgetbookTheme<T>;

  @override
  $Res call({
    Object? name = freezed,
    Object? icon = freezed,
    Object? data = freezed,
  }) {
    return _then(_WidgetbookTheme<T>(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      icon: icon == freezed
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$_WidgetbookTheme<T> implements _WidgetbookTheme<T> {
  _$_WidgetbookTheme(
      {required this.name, required this.icon, required this.data});

  @override
  final String name;
  @override
  final IconData icon;
  @override
  final T data;

  @override
  String toString() {
    return 'WidgetbookTheme<$T>(name: $name, icon: $icon, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WidgetbookTheme<T> &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.icon, icon) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(icon),
      const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  _$WidgetbookThemeCopyWith<T, _WidgetbookTheme<T>> get copyWith =>
      __$WidgetbookThemeCopyWithImpl<T, _WidgetbookTheme<T>>(this, _$identity);
}

abstract class _WidgetbookTheme<T> implements WidgetbookTheme<T> {
  factory _WidgetbookTheme(
      {required String name,
      required IconData icon,
      required T data}) = _$_WidgetbookTheme<T>;

  @override
  String get name;
  @override
  IconData get icon;
  @override
  T get data;
  @override
  @JsonKey(ignore: true)
  _$WidgetbookThemeCopyWith<T, _WidgetbookTheme<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
