// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'widgetbook_addon_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WidgetbookAddonData _$WidgetbookAddonDataFromJson(Map<String, dynamic> json) {
  return _WidgetbookAddonData.fromJson(json);
}

/// @nodoc
mixin _$WidgetbookAddonData {
  /// The (type) name of the annotated element
  String get name => throw _privateConstructorUsedError;

  /// The name of the setting variable
  String get variableName => throw _privateConstructorUsedError;
  String get importStatement => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WidgetbookAddonDataCopyWith<WidgetbookAddonData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WidgetbookAddonDataCopyWith<$Res> {
  factory $WidgetbookAddonDataCopyWith(
          WidgetbookAddonData value, $Res Function(WidgetbookAddonData) then) =
      _$WidgetbookAddonDataCopyWithImpl<$Res, WidgetbookAddonData>;
  @useResult
  $Res call({String name, String variableName, String importStatement});
}

/// @nodoc
class _$WidgetbookAddonDataCopyWithImpl<$Res, $Val extends WidgetbookAddonData>
    implements $WidgetbookAddonDataCopyWith<$Res> {
  _$WidgetbookAddonDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? variableName = null,
    Object? importStatement = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      variableName: null == variableName
          ? _value.variableName
          : variableName // ignore: cast_nullable_to_non_nullable
              as String,
      importStatement: null == importStatement
          ? _value.importStatement
          : importStatement // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WidgetbookAddonDataCopyWith<$Res>
    implements $WidgetbookAddonDataCopyWith<$Res> {
  factory _$$_WidgetbookAddonDataCopyWith(_$_WidgetbookAddonData value,
          $Res Function(_$_WidgetbookAddonData) then) =
      __$$_WidgetbookAddonDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String variableName, String importStatement});
}

/// @nodoc
class __$$_WidgetbookAddonDataCopyWithImpl<$Res>
    extends _$WidgetbookAddonDataCopyWithImpl<$Res, _$_WidgetbookAddonData>
    implements _$$_WidgetbookAddonDataCopyWith<$Res> {
  __$$_WidgetbookAddonDataCopyWithImpl(_$_WidgetbookAddonData _value,
      $Res Function(_$_WidgetbookAddonData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? variableName = null,
    Object? importStatement = null,
  }) {
    return _then(_$_WidgetbookAddonData(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      variableName: null == variableName
          ? _value.variableName
          : variableName // ignore: cast_nullable_to_non_nullable
              as String,
      importStatement: null == importStatement
          ? _value.importStatement
          : importStatement // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WidgetbookAddonData implements _WidgetbookAddonData {
  _$_WidgetbookAddonData(
      {required this.name,
      required this.variableName,
      required this.importStatement});

  factory _$_WidgetbookAddonData.fromJson(Map<String, dynamic> json) =>
      _$$_WidgetbookAddonDataFromJson(json);

  /// The (type) name of the annotated element
  @override
  final String name;

  /// The name of the setting variable
  @override
  final String variableName;
  @override
  final String importStatement;

  @override
  String toString() {
    return 'WidgetbookAddonData(name: $name, variableName: $variableName, importStatement: $importStatement)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WidgetbookAddonData &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.variableName, variableName) ||
                other.variableName == variableName) &&
            (identical(other.importStatement, importStatement) ||
                other.importStatement == importStatement));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, variableName, importStatement);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WidgetbookAddonDataCopyWith<_$_WidgetbookAddonData> get copyWith =>
      __$$_WidgetbookAddonDataCopyWithImpl<_$_WidgetbookAddonData>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WidgetbookAddonDataToJson(
      this,
    );
  }
}

abstract class _WidgetbookAddonData implements WidgetbookAddonData {
  factory _WidgetbookAddonData(
      {required final String name,
      required final String variableName,
      required final String importStatement}) = _$_WidgetbookAddonData;

  factory _WidgetbookAddonData.fromJson(Map<String, dynamic> json) =
      _$_WidgetbookAddonData.fromJson;

  @override

  /// The (type) name of the annotated element
  String get name;
  @override

  /// The name of the setting variable
  String get variableName;
  @override
  String get importStatement;
  @override
  @JsonKey(ignore: true)
  _$$_WidgetbookAddonDataCopyWith<_$_WidgetbookAddonData> get copyWith =>
      throw _privateConstructorUsedError;
}
