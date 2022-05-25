// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'devices_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DevicesState {
  List<Device> get devices => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DevicesStateCopyWith<DevicesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DevicesStateCopyWith<$Res> {
  factory $DevicesStateCopyWith(
          DevicesState value, $Res Function(DevicesState) then) =
      _$DevicesStateCopyWithImpl<$Res>;
  $Res call({List<Device> devices});
}

/// @nodoc
class _$DevicesStateCopyWithImpl<$Res> implements $DevicesStateCopyWith<$Res> {
  _$DevicesStateCopyWithImpl(this._value, this._then);

  final DevicesState _value;
  // ignore: unused_field
  final $Res Function(DevicesState) _then;

  @override
  $Res call({
    Object? devices = freezed,
  }) {
    return _then(_value.copyWith(
      devices: devices == freezed
          ? _value.devices
          : devices // ignore: cast_nullable_to_non_nullable
              as List<Device>,
    ));
  }
}

/// @nodoc
abstract class _$$_DevicesStateCopyWith<$Res>
    implements $DevicesStateCopyWith<$Res> {
  factory _$$_DevicesStateCopyWith(
          _$_DevicesState value, $Res Function(_$_DevicesState) then) =
      __$$_DevicesStateCopyWithImpl<$Res>;
  @override
  $Res call({List<Device> devices});
}

/// @nodoc
class __$$_DevicesStateCopyWithImpl<$Res>
    extends _$DevicesStateCopyWithImpl<$Res>
    implements _$$_DevicesStateCopyWith<$Res> {
  __$$_DevicesStateCopyWithImpl(
      _$_DevicesState _value, $Res Function(_$_DevicesState) _then)
      : super(_value, (v) => _then(v as _$_DevicesState));

  @override
  _$_DevicesState get _value => super._value as _$_DevicesState;

  @override
  $Res call({
    Object? devices = freezed,
  }) {
    return _then(_$_DevicesState(
      devices: devices == freezed
          ? _value._devices
          : devices // ignore: cast_nullable_to_non_nullable
              as List<Device>,
    ));
  }
}

/// @nodoc

class _$_DevicesState implements _DevicesState {
  _$_DevicesState({required final List<Device> devices}) : _devices = devices;

  final List<Device> _devices;
  @override
  List<Device> get devices {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_devices);
  }

  @override
  String toString() {
    return 'DevicesState(devices: $devices)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DevicesState &&
            const DeepCollectionEquality().equals(other._devices, _devices));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_devices));

  @JsonKey(ignore: true)
  @override
  _$$_DevicesStateCopyWith<_$_DevicesState> get copyWith =>
      __$$_DevicesStateCopyWithImpl<_$_DevicesState>(this, _$identity);
}

abstract class _DevicesState implements DevicesState {
  factory _DevicesState({required final List<Device> devices}) =
      _$_DevicesState;

  @override
  List<Device> get devices => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_DevicesStateCopyWith<_$_DevicesState> get copyWith =>
      throw _privateConstructorUsedError;
}
