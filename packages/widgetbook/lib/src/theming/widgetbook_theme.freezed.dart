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

  _WidgetbookTheme<CustomTheme> call<CustomTheme>(
      {required String name, required CustomTheme data}) {
    return _WidgetbookTheme<CustomTheme>(
      name: name,
      data: data,
    );
  }
}

/// @nodoc
const $WidgetbookTheme = _$WidgetbookThemeTearOff();

/// @nodoc
mixin _$WidgetbookTheme<CustomTheme> {
  String get name => throw _privateConstructorUsedError;
  CustomTheme get data => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WidgetbookThemeCopyWith<CustomTheme, WidgetbookTheme<CustomTheme>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WidgetbookThemeCopyWith<CustomTheme, $Res> {
  factory $WidgetbookThemeCopyWith(WidgetbookTheme<CustomTheme> value,
          $Res Function(WidgetbookTheme<CustomTheme>) then) =
      _$WidgetbookThemeCopyWithImpl<CustomTheme, $Res>;
  $Res call({String name, CustomTheme data});
}

/// @nodoc
class _$WidgetbookThemeCopyWithImpl<CustomTheme, $Res>
    implements $WidgetbookThemeCopyWith<CustomTheme, $Res> {
  _$WidgetbookThemeCopyWithImpl(this._value, this._then);

  final WidgetbookTheme<CustomTheme> _value;
  // ignore: unused_field
  final $Res Function(WidgetbookTheme<CustomTheme>) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as CustomTheme,
    ));
  }
}

/// @nodoc
abstract class _$WidgetbookThemeCopyWith<CustomTheme, $Res>
    implements $WidgetbookThemeCopyWith<CustomTheme, $Res> {
  factory _$WidgetbookThemeCopyWith(_WidgetbookTheme<CustomTheme> value,
          $Res Function(_WidgetbookTheme<CustomTheme>) then) =
      __$WidgetbookThemeCopyWithImpl<CustomTheme, $Res>;
  @override
  $Res call({String name, CustomTheme data});
}

/// @nodoc
class __$WidgetbookThemeCopyWithImpl<CustomTheme, $Res>
    extends _$WidgetbookThemeCopyWithImpl<CustomTheme, $Res>
    implements _$WidgetbookThemeCopyWith<CustomTheme, $Res> {
  __$WidgetbookThemeCopyWithImpl(_WidgetbookTheme<CustomTheme> _value,
      $Res Function(_WidgetbookTheme<CustomTheme>) _then)
      : super(_value, (v) => _then(v as _WidgetbookTheme<CustomTheme>));

  @override
  _WidgetbookTheme<CustomTheme> get _value =>
      super._value as _WidgetbookTheme<CustomTheme>;

  @override
  $Res call({
    Object? name = freezed,
    Object? data = freezed,
  }) {
    return _then(_WidgetbookTheme<CustomTheme>(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as CustomTheme,
    ));
  }
}

/// @nodoc

class _$_WidgetbookTheme<CustomTheme> implements _WidgetbookTheme<CustomTheme> {
  _$_WidgetbookTheme({required this.name, required this.data});

  @override
  final String name;
  @override
  final CustomTheme data;

  @override
  String toString() {
    return 'WidgetbookTheme<$CustomTheme>(name: $name, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WidgetbookTheme<CustomTheme> &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  _$WidgetbookThemeCopyWith<CustomTheme, _WidgetbookTheme<CustomTheme>>
      get copyWith => __$WidgetbookThemeCopyWithImpl<CustomTheme,
          _WidgetbookTheme<CustomTheme>>(this, _$identity);
}

abstract class _WidgetbookTheme<CustomTheme>
    implements WidgetbookTheme<CustomTheme> {
  factory _WidgetbookTheme({required String name, required CustomTheme data}) =
      _$_WidgetbookTheme<CustomTheme>;

  @override
  String get name;
  @override
  CustomTheme get data;
  @override
  @JsonKey(ignore: true)
  _$WidgetbookThemeCopyWith<CustomTheme, _WidgetbookTheme<CustomTheme>>
      get copyWith => throw _privateConstructorUsedError;
}
