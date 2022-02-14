// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'widgetbook_scaffold_builder_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WidgetbookScaffoldBuilderData _$WidgetbookScaffoldBuilderDataFromJson(
    Map<String, dynamic> json) {
  return _WidgetbookScaffoldBuilderData.fromJson(json);
}

/// @nodoc
class _$WidgetbookScaffoldBuilderDataTearOff {
  const _$WidgetbookScaffoldBuilderDataTearOff();

  _WidgetbookScaffoldBuilderData call(
      {required String name,
      required String importStatement,
      required List<String> dependencies}) {
    return _WidgetbookScaffoldBuilderData(
      name: name,
      importStatement: importStatement,
      dependencies: dependencies,
    );
  }

  WidgetbookScaffoldBuilderData fromJson(Map<String, Object?> json) {
    return WidgetbookScaffoldBuilderData.fromJson(json);
  }
}

/// @nodoc
const $WidgetbookScaffoldBuilderData = _$WidgetbookScaffoldBuilderDataTearOff();

/// @nodoc
mixin _$WidgetbookScaffoldBuilderData {
  String get name => throw _privateConstructorUsedError;
  String get importStatement => throw _privateConstructorUsedError;
  List<String> get dependencies => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WidgetbookScaffoldBuilderDataCopyWith<WidgetbookScaffoldBuilderData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WidgetbookScaffoldBuilderDataCopyWith<$Res> {
  factory $WidgetbookScaffoldBuilderDataCopyWith(
          WidgetbookScaffoldBuilderData value,
          $Res Function(WidgetbookScaffoldBuilderData) then) =
      _$WidgetbookScaffoldBuilderDataCopyWithImpl<$Res>;
  $Res call({String name, String importStatement, List<String> dependencies});
}

/// @nodoc
class _$WidgetbookScaffoldBuilderDataCopyWithImpl<$Res>
    implements $WidgetbookScaffoldBuilderDataCopyWith<$Res> {
  _$WidgetbookScaffoldBuilderDataCopyWithImpl(this._value, this._then);

  final WidgetbookScaffoldBuilderData _value;
  // ignore: unused_field
  final $Res Function(WidgetbookScaffoldBuilderData) _then;

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
abstract class _$WidgetbookScaffoldBuilderDataCopyWith<$Res>
    implements $WidgetbookScaffoldBuilderDataCopyWith<$Res> {
  factory _$WidgetbookScaffoldBuilderDataCopyWith(
          _WidgetbookScaffoldBuilderData value,
          $Res Function(_WidgetbookScaffoldBuilderData) then) =
      __$WidgetbookScaffoldBuilderDataCopyWithImpl<$Res>;
  @override
  $Res call({String name, String importStatement, List<String> dependencies});
}

/// @nodoc
class __$WidgetbookScaffoldBuilderDataCopyWithImpl<$Res>
    extends _$WidgetbookScaffoldBuilderDataCopyWithImpl<$Res>
    implements _$WidgetbookScaffoldBuilderDataCopyWith<$Res> {
  __$WidgetbookScaffoldBuilderDataCopyWithImpl(
      _WidgetbookScaffoldBuilderData _value,
      $Res Function(_WidgetbookScaffoldBuilderData) _then)
      : super(_value, (v) => _then(v as _WidgetbookScaffoldBuilderData));

  @override
  _WidgetbookScaffoldBuilderData get _value =>
      super._value as _WidgetbookScaffoldBuilderData;

  @override
  $Res call({
    Object? name = freezed,
    Object? importStatement = freezed,
    Object? dependencies = freezed,
  }) {
    return _then(_WidgetbookScaffoldBuilderData(
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
class _$_WidgetbookScaffoldBuilderData
    implements _WidgetbookScaffoldBuilderData {
  _$_WidgetbookScaffoldBuilderData(
      {required this.name,
      required this.importStatement,
      required this.dependencies});

  factory _$_WidgetbookScaffoldBuilderData.fromJson(
          Map<String, dynamic> json) =>
      _$$_WidgetbookScaffoldBuilderDataFromJson(json);

  @override
  final String name;
  @override
  final String importStatement;
  @override
  final List<String> dependencies;

  @override
  String toString() {
    return 'WidgetbookScaffoldBuilderData(name: $name, importStatement: $importStatement, dependencies: $dependencies)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WidgetbookScaffoldBuilderData &&
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
  _$WidgetbookScaffoldBuilderDataCopyWith<_WidgetbookScaffoldBuilderData>
      get copyWith => __$WidgetbookScaffoldBuilderDataCopyWithImpl<
          _WidgetbookScaffoldBuilderData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WidgetbookScaffoldBuilderDataToJson(this);
  }
}

abstract class _WidgetbookScaffoldBuilderData
    implements WidgetbookScaffoldBuilderData {
  factory _WidgetbookScaffoldBuilderData(
      {required String name,
      required String importStatement,
      required List<String> dependencies}) = _$_WidgetbookScaffoldBuilderData;

  factory _WidgetbookScaffoldBuilderData.fromJson(Map<String, dynamic> json) =
      _$_WidgetbookScaffoldBuilderData.fromJson;

  @override
  String get name;
  @override
  String get importStatement;
  @override
  List<String> get dependencies;
  @override
  @JsonKey(ignore: true)
  _$WidgetbookScaffoldBuilderDataCopyWith<_WidgetbookScaffoldBuilderData>
      get copyWith => throw _privateConstructorUsedError;
}
