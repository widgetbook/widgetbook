// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'widgetbook_theme_builder_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WidgetbookThemeBuilderData _$WidgetbookThemeBuilderDataFromJson(
    Map<String, dynamic> json) {
  return _WidgetbookThemeBuilderData.fromJson(json);
}

/// @nodoc
class _$WidgetbookThemeBuilderDataTearOff {
  const _$WidgetbookThemeBuilderDataTearOff();

  _WidgetbookThemeBuilderData call(
      {required String name,
      required String importStatement,
      required List<String> dependencies}) {
    return _WidgetbookThemeBuilderData(
      name: name,
      importStatement: importStatement,
      dependencies: dependencies,
    );
  }

  WidgetbookThemeBuilderData fromJson(Map<String, Object?> json) {
    return WidgetbookThemeBuilderData.fromJson(json);
  }
}

/// @nodoc
const $WidgetbookThemeBuilderData = _$WidgetbookThemeBuilderDataTearOff();

/// @nodoc
mixin _$WidgetbookThemeBuilderData {
  String get name => throw _privateConstructorUsedError;
  String get importStatement => throw _privateConstructorUsedError;
  List<String> get dependencies => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WidgetbookThemeBuilderDataCopyWith<WidgetbookThemeBuilderData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WidgetbookThemeBuilderDataCopyWith<$Res> {
  factory $WidgetbookThemeBuilderDataCopyWith(WidgetbookThemeBuilderData value,
          $Res Function(WidgetbookThemeBuilderData) then) =
      _$WidgetbookThemeBuilderDataCopyWithImpl<$Res>;
  $Res call({String name, String importStatement, List<String> dependencies});
}

/// @nodoc
class _$WidgetbookThemeBuilderDataCopyWithImpl<$Res>
    implements $WidgetbookThemeBuilderDataCopyWith<$Res> {
  _$WidgetbookThemeBuilderDataCopyWithImpl(this._value, this._then);

  final WidgetbookThemeBuilderData _value;
  // ignore: unused_field
  final $Res Function(WidgetbookThemeBuilderData) _then;

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
abstract class _$WidgetbookThemeBuilderDataCopyWith<$Res>
    implements $WidgetbookThemeBuilderDataCopyWith<$Res> {
  factory _$WidgetbookThemeBuilderDataCopyWith(
          _WidgetbookThemeBuilderData value,
          $Res Function(_WidgetbookThemeBuilderData) then) =
      __$WidgetbookThemeBuilderDataCopyWithImpl<$Res>;
  @override
  $Res call({String name, String importStatement, List<String> dependencies});
}

/// @nodoc
class __$WidgetbookThemeBuilderDataCopyWithImpl<$Res>
    extends _$WidgetbookThemeBuilderDataCopyWithImpl<$Res>
    implements _$WidgetbookThemeBuilderDataCopyWith<$Res> {
  __$WidgetbookThemeBuilderDataCopyWithImpl(_WidgetbookThemeBuilderData _value,
      $Res Function(_WidgetbookThemeBuilderData) _then)
      : super(_value, (v) => _then(v as _WidgetbookThemeBuilderData));

  @override
  _WidgetbookThemeBuilderData get _value =>
      super._value as _WidgetbookThemeBuilderData;

  @override
  $Res call({
    Object? name = freezed,
    Object? importStatement = freezed,
    Object? dependencies = freezed,
  }) {
    return _then(_WidgetbookThemeBuilderData(
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
class _$_WidgetbookThemeBuilderData implements _WidgetbookThemeBuilderData {
  _$_WidgetbookThemeBuilderData(
      {required this.name,
      required this.importStatement,
      required this.dependencies});

  factory _$_WidgetbookThemeBuilderData.fromJson(Map<String, dynamic> json) =>
      _$$_WidgetbookThemeBuilderDataFromJson(json);

  @override
  final String name;
  @override
  final String importStatement;
  @override
  final List<String> dependencies;

  @override
  String toString() {
    return 'WidgetbookThemeBuilderData(name: $name, importStatement: $importStatement, dependencies: $dependencies)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WidgetbookThemeBuilderData &&
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
  _$WidgetbookThemeBuilderDataCopyWith<_WidgetbookThemeBuilderData>
      get copyWith => __$WidgetbookThemeBuilderDataCopyWithImpl<
          _WidgetbookThemeBuilderData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WidgetbookThemeBuilderDataToJson(this);
  }
}

abstract class _WidgetbookThemeBuilderData
    implements WidgetbookThemeBuilderData {
  factory _WidgetbookThemeBuilderData(
      {required String name,
      required String importStatement,
      required List<String> dependencies}) = _$_WidgetbookThemeBuilderData;

  factory _WidgetbookThemeBuilderData.fromJson(Map<String, dynamic> json) =
      _$_WidgetbookThemeBuilderData.fromJson;

  @override
  String get name;
  @override
  String get importStatement;
  @override
  List<String> get dependencies;
  @override
  @JsonKey(ignore: true)
  _$WidgetbookThemeBuilderDataCopyWith<_WidgetbookThemeBuilderData>
      get copyWith => throw _privateConstructorUsedError;
}
