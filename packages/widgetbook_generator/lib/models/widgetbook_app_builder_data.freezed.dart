// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'widgetbook_app_builder_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WidgetbookAppBuilderData _$WidgetbookAppBuilderDataFromJson(
    Map<String, dynamic> json) {
  return _WidgetbookAppBuilderData.fromJson(json);
}

/// @nodoc
mixin _$WidgetbookAppBuilderData {
  String get name => throw _privateConstructorUsedError;
  String get importStatement => throw _privateConstructorUsedError;
  List<String> get dependencies => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WidgetbookAppBuilderDataCopyWith<WidgetbookAppBuilderData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WidgetbookAppBuilderDataCopyWith<$Res> {
  factory $WidgetbookAppBuilderDataCopyWith(WidgetbookAppBuilderData value,
          $Res Function(WidgetbookAppBuilderData) then) =
      _$WidgetbookAppBuilderDataCopyWithImpl<$Res, WidgetbookAppBuilderData>;
  @useResult
  $Res call({String name, String importStatement, List<String> dependencies});
}

/// @nodoc
class _$WidgetbookAppBuilderDataCopyWithImpl<$Res,
        $Val extends WidgetbookAppBuilderData>
    implements $WidgetbookAppBuilderDataCopyWith<$Res> {
  _$WidgetbookAppBuilderDataCopyWithImpl(this._value, this._then);

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
abstract class _$$_WidgetbookAppBuilderDataCopyWith<$Res>
    implements $WidgetbookAppBuilderDataCopyWith<$Res> {
  factory _$$_WidgetbookAppBuilderDataCopyWith(
          _$_WidgetbookAppBuilderData value,
          $Res Function(_$_WidgetbookAppBuilderData) then) =
      __$$_WidgetbookAppBuilderDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String importStatement, List<String> dependencies});
}

/// @nodoc
class __$$_WidgetbookAppBuilderDataCopyWithImpl<$Res>
    extends _$WidgetbookAppBuilderDataCopyWithImpl<$Res,
        _$_WidgetbookAppBuilderData>
    implements _$$_WidgetbookAppBuilderDataCopyWith<$Res> {
  __$$_WidgetbookAppBuilderDataCopyWithImpl(_$_WidgetbookAppBuilderData _value,
      $Res Function(_$_WidgetbookAppBuilderData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? importStatement = null,
    Object? dependencies = null,
  }) {
    return _then(_$_WidgetbookAppBuilderData(
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
class _$_WidgetbookAppBuilderData implements _WidgetbookAppBuilderData {
  _$_WidgetbookAppBuilderData(
      {required this.name,
      required this.importStatement,
      required final List<String> dependencies})
      : _dependencies = dependencies;

  factory _$_WidgetbookAppBuilderData.fromJson(Map<String, dynamic> json) =>
      _$$_WidgetbookAppBuilderDataFromJson(json);

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
    return 'WidgetbookAppBuilderData(name: $name, importStatement: $importStatement, dependencies: $dependencies)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WidgetbookAppBuilderData &&
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
  _$$_WidgetbookAppBuilderDataCopyWith<_$_WidgetbookAppBuilderData>
      get copyWith => __$$_WidgetbookAppBuilderDataCopyWithImpl<
          _$_WidgetbookAppBuilderData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WidgetbookAppBuilderDataToJson(
      this,
    );
  }
}

abstract class _WidgetbookAppBuilderData implements WidgetbookAppBuilderData {
  factory _WidgetbookAppBuilderData(
      {required final String name,
      required final String importStatement,
      required final List<String> dependencies}) = _$_WidgetbookAppBuilderData;

  factory _WidgetbookAppBuilderData.fromJson(Map<String, dynamic> json) =
      _$_WidgetbookAppBuilderData.fromJson;

  @override
  String get name;
  @override
  String get importStatement;
  @override
  List<String> get dependencies;
  @override
  @JsonKey(ignore: true)
  _$$_WidgetbookAppBuilderDataCopyWith<_$_WidgetbookAppBuilderData>
      get copyWith => throw _privateConstructorUsedError;
}
