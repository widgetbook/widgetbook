// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'widgetbook_scaffold_builder_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WidgetbookScaffoldBuilderData _$WidgetbookScaffoldBuilderDataFromJson(
    Map<String, dynamic> json) {
  return _WidgetbookScaffoldBuilderData.fromJson(json);
}

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
abstract class _$$_WidgetbookScaffoldBuilderDataCopyWith<$Res>
    implements $WidgetbookScaffoldBuilderDataCopyWith<$Res> {
  factory _$$_WidgetbookScaffoldBuilderDataCopyWith(
          _$_WidgetbookScaffoldBuilderData value,
          $Res Function(_$_WidgetbookScaffoldBuilderData) then) =
      __$$_WidgetbookScaffoldBuilderDataCopyWithImpl<$Res>;
  @override
  $Res call({String name, String importStatement, List<String> dependencies});
}

/// @nodoc
class __$$_WidgetbookScaffoldBuilderDataCopyWithImpl<$Res>
    extends _$WidgetbookScaffoldBuilderDataCopyWithImpl<$Res>
    implements _$$_WidgetbookScaffoldBuilderDataCopyWith<$Res> {
  __$$_WidgetbookScaffoldBuilderDataCopyWithImpl(
      _$_WidgetbookScaffoldBuilderData _value,
      $Res Function(_$_WidgetbookScaffoldBuilderData) _then)
      : super(_value, (v) => _then(v as _$_WidgetbookScaffoldBuilderData));

  @override
  _$_WidgetbookScaffoldBuilderData get _value =>
      super._value as _$_WidgetbookScaffoldBuilderData;

  @override
  $Res call({
    Object? name = freezed,
    Object? importStatement = freezed,
    Object? dependencies = freezed,
  }) {
    return _then(_$_WidgetbookScaffoldBuilderData(
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
      required final List<String> dependencies})
      : _dependencies = dependencies;

  factory _$_WidgetbookScaffoldBuilderData.fromJson(
          Map<String, dynamic> json) =>
      _$$_WidgetbookScaffoldBuilderDataFromJson(json);

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
  String toString() {
    return 'WidgetbookScaffoldBuilderData(name: $name, importStatement: $importStatement, dependencies: $dependencies)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WidgetbookScaffoldBuilderData &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.importStatement, importStatement) &&
            const DeepCollectionEquality()
                .equals(other._dependencies, _dependencies));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(importStatement),
      const DeepCollectionEquality().hash(_dependencies));

  @JsonKey(ignore: true)
  @override
  _$$_WidgetbookScaffoldBuilderDataCopyWith<_$_WidgetbookScaffoldBuilderData>
      get copyWith => __$$_WidgetbookScaffoldBuilderDataCopyWithImpl<
          _$_WidgetbookScaffoldBuilderData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WidgetbookScaffoldBuilderDataToJson(this);
  }
}

abstract class _WidgetbookScaffoldBuilderData
    implements WidgetbookScaffoldBuilderData {
  factory _WidgetbookScaffoldBuilderData(
          {required final String name,
          required final String importStatement,
          required final List<String> dependencies}) =
      _$_WidgetbookScaffoldBuilderData;

  factory _WidgetbookScaffoldBuilderData.fromJson(Map<String, dynamic> json) =
      _$_WidgetbookScaffoldBuilderData.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get importStatement => throw _privateConstructorUsedError;
  @override
  List<String> get dependencies => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_WidgetbookScaffoldBuilderDataCopyWith<_$_WidgetbookScaffoldBuilderData>
      get copyWith => throw _privateConstructorUsedError;
}
