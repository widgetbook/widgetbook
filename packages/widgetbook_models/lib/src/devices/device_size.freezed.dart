// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'device_size.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$DeviceSizeTearOff {
  const _$DeviceSizeTearOff();

  _DeviceSize call({required double width, required double height}) {
    return _DeviceSize(
      width: width,
      height: height,
    );
  }
}

/// @nodoc
const $DeviceSize = _$DeviceSizeTearOff();

/// @nodoc
mixin _$DeviceSize {
  /// Width of the device
  double get width => throw _privateConstructorUsedError;

  /// Height of the device
  double get height => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DeviceSizeCopyWith<DeviceSize> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceSizeCopyWith<$Res> {
  factory $DeviceSizeCopyWith(
          DeviceSize value, $Res Function(DeviceSize) then) =
      _$DeviceSizeCopyWithImpl<$Res>;
  $Res call({double width, double height});
}

/// @nodoc
class _$DeviceSizeCopyWithImpl<$Res> implements $DeviceSizeCopyWith<$Res> {
  _$DeviceSizeCopyWithImpl(this._value, this._then);

  final DeviceSize _value;
  // ignore: unused_field
  final $Res Function(DeviceSize) _then;

  @override
  $Res call({
    Object? width = freezed,
    Object? height = freezed,
  }) {
    return _then(_value.copyWith(
      width: width == freezed
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as double,
      height: height == freezed
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
abstract class _$DeviceSizeCopyWith<$Res> implements $DeviceSizeCopyWith<$Res> {
  factory _$DeviceSizeCopyWith(
          _DeviceSize value, $Res Function(_DeviceSize) then) =
      __$DeviceSizeCopyWithImpl<$Res>;
  @override
  $Res call({double width, double height});
}

/// @nodoc
class __$DeviceSizeCopyWithImpl<$Res> extends _$DeviceSizeCopyWithImpl<$Res>
    implements _$DeviceSizeCopyWith<$Res> {
  __$DeviceSizeCopyWithImpl(
      _DeviceSize _value, $Res Function(_DeviceSize) _then)
      : super(_value, (v) => _then(v as _DeviceSize));

  @override
  _DeviceSize get _value => super._value as _DeviceSize;

  @override
  $Res call({
    Object? width = freezed,
    Object? height = freezed,
  }) {
    return _then(_DeviceSize(
      width: width == freezed
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as double,
      height: height == freezed
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$_DeviceSize extends _DeviceSize {
  const _$_DeviceSize({required this.width, required this.height}) : super._();

  @override

  /// Width of the device
  final double width;
  @override

  /// Height of the device
  final double height;

  @override
  String toString() {
    return 'DeviceSize(width: $width, height: $height)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DeviceSize &&
            const DeepCollectionEquality().equals(other.width, width) &&
            const DeepCollectionEquality().equals(other.height, height));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(width),
      const DeepCollectionEquality().hash(height));

  @JsonKey(ignore: true)
  @override
  _$DeviceSizeCopyWith<_DeviceSize> get copyWith =>
      __$DeviceSizeCopyWithImpl<_DeviceSize>(this, _$identity);
}

abstract class _DeviceSize extends DeviceSize {
  const factory _DeviceSize({required double width, required double height}) =
      _$_DeviceSize;
  const _DeviceSize._() : super._();

  @override

  /// Width of the device
  double get width;
  @override

  /// Height of the device
  double get height;
  @override
  @JsonKey(ignore: true)
  _$DeviceSizeCopyWith<_DeviceSize> get copyWith =>
      throw _privateConstructorUsedError;
}
