// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'widgetbook_theme_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WidgetbookThemeData _$WidgetbookThemeDataFromJson(Map<String, dynamic> json) {
  return _WidgetbookThemeData.fromJson(json);
}

/// @nodoc
mixin _$WidgetbookThemeData {
// The property or method name defining the theme
  String get name => throw _privateConstructorUsedError;
  String get importStatement => throw _privateConstructorUsedError;
  List<String> get dependencies => throw _privateConstructorUsedError;
  bool get isDefault =>
      throw _privateConstructorUsedError; // The name of the theme shown in Widgetbook
// Also the string used in Widgetbook URL to set the property selection.
  String get themeName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WidgetbookThemeDataCopyWith<WidgetbookThemeData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WidgetbookThemeDataCopyWith<$Res> {
  factory $WidgetbookThemeDataCopyWith(
          WidgetbookThemeData value, $Res Function(WidgetbookThemeData) then) =
      _$WidgetbookThemeDataCopyWithImpl<$Res>;
  $Res call(
      {String name,
      String importStatement,
      List<String> dependencies,
      bool isDefault,
      String themeName});
}

/// @nodoc
class _$WidgetbookThemeDataCopyWithImpl<$Res>
    implements $WidgetbookThemeDataCopyWith<$Res> {
  _$WidgetbookThemeDataCopyWithImpl(this._value, this._then);

  final WidgetbookThemeData _value;
  // ignore: unused_field
  final $Res Function(WidgetbookThemeData) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? importStatement = freezed,
    Object? dependencies = freezed,
    Object? isDefault = freezed,
    Object? themeName = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      importStatement: importStatement == freezed
          ? _value.importStatement
          : importStatement // ignore: cast_nullable_to_non_nullable
              as String,
      dependencies: dependencies == freezed
          ? _value.dependencies
          : dependencies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isDefault: isDefault == freezed
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      themeName: themeName == freezed
          ? _value.themeName
          : themeName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_WidgetbookThemeDataCopyWith<$Res>
    implements $WidgetbookThemeDataCopyWith<$Res> {
  factory _$$_WidgetbookThemeDataCopyWith(_$_WidgetbookThemeData value,
          $Res Function(_$_WidgetbookThemeData) then) =
      __$$_WidgetbookThemeDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      String importStatement,
      List<String> dependencies,
      bool isDefault,
      String themeName});
}

/// @nodoc
class __$$_WidgetbookThemeDataCopyWithImpl<$Res>
    extends _$WidgetbookThemeDataCopyWithImpl<$Res>
    implements _$$_WidgetbookThemeDataCopyWith<$Res> {
  __$$_WidgetbookThemeDataCopyWithImpl(_$_WidgetbookThemeData _value,
      $Res Function(_$_WidgetbookThemeData) _then)
      : super(_value, (v) => _then(v as _$_WidgetbookThemeData));

  @override
  _$_WidgetbookThemeData get _value => super._value as _$_WidgetbookThemeData;

  @override
  $Res call({
    Object? name = freezed,
    Object? importStatement = freezed,
    Object? dependencies = freezed,
    Object? isDefault = freezed,
    Object? themeName = freezed,
  }) {
    return _then(_$_WidgetbookThemeData(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      importStatement: importStatement == freezed
          ? _value.importStatement
          : importStatement // ignore: cast_nullable_to_non_nullable
              as String,
      dependencies: dependencies == freezed
          ? _value._dependencies
          : dependencies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isDefault: isDefault == freezed
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      themeName: themeName == freezed
          ? _value.themeName
          : themeName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WidgetbookThemeData implements _WidgetbookThemeData {
  _$_WidgetbookThemeData(
      {required this.name,
      required this.importStatement,
      required final List<String> dependencies,
      required this.isDefault,
      required this.themeName})
      : _dependencies = dependencies;

  factory _$_WidgetbookThemeData.fromJson(Map<String, dynamic> json) =>
      _$$_WidgetbookThemeDataFromJson(json);

// The property or method name defining the theme
  @override
  final String name;
  @override
  final String importStatement;
  final List<String> _dependencies;
  @override
  List<String> get dependencies {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dependencies);
  }

  @override
  final bool isDefault;
// The name of the theme shown in Widgetbook
// Also the string used in Widgetbook URL to set the property selection.
  @override
  final String themeName;

  @override
  String toString() {
    return 'WidgetbookThemeData(name: $name, importStatement: $importStatement, dependencies: $dependencies, isDefault: $isDefault, themeName: $themeName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WidgetbookThemeData &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.importStatement, importStatement) &&
            const DeepCollectionEquality()
                .equals(other._dependencies, _dependencies) &&
            const DeepCollectionEquality().equals(other.isDefault, isDefault) &&
            const DeepCollectionEquality().equals(other.themeName, themeName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(importStatement),
      const DeepCollectionEquality().hash(_dependencies),
      const DeepCollectionEquality().hash(isDefault),
      const DeepCollectionEquality().hash(themeName));

  @JsonKey(ignore: true)
  @override
  _$$_WidgetbookThemeDataCopyWith<_$_WidgetbookThemeData> get copyWith =>
      __$$_WidgetbookThemeDataCopyWithImpl<_$_WidgetbookThemeData>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WidgetbookThemeDataToJson(this);
  }
}

abstract class _WidgetbookThemeData implements WidgetbookThemeData {
  factory _WidgetbookThemeData(
      {required final String name,
      required final String importStatement,
      required final List<String> dependencies,
      required final bool isDefault,
      required final String themeName}) = _$_WidgetbookThemeData;

  factory _WidgetbookThemeData.fromJson(Map<String, dynamic> json) =
      _$_WidgetbookThemeData.fromJson;

  @override // The property or method name defining the theme
  String get name => throw _privateConstructorUsedError;
  @override
  String get importStatement => throw _privateConstructorUsedError;
  @override
  List<String> get dependencies => throw _privateConstructorUsedError;
  @override
  bool get isDefault => throw _privateConstructorUsedError;
  @override // The name of the theme shown in Widgetbook
// Also the string used in Widgetbook URL to set the property selection.
  String get themeName => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_WidgetbookThemeDataCopyWith<_$_WidgetbookThemeData> get copyWith =>
      throw _privateConstructorUsedError;
}
