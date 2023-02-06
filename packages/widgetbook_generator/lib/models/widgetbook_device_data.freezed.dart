// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'widgetbook_device_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WidgetbookDeviceData _$WidgetbookDeviceDataFromJson(Map<String, dynamic> json) {
  return _WidgetbookDeviceData.fromJson(json);
}

/// @nodoc
mixin _$WidgetbookDeviceData {
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WidgetbookDeviceDataCopyWith<WidgetbookDeviceData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WidgetbookDeviceDataCopyWith<$Res> {
  factory $WidgetbookDeviceDataCopyWith(WidgetbookDeviceData value,
          $Res Function(WidgetbookDeviceData) then) =
      _$WidgetbookDeviceDataCopyWithImpl<$Res>;
  $Res call({String name});
}

/// @nodoc
class _$WidgetbookDeviceDataCopyWithImpl<$Res>
    implements $WidgetbookDeviceDataCopyWith<$Res> {
  _$WidgetbookDeviceDataCopyWithImpl(this._value, this._then);

  final WidgetbookDeviceData _value;
  // ignore: unused_field
  final $Res Function(WidgetbookDeviceData) _then;

  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_WidgetbookDeviceDataCopyWith<$Res>
    implements $WidgetbookDeviceDataCopyWith<$Res> {
  factory _$$_WidgetbookDeviceDataCopyWith(_$_WidgetbookDeviceData value,
          $Res Function(_$_WidgetbookDeviceData) then) =
      __$$_WidgetbookDeviceDataCopyWithImpl<$Res>;
  @override
  $Res call({String name});
}

/// @nodoc
class __$$_WidgetbookDeviceDataCopyWithImpl<$Res>
    extends _$WidgetbookDeviceDataCopyWithImpl<$Res>
    implements _$$_WidgetbookDeviceDataCopyWith<$Res> {
  __$$_WidgetbookDeviceDataCopyWithImpl(_$_WidgetbookDeviceData _value,
      $Res Function(_$_WidgetbookDeviceData) _then)
      : super(_value, (v) => _then(v as _$_WidgetbookDeviceData));

  @override
  _$_WidgetbookDeviceData get _value => super._value as _$_WidgetbookDeviceData;

  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_$_WidgetbookDeviceData(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WidgetbookDeviceData implements _WidgetbookDeviceData {
  _$_WidgetbookDeviceData({required this.name});

  factory _$_WidgetbookDeviceData.fromJson(Map<String, dynamic> json) =>
      _$$_WidgetbookDeviceDataFromJson(json);

  @override
  final String name;

  @override
  String toString() {
    return 'WidgetbookDeviceData(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WidgetbookDeviceData &&
            const DeepCollectionEquality().equals(other.name, name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(name));

  @JsonKey(ignore: true)
  @override
  _$$_WidgetbookDeviceDataCopyWith<_$_WidgetbookDeviceData> get copyWith =>
      __$$_WidgetbookDeviceDataCopyWithImpl<_$_WidgetbookDeviceData>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WidgetbookDeviceDataToJson(this);
  }
}

abstract class _WidgetbookDeviceData implements WidgetbookDeviceData {
  factory _WidgetbookDeviceData({required final String name}) =
      _$_WidgetbookDeviceData;

  factory _WidgetbookDeviceData.fromJson(Map<String, dynamic> json) =
      _$_WidgetbookDeviceData.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_WidgetbookDeviceDataCopyWith<_$_WidgetbookDeviceData> get copyWith =>
      throw _privateConstructorUsedError;
}
