// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'widgetbook_device_frame_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WidgetbookDeviceFrameData _$WidgetbookDeviceFrameDataFromJson(
    Map<String, dynamic> json) {
  return _WidgetbookDeviceFrameData.fromJson(json);
}

/// @nodoc
mixin _$WidgetbookDeviceFrameData {
  String get name => throw _privateConstructorUsedError;
  String get importStatement => throw _privateConstructorUsedError;
  List<String> get dependencies => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WidgetbookDeviceFrameDataCopyWith<WidgetbookDeviceFrameData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WidgetbookDeviceFrameDataCopyWith<$Res> {
  factory $WidgetbookDeviceFrameDataCopyWith(WidgetbookDeviceFrameData value,
          $Res Function(WidgetbookDeviceFrameData) then) =
      _$WidgetbookDeviceFrameDataCopyWithImpl<$Res>;
  $Res call({String name, String importStatement, List<String> dependencies});
}

/// @nodoc
class _$WidgetbookDeviceFrameDataCopyWithImpl<$Res>
    implements $WidgetbookDeviceFrameDataCopyWith<$Res> {
  _$WidgetbookDeviceFrameDataCopyWithImpl(this._value, this._then);

  final WidgetbookDeviceFrameData _value;
  // ignore: unused_field
  final $Res Function(WidgetbookDeviceFrameData) _then;

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
abstract class _$$_WidgetbookDeviceFrameDataCopyWith<$Res>
    implements $WidgetbookDeviceFrameDataCopyWith<$Res> {
  factory _$$_WidgetbookDeviceFrameDataCopyWith(
          _$_WidgetbookDeviceFrameData value,
          $Res Function(_$_WidgetbookDeviceFrameData) then) =
      __$$_WidgetbookDeviceFrameDataCopyWithImpl<$Res>;
  @override
  $Res call({String name, String importStatement, List<String> dependencies});
}

/// @nodoc
class __$$_WidgetbookDeviceFrameDataCopyWithImpl<$Res>
    extends _$WidgetbookDeviceFrameDataCopyWithImpl<$Res>
    implements _$$_WidgetbookDeviceFrameDataCopyWith<$Res> {
  __$$_WidgetbookDeviceFrameDataCopyWithImpl(
      _$_WidgetbookDeviceFrameData _value,
      $Res Function(_$_WidgetbookDeviceFrameData) _then)
      : super(_value, (v) => _then(v as _$_WidgetbookDeviceFrameData));

  @override
  _$_WidgetbookDeviceFrameData get _value =>
      super._value as _$_WidgetbookDeviceFrameData;

  @override
  $Res call({
    Object? name = freezed,
    Object? importStatement = freezed,
    Object? dependencies = freezed,
  }) {
    return _then(_$_WidgetbookDeviceFrameData(
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
class _$_WidgetbookDeviceFrameData implements _WidgetbookDeviceFrameData {
  _$_WidgetbookDeviceFrameData(
      {required this.name,
      required this.importStatement,
      required final List<String> dependencies})
      : _dependencies = dependencies;

  factory _$_WidgetbookDeviceFrameData.fromJson(Map<String, dynamic> json) =>
      _$$_WidgetbookDeviceFrameDataFromJson(json);

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
    return 'WidgetbookDeviceFrameData(name: $name, importStatement: $importStatement, dependencies: $dependencies)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WidgetbookDeviceFrameData &&
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
  _$$_WidgetbookDeviceFrameDataCopyWith<_$_WidgetbookDeviceFrameData>
      get copyWith => __$$_WidgetbookDeviceFrameDataCopyWithImpl<
          _$_WidgetbookDeviceFrameData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WidgetbookDeviceFrameDataToJson(this);
  }
}

abstract class _WidgetbookDeviceFrameData implements WidgetbookDeviceFrameData {
  factory _WidgetbookDeviceFrameData(
      {required final String name,
      required final String importStatement,
      required final List<String> dependencies}) = _$_WidgetbookDeviceFrameData;

  factory _WidgetbookDeviceFrameData.fromJson(Map<String, dynamic> json) =
      _$_WidgetbookDeviceFrameData.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get importStatement => throw _privateConstructorUsedError;
  @override
  List<String> get dependencies => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_WidgetbookDeviceFrameDataCopyWith<_$_WidgetbookDeviceFrameData>
      get copyWith => throw _privateConstructorUsedError;
}
