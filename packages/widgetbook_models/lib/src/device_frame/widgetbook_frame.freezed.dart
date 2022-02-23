// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'widgetbook_frame.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$WidgetbookFrameTearOff {
  const _$WidgetbookFrameTearOff();

  _WidgetbookFrame call({required String name, required bool allowsDevices}) {
    return _WidgetbookFrame(
      name: name,
      allowsDevices: allowsDevices,
    );
  }
}

/// @nodoc
const $WidgetbookFrame = _$WidgetbookFrameTearOff();

/// @nodoc
mixin _$WidgetbookFrame {
  /// The name displayed as a tooltip
  String get name => throw _privateConstructorUsedError;

  /// Indicators whether this mode supports specific devices e.g. iPhone 11
  bool get allowsDevices => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WidgetbookFrameCopyWith<WidgetbookFrame> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WidgetbookFrameCopyWith<$Res> {
  factory $WidgetbookFrameCopyWith(
          WidgetbookFrame value, $Res Function(WidgetbookFrame) then) =
      _$WidgetbookFrameCopyWithImpl<$Res>;
  $Res call({String name, bool allowsDevices});
}

/// @nodoc
class _$WidgetbookFrameCopyWithImpl<$Res>
    implements $WidgetbookFrameCopyWith<$Res> {
  _$WidgetbookFrameCopyWithImpl(this._value, this._then);

  final WidgetbookFrame _value;
  // ignore: unused_field
  final $Res Function(WidgetbookFrame) _then;

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
abstract class _$WidgetbookFrameCopyWith<$Res>
    implements $WidgetbookFrameCopyWith<$Res> {
  factory _$WidgetbookFrameCopyWith(
          _WidgetbookFrame value, $Res Function(_WidgetbookFrame) then) =
      __$WidgetbookFrameCopyWithImpl<$Res>;
  @override
  $Res call({String name, bool allowsDevices});
}

/// @nodoc
class __$WidgetbookFrameCopyWithImpl<$Res>
    extends _$WidgetbookFrameCopyWithImpl<$Res>
    implements _$WidgetbookFrameCopyWith<$Res> {
  __$WidgetbookFrameCopyWithImpl(
      _WidgetbookFrame _value, $Res Function(_WidgetbookFrame) _then)
      : super(_value, (v) => _then(v as _WidgetbookFrame));

  @override
  _WidgetbookFrame get _value => super._value as _WidgetbookFrame;

  @override
  $Res call({
    Object? name = freezed,
    Object? allowsDevices = freezed,
  }) {
    return _then(_WidgetbookFrame(
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

class _$_WidgetbookFrame implements _WidgetbookFrame {
  const _$_WidgetbookFrame({required this.name, required this.allowsDevices});

  @override

  /// The name displayed as a tooltip
  final String name;
  @override

  /// Indicators whether this mode supports specific devices e.g. iPhone 11
  final bool allowsDevices;

  @override
  String toString() {
    return 'WidgetbookFrame(name: $name, allowsDevices: $allowsDevices)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WidgetbookFrame &&
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
  _$WidgetbookFrameCopyWith<_WidgetbookFrame> get copyWith =>
      __$WidgetbookFrameCopyWithImpl<_WidgetbookFrame>(this, _$identity);
}

abstract class _WidgetbookFrame implements WidgetbookFrame {
  const factory _WidgetbookFrame(
      {required String name, required bool allowsDevices}) = _$_WidgetbookFrame;

  @override

  /// The name displayed as a tooltip
  String get name;
  @override

  /// Indicators whether this mode supports specific devices e.g. iPhone 11
  bool get allowsDevices;
  @override
  @JsonKey(ignore: true)
  _$WidgetbookFrameCopyWith<_WidgetbookFrame> get copyWith =>
      throw _privateConstructorUsedError;
}
