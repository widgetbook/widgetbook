// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'text_scale_setting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TextScaleSetting {
  Set<double> get activeTextScales => throw _privateConstructorUsedError;
  List<double> get textScales => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TextScaleSettingCopyWith<TextScaleSetting> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TextScaleSettingCopyWith<$Res> {
  factory $TextScaleSettingCopyWith(
          TextScaleSetting value, $Res Function(TextScaleSetting) then) =
      _$TextScaleSettingCopyWithImpl<$Res>;
  $Res call({Set<double> activeTextScales, List<double> textScales});
}

/// @nodoc
class _$TextScaleSettingCopyWithImpl<$Res>
    implements $TextScaleSettingCopyWith<$Res> {
  _$TextScaleSettingCopyWithImpl(this._value, this._then);

  final TextScaleSetting _value;
  // ignore: unused_field
  final $Res Function(TextScaleSetting) _then;

  @override
  $Res call({
    Object? activeTextScales = freezed,
    Object? textScales = freezed,
  }) {
    return _then(_value.copyWith(
      activeTextScales: activeTextScales == freezed
          ? _value.activeTextScales
          : activeTextScales // ignore: cast_nullable_to_non_nullable
              as Set<double>,
      textScales: textScales == freezed
          ? _value.textScales
          : textScales // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ));
  }
}

/// @nodoc
abstract class _$$_TextScaleSettingCopyWith<$Res>
    implements $TextScaleSettingCopyWith<$Res> {
  factory _$$_TextScaleSettingCopyWith(
          _$_TextScaleSetting value, $Res Function(_$_TextScaleSetting) then) =
      __$$_TextScaleSettingCopyWithImpl<$Res>;
  @override
  $Res call({Set<double> activeTextScales, List<double> textScales});
}

/// @nodoc
class __$$_TextScaleSettingCopyWithImpl<$Res>
    extends _$TextScaleSettingCopyWithImpl<$Res>
    implements _$$_TextScaleSettingCopyWith<$Res> {
  __$$_TextScaleSettingCopyWithImpl(
      _$_TextScaleSetting _value, $Res Function(_$_TextScaleSetting) _then)
      : super(_value, (v) => _then(v as _$_TextScaleSetting));

  @override
  _$_TextScaleSetting get _value => super._value as _$_TextScaleSetting;

  @override
  $Res call({
    Object? activeTextScales = freezed,
    Object? textScales = freezed,
  }) {
    return _then(_$_TextScaleSetting(
      activeTextScales: activeTextScales == freezed
          ? _value._activeTextScales
          : activeTextScales // ignore: cast_nullable_to_non_nullable
              as Set<double>,
      textScales: textScales == freezed
          ? _value._textScales
          : textScales // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ));
  }
}

/// @nodoc

class _$_TextScaleSetting extends _TextScaleSetting {
  _$_TextScaleSetting(
      {required final Set<double> activeTextScales,
      required final List<double> textScales})
      : _activeTextScales = activeTextScales,
        _textScales = textScales,
        super._();

  final Set<double> _activeTextScales;
  @override
  Set<double> get activeTextScales {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_activeTextScales);
  }

  final List<double> _textScales;
  @override
  List<double> get textScales {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_textScales);
  }

  @override
  String toString() {
    return 'TextScaleSetting(activeTextScales: $activeTextScales, textScales: $textScales)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TextScaleSetting &&
            const DeepCollectionEquality()
                .equals(other._activeTextScales, _activeTextScales) &&
            const DeepCollectionEquality()
                .equals(other._textScales, _textScales));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_activeTextScales),
      const DeepCollectionEquality().hash(_textScales));

  @JsonKey(ignore: true)
  @override
  _$$_TextScaleSettingCopyWith<_$_TextScaleSetting> get copyWith =>
      __$$_TextScaleSettingCopyWithImpl<_$_TextScaleSetting>(this, _$identity);
}

abstract class _TextScaleSetting extends TextScaleSetting {
  factory _TextScaleSetting(
      {required final Set<double> activeTextScales,
      required final List<double> textScales}) = _$_TextScaleSetting;
  _TextScaleSetting._() : super._();

  @override
  Set<double> get activeTextScales;
  @override
  List<double> get textScales;
  @override
  @JsonKey(ignore: true)
  _$$_TextScaleSettingCopyWith<_$_TextScaleSetting> get copyWith =>
      throw _privateConstructorUsedError;
}
