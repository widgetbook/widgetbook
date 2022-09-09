// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'device_selection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DeviceSelection {
  FrameBuilder get activeFrameBuilder => throw _privateConstructorUsedError;
  Set<Device> get activeDevices => throw _privateConstructorUsedError;
  List<FrameBuilder> get frameBuilders => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DeviceSelectionCopyWith<DeviceSelection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceSelectionCopyWith<$Res> {
  factory $DeviceSelectionCopyWith(
          DeviceSelection value, $Res Function(DeviceSelection) then) =
      _$DeviceSelectionCopyWithImpl<$Res>;
  $Res call(
      {FrameBuilder activeFrameBuilder,
      Set<Device> activeDevices,
      List<FrameBuilder> frameBuilders});
}

/// @nodoc
class _$DeviceSelectionCopyWithImpl<$Res>
    implements $DeviceSelectionCopyWith<$Res> {
  _$DeviceSelectionCopyWithImpl(this._value, this._then);

  final DeviceSelection _value;
  // ignore: unused_field
  final $Res Function(DeviceSelection) _then;

  @override
  $Res call({
    Object? activeFrameBuilder = freezed,
    Object? activeDevices = freezed,
    Object? frameBuilders = freezed,
  }) {
    return _then(_value.copyWith(
      activeFrameBuilder: activeFrameBuilder == freezed
          ? _value.activeFrameBuilder
          : activeFrameBuilder // ignore: cast_nullable_to_non_nullable
              as FrameBuilder,
      activeDevices: activeDevices == freezed
          ? _value.activeDevices
          : activeDevices // ignore: cast_nullable_to_non_nullable
              as Set<Device>,
      frameBuilders: frameBuilders == freezed
          ? _value.frameBuilders
          : frameBuilders // ignore: cast_nullable_to_non_nullable
              as List<FrameBuilder>,
    ));
  }
}

/// @nodoc
abstract class _$$_DeviceSelectionCopyWith<$Res>
    implements $DeviceSelectionCopyWith<$Res> {
  factory _$$_DeviceSelectionCopyWith(
          _$_DeviceSelection value, $Res Function(_$_DeviceSelection) then) =
      __$$_DeviceSelectionCopyWithImpl<$Res>;
  @override
  $Res call(
      {FrameBuilder activeFrameBuilder,
      Set<Device> activeDevices,
      List<FrameBuilder> frameBuilders});
}

/// @nodoc
class __$$_DeviceSelectionCopyWithImpl<$Res>
    extends _$DeviceSelectionCopyWithImpl<$Res>
    implements _$$_DeviceSelectionCopyWith<$Res> {
  __$$_DeviceSelectionCopyWithImpl(
      _$_DeviceSelection _value, $Res Function(_$_DeviceSelection) _then)
      : super(_value, (v) => _then(v as _$_DeviceSelection));

  @override
  _$_DeviceSelection get _value => super._value as _$_DeviceSelection;

  @override
  $Res call({
    Object? activeFrameBuilder = freezed,
    Object? activeDevices = freezed,
    Object? frameBuilders = freezed,
  }) {
    return _then(_$_DeviceSelection(
      activeFrameBuilder: activeFrameBuilder == freezed
          ? _value.activeFrameBuilder
          : activeFrameBuilder // ignore: cast_nullable_to_non_nullable
              as FrameBuilder,
      activeDevices: activeDevices == freezed
          ? _value._activeDevices
          : activeDevices // ignore: cast_nullable_to_non_nullable
              as Set<Device>,
      frameBuilders: frameBuilders == freezed
          ? _value._frameBuilders
          : frameBuilders // ignore: cast_nullable_to_non_nullable
              as List<FrameBuilder>,
    ));
  }
}

/// @nodoc

class _$_DeviceSelection implements _DeviceSelection {
  _$_DeviceSelection(
      {required this.activeFrameBuilder,
      final Set<Device> activeDevices = const <Device>{},
      required final List<FrameBuilder> frameBuilders})
      : _activeDevices = activeDevices,
        _frameBuilders = frameBuilders;

  @override
  final FrameBuilder activeFrameBuilder;
  final Set<Device> _activeDevices;
  @override
  @JsonKey()
  Set<Device> get activeDevices {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_activeDevices);
  }

  final List<FrameBuilder> _frameBuilders;
  @override
  List<FrameBuilder> get frameBuilders {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_frameBuilders);
  }

  @override
  String toString() {
    return 'DeviceSelection(activeFrameBuilder: $activeFrameBuilder, activeDevices: $activeDevices, frameBuilders: $frameBuilders)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DeviceSelection &&
            const DeepCollectionEquality()
                .equals(other.activeFrameBuilder, activeFrameBuilder) &&
            const DeepCollectionEquality()
                .equals(other._activeDevices, _activeDevices) &&
            const DeepCollectionEquality()
                .equals(other._frameBuilders, _frameBuilders));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(activeFrameBuilder),
      const DeepCollectionEquality().hash(_activeDevices),
      const DeepCollectionEquality().hash(_frameBuilders));

  @JsonKey(ignore: true)
  @override
  _$$_DeviceSelectionCopyWith<_$_DeviceSelection> get copyWith =>
      __$$_DeviceSelectionCopyWithImpl<_$_DeviceSelection>(this, _$identity);
}

abstract class _DeviceSelection implements DeviceSelection {
  factory _DeviceSelection(
      {required final FrameBuilder activeFrameBuilder,
      final Set<Device> activeDevices,
      required final List<FrameBuilder> frameBuilders}) = _$_DeviceSelection;

  @override
  FrameBuilder get activeFrameBuilder;
  @override
  Set<Device> get activeDevices;
  @override
  List<FrameBuilder> get frameBuilders;
  @override
  @JsonKey(ignore: true)
  _$$_DeviceSelectionCopyWith<_$_DeviceSelection> get copyWith =>
      throw _privateConstructorUsedError;
}
