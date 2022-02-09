// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'device.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$DeviceTearOff {
  const _$DeviceTearOff();

  _Device call(
      {required String name,
      required Resolution resolution,
      required DeviceType type}) {
    return _Device(
      name: name,
      resolution: resolution,
      type: type,
    );
  }

  _DeviceWatch watch(
      {required String name,
      required Resolution resolution,
      DeviceType type = DeviceType.watch}) {
    return _DeviceWatch(
      name: name,
      resolution: resolution,
      type: type,
    );
  }

  _DeviceMobile mobile(
      {required String name,
      required Resolution resolution,
      DeviceType type = DeviceType.mobile}) {
    return _DeviceMobile(
      name: name,
      resolution: resolution,
      type: type,
    );
  }

  _DeviceTablet tablet(
      {required String name,
      required Resolution resolution,
      DeviceType type = DeviceType.tablet}) {
    return _DeviceTablet(
      name: name,
      resolution: resolution,
      type: type,
    );
  }

  _DeviceDesktop desktop(
      {required String name,
      required Resolution resolution,
      DeviceType type = DeviceType.desktop}) {
    return _DeviceDesktop(
      name: name,
      resolution: resolution,
      type: type,
    );
  }

  _DeviceSpecial special(
      {required String name,
      required Resolution resolution,
      DeviceType type = DeviceType.unknown}) {
    return _DeviceSpecial(
      name: name,
      resolution: resolution,
      type: type,
    );
  }
}

/// @nodoc
const $Device = _$DeviceTearOff();

/// @nodoc
mixin _$Device {
  /// For example 'iPhone 12' or 'Samsung S10'.
  String get name => throw _privateConstructorUsedError;

  /// Specifies the native resolution (of the device screen)
  /// and the logical resolution (for rendering a preview on the device).
  Resolution get resolution => throw _privateConstructorUsedError;

  /// Categorizes the Device.
  /// For instance mobile or tablet.
  /// This is used to display an appropriate icon in the device bar.
  DeviceType get type => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String name, Resolution resolution, DeviceType type)
        $default, {
    required TResult Function(
            String name, Resolution resolution, DeviceType type)
        watch,
    required TResult Function(
            String name, Resolution resolution, DeviceType type)
        mobile,
    required TResult Function(
            String name, Resolution resolution, DeviceType type)
        tablet,
    required TResult Function(
            String name, Resolution resolution, DeviceType type)
        desktop,
    required TResult Function(
            String name, Resolution resolution, DeviceType type)
        special,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(String name, Resolution resolution, DeviceType type)?
        $default, {
    TResult Function(String name, Resolution resolution, DeviceType type)?
        watch,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        mobile,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        tablet,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        desktop,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        special,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String name, Resolution resolution, DeviceType type)?
        $default, {
    TResult Function(String name, Resolution resolution, DeviceType type)?
        watch,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        mobile,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        tablet,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        desktop,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        special,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Device value) $default, {
    required TResult Function(_DeviceWatch value) watch,
    required TResult Function(_DeviceMobile value) mobile,
    required TResult Function(_DeviceTablet value) tablet,
    required TResult Function(_DeviceDesktop value) desktop,
    required TResult Function(_DeviceSpecial value) special,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(_Device value)? $default, {
    TResult Function(_DeviceWatch value)? watch,
    TResult Function(_DeviceMobile value)? mobile,
    TResult Function(_DeviceTablet value)? tablet,
    TResult Function(_DeviceDesktop value)? desktop,
    TResult Function(_DeviceSpecial value)? special,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Device value)? $default, {
    TResult Function(_DeviceWatch value)? watch,
    TResult Function(_DeviceMobile value)? mobile,
    TResult Function(_DeviceTablet value)? tablet,
    TResult Function(_DeviceDesktop value)? desktop,
    TResult Function(_DeviceSpecial value)? special,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DeviceCopyWith<Device> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceCopyWith<$Res> {
  factory $DeviceCopyWith(Device value, $Res Function(Device) then) =
      _$DeviceCopyWithImpl<$Res>;
  $Res call({String name, Resolution resolution, DeviceType type});

  $ResolutionCopyWith<$Res> get resolution;
}

/// @nodoc
class _$DeviceCopyWithImpl<$Res> implements $DeviceCopyWith<$Res> {
  _$DeviceCopyWithImpl(this._value, this._then);

  final Device _value;
  // ignore: unused_field
  final $Res Function(Device) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? resolution = freezed,
    Object? type = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      resolution: resolution == freezed
          ? _value.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as Resolution,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as DeviceType,
    ));
  }

  @override
  $ResolutionCopyWith<$Res> get resolution {
    return $ResolutionCopyWith<$Res>(_value.resolution, (value) {
      return _then(_value.copyWith(resolution: value));
    });
  }
}

/// @nodoc
abstract class _$DeviceCopyWith<$Res> implements $DeviceCopyWith<$Res> {
  factory _$DeviceCopyWith(_Device value, $Res Function(_Device) then) =
      __$DeviceCopyWithImpl<$Res>;
  @override
  $Res call({String name, Resolution resolution, DeviceType type});

  @override
  $ResolutionCopyWith<$Res> get resolution;
}

/// @nodoc
class __$DeviceCopyWithImpl<$Res> extends _$DeviceCopyWithImpl<$Res>
    implements _$DeviceCopyWith<$Res> {
  __$DeviceCopyWithImpl(_Device _value, $Res Function(_Device) _then)
      : super(_value, (v) => _then(v as _Device));

  @override
  _Device get _value => super._value as _Device;

  @override
  $Res call({
    Object? name = freezed,
    Object? resolution = freezed,
    Object? type = freezed,
  }) {
    return _then(_Device(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      resolution: resolution == freezed
          ? _value.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as Resolution,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as DeviceType,
    ));
  }
}

/// @nodoc

class _$_Device extends _Device {
  const _$_Device(
      {required this.name, required this.resolution, required this.type})
      : super._();

  @override

  /// For example 'iPhone 12' or 'Samsung S10'.
  final String name;
  @override

  /// Specifies the native resolution (of the device screen)
  /// and the logical resolution (for rendering a preview on the device).
  final Resolution resolution;
  @override

  /// Categorizes the Device.
  /// For instance mobile or tablet.
  /// This is used to display an appropriate icon in the device bar.
  final DeviceType type;

  @override
  String toString() {
    return 'Device(name: $name, resolution: $resolution, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Device &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.resolution, resolution) &&
            const DeepCollectionEquality().equals(other.type, type));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(resolution),
      const DeepCollectionEquality().hash(type));

  @JsonKey(ignore: true)
  @override
  _$DeviceCopyWith<_Device> get copyWith =>
      __$DeviceCopyWithImpl<_Device>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String name, Resolution resolution, DeviceType type)
        $default, {
    required TResult Function(
            String name, Resolution resolution, DeviceType type)
        watch,
    required TResult Function(
            String name, Resolution resolution, DeviceType type)
        mobile,
    required TResult Function(
            String name, Resolution resolution, DeviceType type)
        tablet,
    required TResult Function(
            String name, Resolution resolution, DeviceType type)
        desktop,
    required TResult Function(
            String name, Resolution resolution, DeviceType type)
        special,
  }) {
    return $default(name, resolution, type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(String name, Resolution resolution, DeviceType type)?
        $default, {
    TResult Function(String name, Resolution resolution, DeviceType type)?
        watch,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        mobile,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        tablet,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        desktop,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        special,
  }) {
    return $default?.call(name, resolution, type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String name, Resolution resolution, DeviceType type)?
        $default, {
    TResult Function(String name, Resolution resolution, DeviceType type)?
        watch,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        mobile,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        tablet,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        desktop,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        special,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(name, resolution, type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Device value) $default, {
    required TResult Function(_DeviceWatch value) watch,
    required TResult Function(_DeviceMobile value) mobile,
    required TResult Function(_DeviceTablet value) tablet,
    required TResult Function(_DeviceDesktop value) desktop,
    required TResult Function(_DeviceSpecial value) special,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(_Device value)? $default, {
    TResult Function(_DeviceWatch value)? watch,
    TResult Function(_DeviceMobile value)? mobile,
    TResult Function(_DeviceTablet value)? tablet,
    TResult Function(_DeviceDesktop value)? desktop,
    TResult Function(_DeviceSpecial value)? special,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Device value)? $default, {
    TResult Function(_DeviceWatch value)? watch,
    TResult Function(_DeviceMobile value)? mobile,
    TResult Function(_DeviceTablet value)? tablet,
    TResult Function(_DeviceDesktop value)? desktop,
    TResult Function(_DeviceSpecial value)? special,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _Device extends Device {
  const factory _Device(
      {required String name,
      required Resolution resolution,
      required DeviceType type}) = _$_Device;
  const _Device._() : super._();

  @override

  /// For example 'iPhone 12' or 'Samsung S10'.
  String get name;
  @override

  /// Specifies the native resolution (of the device screen)
  /// and the logical resolution (for rendering a preview on the device).
  Resolution get resolution;
  @override

  /// Categorizes the Device.
  /// For instance mobile or tablet.
  /// This is used to display an appropriate icon in the device bar.
  DeviceType get type;
  @override
  @JsonKey(ignore: true)
  _$DeviceCopyWith<_Device> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$DeviceWatchCopyWith<$Res> implements $DeviceCopyWith<$Res> {
  factory _$DeviceWatchCopyWith(
          _DeviceWatch value, $Res Function(_DeviceWatch) then) =
      __$DeviceWatchCopyWithImpl<$Res>;
  @override
  $Res call({String name, Resolution resolution, DeviceType type});

  @override
  $ResolutionCopyWith<$Res> get resolution;
}

/// @nodoc
class __$DeviceWatchCopyWithImpl<$Res> extends _$DeviceCopyWithImpl<$Res>
    implements _$DeviceWatchCopyWith<$Res> {
  __$DeviceWatchCopyWithImpl(
      _DeviceWatch _value, $Res Function(_DeviceWatch) _then)
      : super(_value, (v) => _then(v as _DeviceWatch));

  @override
  _DeviceWatch get _value => super._value as _DeviceWatch;

  @override
  $Res call({
    Object? name = freezed,
    Object? resolution = freezed,
    Object? type = freezed,
  }) {
    return _then(_DeviceWatch(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      resolution: resolution == freezed
          ? _value.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as Resolution,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as DeviceType,
    ));
  }
}

/// @nodoc

class _$_DeviceWatch extends _DeviceWatch {
  const _$_DeviceWatch(
      {required this.name,
      required this.resolution,
      this.type = DeviceType.watch})
      : super._();

  @override
  final String name;
  @override
  final Resolution resolution;
  @JsonKey()
  @override
  final DeviceType type;

  @override
  String toString() {
    return 'Device.watch(name: $name, resolution: $resolution, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DeviceWatch &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.resolution, resolution) &&
            const DeepCollectionEquality().equals(other.type, type));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(resolution),
      const DeepCollectionEquality().hash(type));

  @JsonKey(ignore: true)
  @override
  _$DeviceWatchCopyWith<_DeviceWatch> get copyWith =>
      __$DeviceWatchCopyWithImpl<_DeviceWatch>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String name, Resolution resolution, DeviceType type)
        $default, {
    required TResult Function(
            String name, Resolution resolution, DeviceType type)
        watch,
    required TResult Function(
            String name, Resolution resolution, DeviceType type)
        mobile,
    required TResult Function(
            String name, Resolution resolution, DeviceType type)
        tablet,
    required TResult Function(
            String name, Resolution resolution, DeviceType type)
        desktop,
    required TResult Function(
            String name, Resolution resolution, DeviceType type)
        special,
  }) {
    return watch(name, resolution, type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(String name, Resolution resolution, DeviceType type)?
        $default, {
    TResult Function(String name, Resolution resolution, DeviceType type)?
        watch,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        mobile,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        tablet,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        desktop,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        special,
  }) {
    return watch?.call(name, resolution, type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String name, Resolution resolution, DeviceType type)?
        $default, {
    TResult Function(String name, Resolution resolution, DeviceType type)?
        watch,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        mobile,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        tablet,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        desktop,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        special,
    required TResult orElse(),
  }) {
    if (watch != null) {
      return watch(name, resolution, type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Device value) $default, {
    required TResult Function(_DeviceWatch value) watch,
    required TResult Function(_DeviceMobile value) mobile,
    required TResult Function(_DeviceTablet value) tablet,
    required TResult Function(_DeviceDesktop value) desktop,
    required TResult Function(_DeviceSpecial value) special,
  }) {
    return watch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(_Device value)? $default, {
    TResult Function(_DeviceWatch value)? watch,
    TResult Function(_DeviceMobile value)? mobile,
    TResult Function(_DeviceTablet value)? tablet,
    TResult Function(_DeviceDesktop value)? desktop,
    TResult Function(_DeviceSpecial value)? special,
  }) {
    return watch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Device value)? $default, {
    TResult Function(_DeviceWatch value)? watch,
    TResult Function(_DeviceMobile value)? mobile,
    TResult Function(_DeviceTablet value)? tablet,
    TResult Function(_DeviceDesktop value)? desktop,
    TResult Function(_DeviceSpecial value)? special,
    required TResult orElse(),
  }) {
    if (watch != null) {
      return watch(this);
    }
    return orElse();
  }
}

abstract class _DeviceWatch extends Device {
  const factory _DeviceWatch(
      {required String name,
      required Resolution resolution,
      DeviceType type}) = _$_DeviceWatch;
  const _DeviceWatch._() : super._();

  @override
  String get name;
  @override
  Resolution get resolution;
  @override
  DeviceType get type;
  @override
  @JsonKey(ignore: true)
  _$DeviceWatchCopyWith<_DeviceWatch> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$DeviceMobileCopyWith<$Res> implements $DeviceCopyWith<$Res> {
  factory _$DeviceMobileCopyWith(
          _DeviceMobile value, $Res Function(_DeviceMobile) then) =
      __$DeviceMobileCopyWithImpl<$Res>;
  @override
  $Res call({String name, Resolution resolution, DeviceType type});

  @override
  $ResolutionCopyWith<$Res> get resolution;
}

/// @nodoc
class __$DeviceMobileCopyWithImpl<$Res> extends _$DeviceCopyWithImpl<$Res>
    implements _$DeviceMobileCopyWith<$Res> {
  __$DeviceMobileCopyWithImpl(
      _DeviceMobile _value, $Res Function(_DeviceMobile) _then)
      : super(_value, (v) => _then(v as _DeviceMobile));

  @override
  _DeviceMobile get _value => super._value as _DeviceMobile;

  @override
  $Res call({
    Object? name = freezed,
    Object? resolution = freezed,
    Object? type = freezed,
  }) {
    return _then(_DeviceMobile(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      resolution: resolution == freezed
          ? _value.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as Resolution,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as DeviceType,
    ));
  }
}

/// @nodoc

class _$_DeviceMobile extends _DeviceMobile {
  const _$_DeviceMobile(
      {required this.name,
      required this.resolution,
      this.type = DeviceType.mobile})
      : super._();

  @override
  final String name;
  @override
  final Resolution resolution;
  @JsonKey()
  @override
  final DeviceType type;

  @override
  String toString() {
    return 'Device.mobile(name: $name, resolution: $resolution, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DeviceMobile &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.resolution, resolution) &&
            const DeepCollectionEquality().equals(other.type, type));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(resolution),
      const DeepCollectionEquality().hash(type));

  @JsonKey(ignore: true)
  @override
  _$DeviceMobileCopyWith<_DeviceMobile> get copyWith =>
      __$DeviceMobileCopyWithImpl<_DeviceMobile>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String name, Resolution resolution, DeviceType type)
        $default, {
    required TResult Function(
            String name, Resolution resolution, DeviceType type)
        watch,
    required TResult Function(
            String name, Resolution resolution, DeviceType type)
        mobile,
    required TResult Function(
            String name, Resolution resolution, DeviceType type)
        tablet,
    required TResult Function(
            String name, Resolution resolution, DeviceType type)
        desktop,
    required TResult Function(
            String name, Resolution resolution, DeviceType type)
        special,
  }) {
    return mobile(name, resolution, type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(String name, Resolution resolution, DeviceType type)?
        $default, {
    TResult Function(String name, Resolution resolution, DeviceType type)?
        watch,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        mobile,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        tablet,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        desktop,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        special,
  }) {
    return mobile?.call(name, resolution, type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String name, Resolution resolution, DeviceType type)?
        $default, {
    TResult Function(String name, Resolution resolution, DeviceType type)?
        watch,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        mobile,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        tablet,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        desktop,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        special,
    required TResult orElse(),
  }) {
    if (mobile != null) {
      return mobile(name, resolution, type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Device value) $default, {
    required TResult Function(_DeviceWatch value) watch,
    required TResult Function(_DeviceMobile value) mobile,
    required TResult Function(_DeviceTablet value) tablet,
    required TResult Function(_DeviceDesktop value) desktop,
    required TResult Function(_DeviceSpecial value) special,
  }) {
    return mobile(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(_Device value)? $default, {
    TResult Function(_DeviceWatch value)? watch,
    TResult Function(_DeviceMobile value)? mobile,
    TResult Function(_DeviceTablet value)? tablet,
    TResult Function(_DeviceDesktop value)? desktop,
    TResult Function(_DeviceSpecial value)? special,
  }) {
    return mobile?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Device value)? $default, {
    TResult Function(_DeviceWatch value)? watch,
    TResult Function(_DeviceMobile value)? mobile,
    TResult Function(_DeviceTablet value)? tablet,
    TResult Function(_DeviceDesktop value)? desktop,
    TResult Function(_DeviceSpecial value)? special,
    required TResult orElse(),
  }) {
    if (mobile != null) {
      return mobile(this);
    }
    return orElse();
  }
}

abstract class _DeviceMobile extends Device {
  const factory _DeviceMobile(
      {required String name,
      required Resolution resolution,
      DeviceType type}) = _$_DeviceMobile;
  const _DeviceMobile._() : super._();

  @override
  String get name;
  @override
  Resolution get resolution;
  @override
  DeviceType get type;
  @override
  @JsonKey(ignore: true)
  _$DeviceMobileCopyWith<_DeviceMobile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$DeviceTabletCopyWith<$Res> implements $DeviceCopyWith<$Res> {
  factory _$DeviceTabletCopyWith(
          _DeviceTablet value, $Res Function(_DeviceTablet) then) =
      __$DeviceTabletCopyWithImpl<$Res>;
  @override
  $Res call({String name, Resolution resolution, DeviceType type});

  @override
  $ResolutionCopyWith<$Res> get resolution;
}

/// @nodoc
class __$DeviceTabletCopyWithImpl<$Res> extends _$DeviceCopyWithImpl<$Res>
    implements _$DeviceTabletCopyWith<$Res> {
  __$DeviceTabletCopyWithImpl(
      _DeviceTablet _value, $Res Function(_DeviceTablet) _then)
      : super(_value, (v) => _then(v as _DeviceTablet));

  @override
  _DeviceTablet get _value => super._value as _DeviceTablet;

  @override
  $Res call({
    Object? name = freezed,
    Object? resolution = freezed,
    Object? type = freezed,
  }) {
    return _then(_DeviceTablet(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      resolution: resolution == freezed
          ? _value.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as Resolution,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as DeviceType,
    ));
  }
}

/// @nodoc

class _$_DeviceTablet extends _DeviceTablet {
  const _$_DeviceTablet(
      {required this.name,
      required this.resolution,
      this.type = DeviceType.tablet})
      : super._();

  @override
  final String name;
  @override
  final Resolution resolution;
  @JsonKey()
  @override
  final DeviceType type;

  @override
  String toString() {
    return 'Device.tablet(name: $name, resolution: $resolution, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DeviceTablet &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.resolution, resolution) &&
            const DeepCollectionEquality().equals(other.type, type));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(resolution),
      const DeepCollectionEquality().hash(type));

  @JsonKey(ignore: true)
  @override
  _$DeviceTabletCopyWith<_DeviceTablet> get copyWith =>
      __$DeviceTabletCopyWithImpl<_DeviceTablet>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String name, Resolution resolution, DeviceType type)
        $default, {
    required TResult Function(
            String name, Resolution resolution, DeviceType type)
        watch,
    required TResult Function(
            String name, Resolution resolution, DeviceType type)
        mobile,
    required TResult Function(
            String name, Resolution resolution, DeviceType type)
        tablet,
    required TResult Function(
            String name, Resolution resolution, DeviceType type)
        desktop,
    required TResult Function(
            String name, Resolution resolution, DeviceType type)
        special,
  }) {
    return tablet(name, resolution, type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(String name, Resolution resolution, DeviceType type)?
        $default, {
    TResult Function(String name, Resolution resolution, DeviceType type)?
        watch,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        mobile,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        tablet,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        desktop,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        special,
  }) {
    return tablet?.call(name, resolution, type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String name, Resolution resolution, DeviceType type)?
        $default, {
    TResult Function(String name, Resolution resolution, DeviceType type)?
        watch,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        mobile,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        tablet,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        desktop,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        special,
    required TResult orElse(),
  }) {
    if (tablet != null) {
      return tablet(name, resolution, type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Device value) $default, {
    required TResult Function(_DeviceWatch value) watch,
    required TResult Function(_DeviceMobile value) mobile,
    required TResult Function(_DeviceTablet value) tablet,
    required TResult Function(_DeviceDesktop value) desktop,
    required TResult Function(_DeviceSpecial value) special,
  }) {
    return tablet(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(_Device value)? $default, {
    TResult Function(_DeviceWatch value)? watch,
    TResult Function(_DeviceMobile value)? mobile,
    TResult Function(_DeviceTablet value)? tablet,
    TResult Function(_DeviceDesktop value)? desktop,
    TResult Function(_DeviceSpecial value)? special,
  }) {
    return tablet?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Device value)? $default, {
    TResult Function(_DeviceWatch value)? watch,
    TResult Function(_DeviceMobile value)? mobile,
    TResult Function(_DeviceTablet value)? tablet,
    TResult Function(_DeviceDesktop value)? desktop,
    TResult Function(_DeviceSpecial value)? special,
    required TResult orElse(),
  }) {
    if (tablet != null) {
      return tablet(this);
    }
    return orElse();
  }
}

abstract class _DeviceTablet extends Device {
  const factory _DeviceTablet(
      {required String name,
      required Resolution resolution,
      DeviceType type}) = _$_DeviceTablet;
  const _DeviceTablet._() : super._();

  @override
  String get name;
  @override
  Resolution get resolution;
  @override
  DeviceType get type;
  @override
  @JsonKey(ignore: true)
  _$DeviceTabletCopyWith<_DeviceTablet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$DeviceDesktopCopyWith<$Res> implements $DeviceCopyWith<$Res> {
  factory _$DeviceDesktopCopyWith(
          _DeviceDesktop value, $Res Function(_DeviceDesktop) then) =
      __$DeviceDesktopCopyWithImpl<$Res>;
  @override
  $Res call({String name, Resolution resolution, DeviceType type});

  @override
  $ResolutionCopyWith<$Res> get resolution;
}

/// @nodoc
class __$DeviceDesktopCopyWithImpl<$Res> extends _$DeviceCopyWithImpl<$Res>
    implements _$DeviceDesktopCopyWith<$Res> {
  __$DeviceDesktopCopyWithImpl(
      _DeviceDesktop _value, $Res Function(_DeviceDesktop) _then)
      : super(_value, (v) => _then(v as _DeviceDesktop));

  @override
  _DeviceDesktop get _value => super._value as _DeviceDesktop;

  @override
  $Res call({
    Object? name = freezed,
    Object? resolution = freezed,
    Object? type = freezed,
  }) {
    return _then(_DeviceDesktop(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      resolution: resolution == freezed
          ? _value.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as Resolution,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as DeviceType,
    ));
  }
}

/// @nodoc

class _$_DeviceDesktop extends _DeviceDesktop {
  const _$_DeviceDesktop(
      {required this.name,
      required this.resolution,
      this.type = DeviceType.desktop})
      : super._();

  @override
  final String name;
  @override
  final Resolution resolution;
  @JsonKey()
  @override
  final DeviceType type;

  @override
  String toString() {
    return 'Device.desktop(name: $name, resolution: $resolution, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DeviceDesktop &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.resolution, resolution) &&
            const DeepCollectionEquality().equals(other.type, type));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(resolution),
      const DeepCollectionEquality().hash(type));

  @JsonKey(ignore: true)
  @override
  _$DeviceDesktopCopyWith<_DeviceDesktop> get copyWith =>
      __$DeviceDesktopCopyWithImpl<_DeviceDesktop>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String name, Resolution resolution, DeviceType type)
        $default, {
    required TResult Function(
            String name, Resolution resolution, DeviceType type)
        watch,
    required TResult Function(
            String name, Resolution resolution, DeviceType type)
        mobile,
    required TResult Function(
            String name, Resolution resolution, DeviceType type)
        tablet,
    required TResult Function(
            String name, Resolution resolution, DeviceType type)
        desktop,
    required TResult Function(
            String name, Resolution resolution, DeviceType type)
        special,
  }) {
    return desktop(name, resolution, type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(String name, Resolution resolution, DeviceType type)?
        $default, {
    TResult Function(String name, Resolution resolution, DeviceType type)?
        watch,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        mobile,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        tablet,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        desktop,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        special,
  }) {
    return desktop?.call(name, resolution, type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String name, Resolution resolution, DeviceType type)?
        $default, {
    TResult Function(String name, Resolution resolution, DeviceType type)?
        watch,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        mobile,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        tablet,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        desktop,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        special,
    required TResult orElse(),
  }) {
    if (desktop != null) {
      return desktop(name, resolution, type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Device value) $default, {
    required TResult Function(_DeviceWatch value) watch,
    required TResult Function(_DeviceMobile value) mobile,
    required TResult Function(_DeviceTablet value) tablet,
    required TResult Function(_DeviceDesktop value) desktop,
    required TResult Function(_DeviceSpecial value) special,
  }) {
    return desktop(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(_Device value)? $default, {
    TResult Function(_DeviceWatch value)? watch,
    TResult Function(_DeviceMobile value)? mobile,
    TResult Function(_DeviceTablet value)? tablet,
    TResult Function(_DeviceDesktop value)? desktop,
    TResult Function(_DeviceSpecial value)? special,
  }) {
    return desktop?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Device value)? $default, {
    TResult Function(_DeviceWatch value)? watch,
    TResult Function(_DeviceMobile value)? mobile,
    TResult Function(_DeviceTablet value)? tablet,
    TResult Function(_DeviceDesktop value)? desktop,
    TResult Function(_DeviceSpecial value)? special,
    required TResult orElse(),
  }) {
    if (desktop != null) {
      return desktop(this);
    }
    return orElse();
  }
}

abstract class _DeviceDesktop extends Device {
  const factory _DeviceDesktop(
      {required String name,
      required Resolution resolution,
      DeviceType type}) = _$_DeviceDesktop;
  const _DeviceDesktop._() : super._();

  @override
  String get name;
  @override
  Resolution get resolution;
  @override
  DeviceType get type;
  @override
  @JsonKey(ignore: true)
  _$DeviceDesktopCopyWith<_DeviceDesktop> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$DeviceSpecialCopyWith<$Res> implements $DeviceCopyWith<$Res> {
  factory _$DeviceSpecialCopyWith(
          _DeviceSpecial value, $Res Function(_DeviceSpecial) then) =
      __$DeviceSpecialCopyWithImpl<$Res>;
  @override
  $Res call({String name, Resolution resolution, DeviceType type});

  @override
  $ResolutionCopyWith<$Res> get resolution;
}

/// @nodoc
class __$DeviceSpecialCopyWithImpl<$Res> extends _$DeviceCopyWithImpl<$Res>
    implements _$DeviceSpecialCopyWith<$Res> {
  __$DeviceSpecialCopyWithImpl(
      _DeviceSpecial _value, $Res Function(_DeviceSpecial) _then)
      : super(_value, (v) => _then(v as _DeviceSpecial));

  @override
  _DeviceSpecial get _value => super._value as _DeviceSpecial;

  @override
  $Res call({
    Object? name = freezed,
    Object? resolution = freezed,
    Object? type = freezed,
  }) {
    return _then(_DeviceSpecial(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      resolution: resolution == freezed
          ? _value.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as Resolution,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as DeviceType,
    ));
  }
}

/// @nodoc

class _$_DeviceSpecial extends _DeviceSpecial {
  const _$_DeviceSpecial(
      {required this.name,
      required this.resolution,
      this.type = DeviceType.unknown})
      : super._();

  @override
  final String name;
  @override
  final Resolution resolution;
  @JsonKey()
  @override
  final DeviceType type;

  @override
  String toString() {
    return 'Device.special(name: $name, resolution: $resolution, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DeviceSpecial &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.resolution, resolution) &&
            const DeepCollectionEquality().equals(other.type, type));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(resolution),
      const DeepCollectionEquality().hash(type));

  @JsonKey(ignore: true)
  @override
  _$DeviceSpecialCopyWith<_DeviceSpecial> get copyWith =>
      __$DeviceSpecialCopyWithImpl<_DeviceSpecial>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String name, Resolution resolution, DeviceType type)
        $default, {
    required TResult Function(
            String name, Resolution resolution, DeviceType type)
        watch,
    required TResult Function(
            String name, Resolution resolution, DeviceType type)
        mobile,
    required TResult Function(
            String name, Resolution resolution, DeviceType type)
        tablet,
    required TResult Function(
            String name, Resolution resolution, DeviceType type)
        desktop,
    required TResult Function(
            String name, Resolution resolution, DeviceType type)
        special,
  }) {
    return special(name, resolution, type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(String name, Resolution resolution, DeviceType type)?
        $default, {
    TResult Function(String name, Resolution resolution, DeviceType type)?
        watch,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        mobile,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        tablet,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        desktop,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        special,
  }) {
    return special?.call(name, resolution, type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String name, Resolution resolution, DeviceType type)?
        $default, {
    TResult Function(String name, Resolution resolution, DeviceType type)?
        watch,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        mobile,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        tablet,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        desktop,
    TResult Function(String name, Resolution resolution, DeviceType type)?
        special,
    required TResult orElse(),
  }) {
    if (special != null) {
      return special(name, resolution, type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Device value) $default, {
    required TResult Function(_DeviceWatch value) watch,
    required TResult Function(_DeviceMobile value) mobile,
    required TResult Function(_DeviceTablet value) tablet,
    required TResult Function(_DeviceDesktop value) desktop,
    required TResult Function(_DeviceSpecial value) special,
  }) {
    return special(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(_Device value)? $default, {
    TResult Function(_DeviceWatch value)? watch,
    TResult Function(_DeviceMobile value)? mobile,
    TResult Function(_DeviceTablet value)? tablet,
    TResult Function(_DeviceDesktop value)? desktop,
    TResult Function(_DeviceSpecial value)? special,
  }) {
    return special?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Device value)? $default, {
    TResult Function(_DeviceWatch value)? watch,
    TResult Function(_DeviceMobile value)? mobile,
    TResult Function(_DeviceTablet value)? tablet,
    TResult Function(_DeviceDesktop value)? desktop,
    TResult Function(_DeviceSpecial value)? special,
    required TResult orElse(),
  }) {
    if (special != null) {
      return special(this);
    }
    return orElse();
  }
}

abstract class _DeviceSpecial extends Device {
  const factory _DeviceSpecial(
      {required String name,
      required Resolution resolution,
      DeviceType type}) = _$_DeviceSpecial;
  const _DeviceSpecial._() : super._();

  @override
  String get name;
  @override
  Resolution get resolution;
  @override
  DeviceType get type;
  @override
  @JsonKey(ignore: true)
  _$DeviceSpecialCopyWith<_DeviceSpecial> get copyWith =>
      throw _privateConstructorUsedError;
}
