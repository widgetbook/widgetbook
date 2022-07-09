// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'device_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DeviceData _$DeviceDataFromJson(Map<String, dynamic> json) {
  return _DeviceData.fromJson(json);
}

/// @nodoc
mixin _$DeviceData {
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DeviceDataCopyWith<DeviceData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceDataCopyWith<$Res> {
  factory $DeviceDataCopyWith(
          DeviceData value, $Res Function(DeviceData) then) =
      _$DeviceDataCopyWithImpl<$Res>;
  $Res call({String name});
}

/// @nodoc
class _$DeviceDataCopyWithImpl<$Res> implements $DeviceDataCopyWith<$Res> {
  _$DeviceDataCopyWithImpl(this._value, this._then);

  final DeviceData _value;
  // ignore: unused_field
  final $Res Function(DeviceData) _then;

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
abstract class _$$_DeviceDataCopyWith<$Res>
    implements $DeviceDataCopyWith<$Res> {
  factory _$$_DeviceDataCopyWith(
          _$_DeviceData value, $Res Function(_$_DeviceData) then) =
      __$$_DeviceDataCopyWithImpl<$Res>;
  @override
  $Res call({String name});
}

/// @nodoc
class __$$_DeviceDataCopyWithImpl<$Res> extends _$DeviceDataCopyWithImpl<$Res>
    implements _$$_DeviceDataCopyWith<$Res> {
  __$$_DeviceDataCopyWithImpl(
      _$_DeviceData _value, $Res Function(_$_DeviceData) _then)
      : super(_value, (v) => _then(v as _$_DeviceData));

  @override
  _$_DeviceData get _value => super._value as _$_DeviceData;

  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_$_DeviceData(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DeviceData implements _DeviceData {
  _$_DeviceData({required this.name});

  factory _$_DeviceData.fromJson(Map<String, dynamic> json) =>
      _$$_DeviceDataFromJson(json);

  @override
  final String name;

  @override
  String toString() {
    return 'DeviceData(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DeviceData &&
            const DeepCollectionEquality().equals(other.name, name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(name));

  @JsonKey(ignore: true)
  @override
  _$$_DeviceDataCopyWith<_$_DeviceData> get copyWith =>
      __$$_DeviceDataCopyWithImpl<_$_DeviceData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DeviceDataToJson(this);
  }
}

abstract class _DeviceData implements DeviceData {
  factory _DeviceData({required final String name}) = _$_DeviceData;

  factory _DeviceData.fromJson(Map<String, dynamic> json) =
      _$_DeviceData.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_DeviceDataCopyWith<_$_DeviceData> get copyWith =>
      throw _privateConstructorUsedError;
}
