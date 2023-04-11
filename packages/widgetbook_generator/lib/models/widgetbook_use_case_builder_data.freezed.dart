// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'widgetbook_use_case_builder_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WidgetbookUseCaseBuilderData _$WidgetbookUseCaseBuilderDataFromJson(
    Map<String, dynamic> json) {
  return _WidgetbookUseCaseBuilderData.fromJson(json);
}

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
      _$WidgetbookUseCaseBuilderDataCopyWithImpl<$Res,
          WidgetbookUseCaseBuilderData>;
  @useResult
  $Res call({String name, String importStatement, List<String> dependencies});
}

/// @nodoc
class _$WidgetbookUseCaseBuilderDataCopyWithImpl<$Res,
        $Val extends WidgetbookUseCaseBuilderData>
    implements $WidgetbookUseCaseBuilderDataCopyWith<$Res> {
  _$WidgetbookUseCaseBuilderDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? importStatement = null,
    Object? dependencies = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      importStatement: null == importStatement
          ? _value.importStatement
          : importStatement // ignore: cast_nullable_to_non_nullable
              as String,
      dependencies: null == dependencies
          ? _value.dependencies
          : dependencies // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WidgetbookUseCaseBuilderDataCopyWith<$Res>
    implements $WidgetbookUseCaseBuilderDataCopyWith<$Res> {
  factory _$$_WidgetbookUseCaseBuilderDataCopyWith(
          _$_WidgetbookUseCaseBuilderData value,
          $Res Function(_$_WidgetbookUseCaseBuilderData) then) =
      __$$_WidgetbookUseCaseBuilderDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String importStatement, List<String> dependencies});
}

/// @nodoc
class __$$_WidgetbookUseCaseBuilderDataCopyWithImpl<$Res>
    extends _$WidgetbookUseCaseBuilderDataCopyWithImpl<$Res,
        _$_WidgetbookUseCaseBuilderData>
    implements _$$_WidgetbookUseCaseBuilderDataCopyWith<$Res> {
  __$$_WidgetbookUseCaseBuilderDataCopyWithImpl(
      _$_WidgetbookUseCaseBuilderData _value,
      $Res Function(_$_WidgetbookUseCaseBuilderData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? importStatement = null,
    Object? dependencies = null,
  }) {
    return _then(_$_WidgetbookUseCaseBuilderData(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      importStatement: null == importStatement
          ? _value.importStatement
          : importStatement // ignore: cast_nullable_to_non_nullable
              as String,
      dependencies: null == dependencies
          ? _value._dependencies
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
      required final List<String> dependencies})
      : _dependencies = dependencies;

  factory _$_WidgetbookUseCaseBuilderData.fromJson(Map<String, dynamic> json) =>
      _$$_WidgetbookUseCaseBuilderDataFromJson(json);

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
    return 'WidgetbookUseCaseBuilderData(name: $name, importStatement: $importStatement, dependencies: $dependencies)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WidgetbookUseCaseBuilderData &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.importStatement, importStatement) ||
                other.importStatement == importStatement) &&
            const DeepCollectionEquality()
                .equals(other._dependencies, _dependencies));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, importStatement,
      const DeepCollectionEquality().hash(_dependencies));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WidgetbookUseCaseBuilderDataCopyWith<_$_WidgetbookUseCaseBuilderData>
      get copyWith => __$$_WidgetbookUseCaseBuilderDataCopyWithImpl<
          _$_WidgetbookUseCaseBuilderData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WidgetbookUseCaseBuilderDataToJson(
      this,
    );
  }
}

abstract class _WidgetbookUseCaseBuilderData
    implements WidgetbookUseCaseBuilderData {
  factory _WidgetbookUseCaseBuilderData(
          {required final String name,
          required final String importStatement,
          required final List<String> dependencies}) =
      _$_WidgetbookUseCaseBuilderData;

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
  _$$_WidgetbookUseCaseBuilderDataCopyWith<_$_WidgetbookUseCaseBuilderData>
      get copyWith => throw _privateConstructorUsedError;
}
