// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'widgetbook_theme_type_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WidgetbookThemeTypeData _$WidgetbookThemeTypeDataFromJson(
    Map<String, dynamic> json) {
  return _WidgetbookThemeTypeData.fromJson(json);
}

/// @nodoc
class _$WidgetbookThemeTypeDataTearOff {
  const _$WidgetbookThemeTypeDataTearOff();

  _WidgetbookThemeTypeData call(
      {required String name,
      required String importStatement,
      required List<String> dependencies}) {
    return _WidgetbookThemeTypeData(
      name: name,
      importStatement: importStatement,
      dependencies: dependencies,
    );
  }

  WidgetbookThemeTypeData fromJson(Map<String, Object?> json) {
    return WidgetbookThemeTypeData.fromJson(json);
  }
}

/// @nodoc
const $WidgetbookThemeTypeData = _$WidgetbookThemeTypeDataTearOff();

/// @nodoc
mixin _$WidgetbookThemeTypeData {
  String get name => throw _privateConstructorUsedError;
  String get importStatement => throw _privateConstructorUsedError;
  List<String> get dependencies => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WidgetbookThemeTypeDataCopyWith<WidgetbookThemeTypeData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WidgetbookThemeTypeDataCopyWith<$Res> {
  factory $WidgetbookThemeTypeDataCopyWith(WidgetbookThemeTypeData value,
          $Res Function(WidgetbookThemeTypeData) then) =
      _$WidgetbookThemeTypeDataCopyWithImpl<$Res>;
  $Res call({String name, String importStatement, List<String> dependencies});
}

/// @nodoc
class _$WidgetbookThemeTypeDataCopyWithImpl<$Res>
    implements $WidgetbookThemeTypeDataCopyWith<$Res> {
  _$WidgetbookThemeTypeDataCopyWithImpl(this._value, this._then);

  final WidgetbookThemeTypeData _value;
  // ignore: unused_field
  final $Res Function(WidgetbookThemeTypeData) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? importStatement = freezed,
    Object? dependencies = freezed,
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
    ));
  }
}

/// @nodoc
abstract class _$WidgetbookThemeTypeDataCopyWith<$Res>
    implements $WidgetbookThemeTypeDataCopyWith<$Res> {
  factory _$WidgetbookThemeTypeDataCopyWith(_WidgetbookThemeTypeData value,
          $Res Function(_WidgetbookThemeTypeData) then) =
      __$WidgetbookThemeTypeDataCopyWithImpl<$Res>;
  @override
  $Res call({String name, String importStatement, List<String> dependencies});
}

/// @nodoc
class __$WidgetbookThemeTypeDataCopyWithImpl<$Res>
    extends _$WidgetbookThemeTypeDataCopyWithImpl<$Res>
    implements _$WidgetbookThemeTypeDataCopyWith<$Res> {
  __$WidgetbookThemeTypeDataCopyWithImpl(_WidgetbookThemeTypeData _value,
      $Res Function(_WidgetbookThemeTypeData) _then)
      : super(_value, (v) => _then(v as _WidgetbookThemeTypeData));

  @override
  _WidgetbookThemeTypeData get _value =>
      super._value as _WidgetbookThemeTypeData;

  @override
  $Res call({
    Object? name = freezed,
    Object? importStatement = freezed,
    Object? dependencies = freezed,
  }) {
    return _then(_WidgetbookThemeTypeData(
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WidgetbookThemeTypeData implements _WidgetbookThemeTypeData {
  _$_WidgetbookThemeTypeData(
      {required this.name,
      required this.importStatement,
      required this.dependencies});

  factory _$_WidgetbookThemeTypeData.fromJson(Map<String, dynamic> json) =>
      _$$_WidgetbookThemeTypeDataFromJson(json);

  @override
  final String name;
  @override
  final String importStatement;
  @override
  final List<String> dependencies;

  @override
  String toString() {
    return 'WidgetbookThemeTypeData(name: $name, importStatement: $importStatement, dependencies: $dependencies)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WidgetbookThemeTypeData &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.importStatement, importStatement) &&
            const DeepCollectionEquality()
                .equals(other.dependencies, dependencies));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(importStatement),
      const DeepCollectionEquality().hash(dependencies));

  @JsonKey(ignore: true)
  @override
  _$WidgetbookThemeTypeDataCopyWith<_WidgetbookThemeTypeData> get copyWith =>
      __$WidgetbookThemeTypeDataCopyWithImpl<_WidgetbookThemeTypeData>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WidgetbookThemeTypeDataToJson(this);
  }
}

abstract class _WidgetbookThemeTypeData implements WidgetbookThemeTypeData {
  factory _WidgetbookThemeTypeData(
      {required String name,
      required String importStatement,
      required List<String> dependencies}) = _$_WidgetbookThemeTypeData;

  factory _WidgetbookThemeTypeData.fromJson(Map<String, dynamic> json) =
      _$_WidgetbookThemeTypeData.fromJson;

  @override
  String get name;
  @override
  String get importStatement;
  @override
  List<String> get dependencies;
  @override
  @JsonKey(ignore: true)
  _$WidgetbookThemeTypeDataCopyWith<_WidgetbookThemeTypeData> get copyWith =>
      throw _privateConstructorUsedError;
}
