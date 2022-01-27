// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'render_mode.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$RenderModeTearOff {
  const _$RenderModeTearOff();

  _RenderMode call(
      {required String name,
      required IconData icon,
      required bool allowsDevices}) {
    return _RenderMode(
      name: name,
      icon: icon,
      allowsDevices: allowsDevices,
    );
  }
}

/// @nodoc
const $RenderMode = _$RenderModeTearOff();

/// @nodoc
mixin _$RenderMode {
  /// The name displayed as a tooltip
  String get name => throw _privateConstructorUsedError;

  /// The icon displayed in the workbench bar
  IconData get icon => throw _privateConstructorUsedError;

  /// Indicators whether this mode supports specific devices e.g. iPhone 11
  bool get allowsDevices => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RenderModeCopyWith<RenderMode> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RenderModeCopyWith<$Res> {
  factory $RenderModeCopyWith(
          RenderMode value, $Res Function(RenderMode) then) =
      _$RenderModeCopyWithImpl<$Res>;
  $Res call({String name, IconData icon, bool allowsDevices});
}

/// @nodoc
class _$RenderModeCopyWithImpl<$Res> implements $RenderModeCopyWith<$Res> {
  _$RenderModeCopyWithImpl(this._value, this._then);

  final RenderMode _value;
  // ignore: unused_field
  final $Res Function(RenderMode) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? icon = freezed,
    Object? allowsDevices = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      icon: icon == freezed
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData,
      allowsDevices: allowsDevices == freezed
          ? _value.allowsDevices
          : allowsDevices // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$RenderModeCopyWith<$Res> implements $RenderModeCopyWith<$Res> {
  factory _$RenderModeCopyWith(
          _RenderMode value, $Res Function(_RenderMode) then) =
      __$RenderModeCopyWithImpl<$Res>;
  @override
  $Res call({String name, IconData icon, bool allowsDevices});
}

/// @nodoc
class __$RenderModeCopyWithImpl<$Res> extends _$RenderModeCopyWithImpl<$Res>
    implements _$RenderModeCopyWith<$Res> {
  __$RenderModeCopyWithImpl(
      _RenderMode _value, $Res Function(_RenderMode) _then)
      : super(_value, (v) => _then(v as _RenderMode));

  @override
  _RenderMode get _value => super._value as _RenderMode;

  @override
  $Res call({
    Object? name = freezed,
    Object? icon = freezed,
    Object? allowsDevices = freezed,
  }) {
    return _then(_RenderMode(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      icon: icon == freezed
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData,
      allowsDevices: allowsDevices == freezed
          ? _value.allowsDevices
          : allowsDevices // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_RenderMode implements _RenderMode {
  _$_RenderMode(
      {required this.name, required this.icon, required this.allowsDevices});

  @override

  /// The name displayed as a tooltip
  final String name;
  @override

  /// The icon displayed in the workbench bar
  final IconData icon;
  @override

  /// Indicators whether this mode supports specific devices e.g. iPhone 11
  final bool allowsDevices;

  @override
  String toString() {
    return 'RenderMode(name: $name, icon: $icon, allowsDevices: $allowsDevices)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RenderMode &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.icon, icon) &&
            const DeepCollectionEquality()
                .equals(other.allowsDevices, allowsDevices));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(icon),
      const DeepCollectionEquality().hash(allowsDevices));

  @JsonKey(ignore: true)
  @override
  _$RenderModeCopyWith<_RenderMode> get copyWith =>
      __$RenderModeCopyWithImpl<_RenderMode>(this, _$identity);
}

abstract class _RenderMode implements RenderMode {
  factory _RenderMode(
      {required String name,
      required IconData icon,
      required bool allowsDevices}) = _$_RenderMode;

  @override

  /// The name displayed as a tooltip
  String get name;
  @override

  /// The icon displayed in the workbench bar
  IconData get icon;
  @override

  /// Indicators whether this mode supports specific devices e.g. iPhone 11
  bool get allowsDevices;
  @override
  @JsonKey(ignore: true)
  _$RenderModeCopyWith<_RenderMode> get copyWith =>
      throw _privateConstructorUsedError;
}
