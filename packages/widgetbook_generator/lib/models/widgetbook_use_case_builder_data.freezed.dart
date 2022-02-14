// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'widgetbook_use_case_builder_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WidgetbookUseCaseBuilderData _$WidgetbookUseCaseBuilderDataFromJson(
    Map<String, dynamic> json) {
  return _WidgetbookUseCaseBuilderData.fromJson(json);
}

/// @nodoc
class _$WidgetbookUseCaseBuilderDataTearOff {
  const _$WidgetbookUseCaseBuilderDataTearOff();

  _WidgetbookUseCaseBuilderData call(
      {required String name,
      required String importStatement,
      required List<String> dependencies}) {
    return _WidgetbookUseCaseBuilderData(
      name: name,
      importStatement: importStatement,
      dependencies: dependencies,
    );
  }

  WidgetbookUseCaseBuilderData fromJson(Map<String, Object?> json) {
    return WidgetbookUseCaseBuilderData.fromJson(json);
  }
}

/// @nodoc
const $WidgetbookUseCaseBuilderData = _$WidgetbookUseCaseBuilderDataTearOff();

/// @nodoc
mixin _$WidgetbookUseCaseBuilderData {
  String get name => throw _privateConstructorUsedError;
  String get importStatement => throw _privateConstructorUsedError;
  List<String> get dependencies => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WidgetbookUseCaseBuilderDataCopyWith<WidgetbookUseCaseBuilderData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WidgetbookUseCaseBuilderDataCopyWith<$Res> {
  factory $WidgetbookUseCaseBuilderDataCopyWith(
          WidgetbookUseCaseBuilderData value,
          $Res Function(WidgetbookUseCaseBuilderData) then) =
      _$WidgetbookUseCaseBuilderDataCopyWithImpl<$Res>;
  $Res call({String name, String importStatement, List<String> dependencies});
}

/// @nodoc
class _$WidgetbookUseCaseBuilderDataCopyWithImpl<$Res>
    implements $WidgetbookUseCaseBuilderDataCopyWith<$Res> {
  _$WidgetbookUseCaseBuilderDataCopyWithImpl(this._value, this._then);

  final WidgetbookUseCaseBuilderData _value;
  // ignore: unused_field
  final $Res Function(WidgetbookUseCaseBuilderData) _then;

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
abstract class _$WidgetbookUseCaseBuilderDataCopyWith<$Res>
    implements $WidgetbookUseCaseBuilderDataCopyWith<$Res> {
  factory _$WidgetbookUseCaseBuilderDataCopyWith(
          _WidgetbookUseCaseBuilderData value,
          $Res Function(_WidgetbookUseCaseBuilderData) then) =
      __$WidgetbookUseCaseBuilderDataCopyWithImpl<$Res>;
  @override
  $Res call({String name, String importStatement, List<String> dependencies});
}

/// @nodoc
class __$WidgetbookUseCaseBuilderDataCopyWithImpl<$Res>
    extends _$WidgetbookUseCaseBuilderDataCopyWithImpl<$Res>
    implements _$WidgetbookUseCaseBuilderDataCopyWith<$Res> {
  __$WidgetbookUseCaseBuilderDataCopyWithImpl(
      _WidgetbookUseCaseBuilderData _value,
      $Res Function(_WidgetbookUseCaseBuilderData) _then)
      : super(_value, (v) => _then(v as _WidgetbookUseCaseBuilderData));

  @override
  _WidgetbookUseCaseBuilderData get _value =>
      super._value as _WidgetbookUseCaseBuilderData;

  @override
  $Res call({
    Object? name = freezed,
    Object? importStatement = freezed,
    Object? dependencies = freezed,
  }) {
    return _then(_WidgetbookUseCaseBuilderData(
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
class _$_WidgetbookUseCaseBuilderData implements _WidgetbookUseCaseBuilderData {
  _$_WidgetbookUseCaseBuilderData(
      {required this.name,
      required this.importStatement,
      required this.dependencies});

  factory _$_WidgetbookUseCaseBuilderData.fromJson(Map<String, dynamic> json) =>
      _$$_WidgetbookUseCaseBuilderDataFromJson(json);

  @override
  final String name;
  @override
  final String importStatement;
  @override
  final List<String> dependencies;

  @override
  String toString() {
    return 'WidgetbookUseCaseBuilderData(name: $name, importStatement: $importStatement, dependencies: $dependencies)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WidgetbookUseCaseBuilderData &&
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
  _$WidgetbookUseCaseBuilderDataCopyWith<_WidgetbookUseCaseBuilderData>
      get copyWith => __$WidgetbookUseCaseBuilderDataCopyWithImpl<
          _WidgetbookUseCaseBuilderData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WidgetbookUseCaseBuilderDataToJson(this);
  }
}

abstract class _WidgetbookUseCaseBuilderData
    implements WidgetbookUseCaseBuilderData {
  factory _WidgetbookUseCaseBuilderData(
      {required String name,
      required String importStatement,
      required List<String> dependencies}) = _$_WidgetbookUseCaseBuilderData;

  factory _WidgetbookUseCaseBuilderData.fromJson(Map<String, dynamic> json) =
      _$_WidgetbookUseCaseBuilderData.fromJson;

  @override
  String get name;
  @override
  String get importStatement;
  @override
  List<String> get dependencies;
  @override
  @JsonKey(ignore: true)
  _$WidgetbookUseCaseBuilderDataCopyWith<_WidgetbookUseCaseBuilderData>
      get copyWith => throw _privateConstructorUsedError;
}
