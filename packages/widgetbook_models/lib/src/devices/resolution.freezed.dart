// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'resolution.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ResolutionTearOff {
  const _$ResolutionTearOff();

  _Resolution call(
      {required DeviceSize nativeSize, required double scaleFactor}) {
    return _Resolution(
      nativeSize: nativeSize,
      scaleFactor: scaleFactor,
    );
  }
}

/// @nodoc
const $Resolution = _$ResolutionTearOff();

/// @nodoc
mixin _$Resolution {
  /// The nativeSize defines the number of pixels of the device screen.
  /// It is used to calculate the logical size of the device by
  /// using the following formula:
  /// logicalSize = nativeSize / scaleFactor
  DeviceSize get nativeSize => throw _privateConstructorUsedError;

  /// The scaleFactor is used to calculate the logical size of the device by
  /// using the following formula:
  /// logicalSize = nativeSize / scaleFactor
  double get scaleFactor => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ResolutionCopyWith<Resolution> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResolutionCopyWith<$Res> {
  factory $ResolutionCopyWith(
          Resolution value, $Res Function(Resolution) then) =
      _$ResolutionCopyWithImpl<$Res>;
  $Res call({DeviceSize nativeSize, double scaleFactor});

  $DeviceSizeCopyWith<$Res> get nativeSize;
}

/// @nodoc
class _$ResolutionCopyWithImpl<$Res> implements $ResolutionCopyWith<$Res> {
  _$ResolutionCopyWithImpl(this._value, this._then);

  final Resolution _value;
  // ignore: unused_field
  final $Res Function(Resolution) _then;

  @override
  $Res call({
    Object? nativeSize = freezed,
    Object? scaleFactor = freezed,
  }) {
    return _then(_value.copyWith(
      nativeSize: nativeSize == freezed
          ? _value.nativeSize
          : nativeSize // ignore: cast_nullable_to_non_nullable
              as DeviceSize,
      scaleFactor: scaleFactor == freezed
          ? _value.scaleFactor
          : scaleFactor // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }

  @override
  $DeviceSizeCopyWith<$Res> get nativeSize {
    return $DeviceSizeCopyWith<$Res>(_value.nativeSize, (value) {
      return _then(_value.copyWith(nativeSize: value));
    });
  }
}

/// @nodoc
abstract class _$ResolutionCopyWith<$Res> implements $ResolutionCopyWith<$Res> {
  factory _$ResolutionCopyWith(
          _Resolution value, $Res Function(_Resolution) then) =
      __$ResolutionCopyWithImpl<$Res>;
  @override
  $Res call({DeviceSize nativeSize, double scaleFactor});

  @override
  $DeviceSizeCopyWith<$Res> get nativeSize;
}

/// @nodoc
class __$ResolutionCopyWithImpl<$Res> extends _$ResolutionCopyWithImpl<$Res>
    implements _$ResolutionCopyWith<$Res> {
  __$ResolutionCopyWithImpl(
      _Resolution _value, $Res Function(_Resolution) _then)
      : super(_value, (v) => _then(v as _Resolution));

  @override
  _Resolution get _value => super._value as _Resolution;

  @override
  $Res call({
    Object? nativeSize = freezed,
    Object? scaleFactor = freezed,
  }) {
    return _then(_Resolution(
      nativeSize: nativeSize == freezed
          ? _value.nativeSize
          : nativeSize // ignore: cast_nullable_to_non_nullable
              as DeviceSize,
      scaleFactor: scaleFactor == freezed
          ? _value.scaleFactor
          : scaleFactor // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$_Resolution extends _Resolution {
  const _$_Resolution({required this.nativeSize, required this.scaleFactor})
      : super._();

  @override

  /// The nativeSize defines the number of pixels of the device screen.
  /// It is used to calculate the logical size of the device by
  /// using the following formula:
  /// logicalSize = nativeSize / scaleFactor
  final DeviceSize nativeSize;
  @override

  /// The scaleFactor is used to calculate the logical size of the device by
  /// using the following formula:
  /// logicalSize = nativeSize / scaleFactor
  final double scaleFactor;

  @override
  String toString() {
    return 'Resolution(nativeSize: $nativeSize, scaleFactor: $scaleFactor)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Resolution &&
            const DeepCollectionEquality()
                .equals(other.nativeSize, nativeSize) &&
            const DeepCollectionEquality()
                .equals(other.scaleFactor, scaleFactor));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(nativeSize),
      const DeepCollectionEquality().hash(scaleFactor));

  @JsonKey(ignore: true)
  @override
  _$ResolutionCopyWith<_Resolution> get copyWith =>
      __$ResolutionCopyWithImpl<_Resolution>(this, _$identity);
}

abstract class _Resolution extends Resolution {
  const factory _Resolution(
      {required DeviceSize nativeSize,
      required double scaleFactor}) = _$_Resolution;
  const _Resolution._() : super._();

  @override

  /// The nativeSize defines the number of pixels of the device screen.
  /// It is used to calculate the logical size of the device by
  /// using the following formula:
  /// logicalSize = nativeSize / scaleFactor
  DeviceSize get nativeSize;
  @override

  /// The scaleFactor is used to calculate the logical size of the device by
  /// using the following formula:
  /// logicalSize = nativeSize / scaleFactor
  double get scaleFactor;
  @override
  @JsonKey(ignore: true)
  _$ResolutionCopyWith<_Resolution> get copyWith =>
      throw _privateConstructorUsedError;
}
