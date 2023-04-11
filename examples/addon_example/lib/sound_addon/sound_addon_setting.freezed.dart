// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'sound_addon_setting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SoundAddonSetting {
  bool get isEnabled => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SoundAddonSettingCopyWith<SoundAddonSetting> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SoundAddonSettingCopyWith<$Res> {
  factory $SoundAddonSettingCopyWith(
          SoundAddonSetting value, $Res Function(SoundAddonSetting) then) =
      _$SoundAddonSettingCopyWithImpl<$Res, SoundAddonSetting>;
  @useResult
  $Res call({bool isEnabled});
}

/// @nodoc
class _$SoundAddonSettingCopyWithImpl<$Res, $Val extends SoundAddonSetting>
    implements $SoundAddonSettingCopyWith<$Res> {
  _$SoundAddonSettingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isEnabled = null,
  }) {
    return _then(_value.copyWith(
      isEnabled: null == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SoundAddonSettingCopyWith<$Res>
    implements $SoundAddonSettingCopyWith<$Res> {
  factory _$$_SoundAddonSettingCopyWith(_$_SoundAddonSetting value,
          $Res Function(_$_SoundAddonSetting) then) =
      __$$_SoundAddonSettingCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isEnabled});
}

/// @nodoc
class __$$_SoundAddonSettingCopyWithImpl<$Res>
    extends _$SoundAddonSettingCopyWithImpl<$Res, _$_SoundAddonSetting>
    implements _$$_SoundAddonSettingCopyWith<$Res> {
  __$$_SoundAddonSettingCopyWithImpl(
      _$_SoundAddonSetting _value, $Res Function(_$_SoundAddonSetting) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isEnabled = null,
  }) {
    return _then(_$_SoundAddonSetting(
      isEnabled: null == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_SoundAddonSetting extends _SoundAddonSetting {
  const _$_SoundAddonSetting({required this.isEnabled}) : super._();

  @override
  final bool isEnabled;

  @override
  String toString() {
    return 'SoundAddonSetting(isEnabled: $isEnabled)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SoundAddonSetting &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isEnabled);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SoundAddonSettingCopyWith<_$_SoundAddonSetting> get copyWith =>
      __$$_SoundAddonSettingCopyWithImpl<_$_SoundAddonSetting>(
          this, _$identity);
}

abstract class _SoundAddonSetting extends SoundAddonSetting {
  const factory _SoundAddonSetting({required final bool isEnabled}) =
      _$_SoundAddonSetting;
  const _SoundAddonSetting._() : super._();

  @override
  bool get isEnabled;
  @override
  @JsonKey(ignore: true)
  _$$_SoundAddonSettingCopyWith<_$_SoundAddonSetting> get copyWith =>
      throw _privateConstructorUsedError;
}
