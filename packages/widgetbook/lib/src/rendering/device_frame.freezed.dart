// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'device_frame.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$DeviceFrameTearOff {
  const _$DeviceFrameTearOff();

  _DeviceFrame call({required String name, required bool allowsDevices}) {
    return _DeviceFrame(
      name: name,
      allowsDevices: allowsDevices,
    );
  }
}

/// @nodoc
const $DeviceFrame = _$DeviceFrameTearOff();

/// @nodoc
mixin _$DeviceFrame {
  /// The name displayed as a tooltip
  String get name => throw _privateConstructorUsedError;

  /// Indicators whether this mode supports specific devices e.g. iPhone 11
  bool get allowsDevices => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DeviceFrameCopyWith<DeviceFrame> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceFrameCopyWith<$Res> {
  factory $DeviceFrameCopyWith(
          DeviceFrame value, $Res Function(DeviceFrame) then) =
      _$DeviceFrameCopyWithImpl<$Res>;
  $Res call({String name, bool allowsDevices});
}

/// @nodoc
class _$DeviceFrameCopyWithImpl<$Res> implements $DeviceFrameCopyWith<$Res> {
  _$DeviceFrameCopyWithImpl(this._value, this._then);

  final DeviceFrame _value;
  // ignore: unused_field
  final $Res Function(DeviceFrame) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? allowsDevices = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      allowsDevices: allowsDevices == freezed
          ? _value.allowsDevices
          : allowsDevices // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$DeviceFrameCopyWith<$Res>
    implements $DeviceFrameCopyWith<$Res> {
  factory _$DeviceFrameCopyWith(
          _DeviceFrame value, $Res Function(_DeviceFrame) then) =
      __$DeviceFrameCopyWithImpl<$Res>;
  @override
  $Res call({String name, bool allowsDevices});
}

/// @nodoc
class __$DeviceFrameCopyWithImpl<$Res> extends _$DeviceFrameCopyWithImpl<$Res>
    implements _$DeviceFrameCopyWith<$Res> {
  __$DeviceFrameCopyWithImpl(
      _DeviceFrame _value, $Res Function(_DeviceFrame) _then)
      : super(_value, (v) => _then(v as _DeviceFrame));

  @override
  _DeviceFrame get _value => super._value as _DeviceFrame;

  @override
  $Res call({
    Object? name = freezed,
    Object? allowsDevices = freezed,
  }) {
    return _then(_DeviceFrame(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      allowsDevices: allowsDevices == freezed
          ? _value.allowsDevices
          : allowsDevices // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_DeviceFrame implements _DeviceFrame {
  const _$_DeviceFrame({required this.name, required this.allowsDevices});

  @override

  /// The name displayed as a tooltip
  final String name;
  @override

  /// Indicators whether this mode supports specific devices e.g. iPhone 11
  final bool allowsDevices;

  @override
  String toString() {
    return 'DeviceFrame(name: $name, allowsDevices: $allowsDevices)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DeviceFrame &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.allowsDevices, allowsDevices));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(allowsDevices));

  @JsonKey(ignore: true)
  @override
  _$DeviceFrameCopyWith<_DeviceFrame> get copyWith =>
      __$DeviceFrameCopyWithImpl<_DeviceFrame>(this, _$identity);
}

abstract class _DeviceFrame implements DeviceFrame {
  const factory _DeviceFrame(
      {required String name, required bool allowsDevices}) = _$_DeviceFrame;

  @override

  /// The name displayed as a tooltip
  String get name;
  @override

  /// Indicators whether this mode supports specific devices e.g. iPhone 11
  bool get allowsDevices;
  @override
  @JsonKey(ignore: true)
  _$DeviceFrameCopyWith<_DeviceFrame> get copyWith =>
      throw _privateConstructorUsedError;
}
