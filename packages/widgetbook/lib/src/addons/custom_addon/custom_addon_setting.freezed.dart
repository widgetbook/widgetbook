// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'custom_addon_setting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CustomAddonSetting<T> {
  Set<T> get activeData => throw _privateConstructorUsedError;
  List<T> get data => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CustomAddonSettingCopyWith<T, CustomAddonSetting<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomAddonSettingCopyWith<T, $Res> {
  factory $CustomAddonSettingCopyWith(CustomAddonSetting<T> value,
          $Res Function(CustomAddonSetting<T>) then) =
      _$CustomAddonSettingCopyWithImpl<T, $Res>;
  $Res call({Set<T> activeData, List<T> data});
}

/// @nodoc
class _$CustomAddonSettingCopyWithImpl<T, $Res>
    implements $CustomAddonSettingCopyWith<T, $Res> {
  _$CustomAddonSettingCopyWithImpl(this._value, this._then);

  final CustomAddonSetting<T> _value;
  // ignore: unused_field
  final $Res Function(CustomAddonSetting<T>) _then;

  @override
  $Res call({
    Object? activeData = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      activeData: activeData == freezed
          ? _value.activeData
          : activeData // ignore: cast_nullable_to_non_nullable
              as Set<T>,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<T>,
    ));
  }
}

/// @nodoc
abstract class _$$_CustomAddonSettingCopyWith<T, $Res>
    implements $CustomAddonSettingCopyWith<T, $Res> {
  factory _$$_CustomAddonSettingCopyWith(_$_CustomAddonSetting<T> value,
          $Res Function(_$_CustomAddonSetting<T>) then) =
      __$$_CustomAddonSettingCopyWithImpl<T, $Res>;
  @override
  $Res call({Set<T> activeData, List<T> data});
}

/// @nodoc
class __$$_CustomAddonSettingCopyWithImpl<T, $Res>
    extends _$CustomAddonSettingCopyWithImpl<T, $Res>
    implements _$$_CustomAddonSettingCopyWith<T, $Res> {
  __$$_CustomAddonSettingCopyWithImpl(_$_CustomAddonSetting<T> _value,
      $Res Function(_$_CustomAddonSetting<T>) _then)
      : super(_value, (v) => _then(v as _$_CustomAddonSetting<T>));

  @override
  _$_CustomAddonSetting<T> get _value =>
      super._value as _$_CustomAddonSetting<T>;

  @override
  $Res call({
    Object? activeData = freezed,
    Object? data = freezed,
  }) {
    return _then(_$_CustomAddonSetting<T>(
      activeData: activeData == freezed
          ? _value._activeData
          : activeData // ignore: cast_nullable_to_non_nullable
              as Set<T>,
      data: data == freezed
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<T>,
    ));
  }
}

/// @nodoc

class _$_CustomAddonSetting<T> implements _CustomAddonSetting<T> {
  _$_CustomAddonSetting(
      {required final Set<T> activeData, required final List<T> data})
      : _activeData = activeData,
        _data = data;

  final Set<T> _activeData;
  @override
  Set<T> get activeData {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_activeData);
  }

  final List<T> _data;
  @override
  List<T> get data {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'CustomAddonSetting<$T>(activeData: $activeData, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CustomAddonSetting<T> &&
            const DeepCollectionEquality()
                .equals(other._activeData, _activeData) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_activeData),
      const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  _$$_CustomAddonSettingCopyWith<T, _$_CustomAddonSetting<T>> get copyWith =>
      __$$_CustomAddonSettingCopyWithImpl<T, _$_CustomAddonSetting<T>>(
          this, _$identity);
}

abstract class _CustomAddonSetting<T> implements CustomAddonSetting<T> {
  factory _CustomAddonSetting(
      {required final Set<T> activeData,
      required final List<T> data}) = _$_CustomAddonSetting<T>;

  @override
  Set<T> get activeData;
  @override
  List<T> get data;
  @override
  @JsonKey(ignore: true)
  _$$_CustomAddonSettingCopyWith<T, _$_CustomAddonSetting<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
