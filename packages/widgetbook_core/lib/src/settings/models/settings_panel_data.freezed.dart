// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_panel_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SettingsPanelData {
  String get name => throw _privateConstructorUsedError;
  List<Widget> get settings => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SettingsPanelDataCopyWith<SettingsPanelData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsPanelDataCopyWith<$Res> {
  factory $SettingsPanelDataCopyWith(
          SettingsPanelData value, $Res Function(SettingsPanelData) then) =
      _$SettingsPanelDataCopyWithImpl<$Res, SettingsPanelData>;
  @useResult
  $Res call({String name, List<Widget> settings});
}

/// @nodoc
class _$SettingsPanelDataCopyWithImpl<$Res, $Val extends SettingsPanelData>
    implements $SettingsPanelDataCopyWith<$Res> {
  _$SettingsPanelDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? settings = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      settings: null == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as List<Widget>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SettingsPanelDataCopyWith<$Res>
    implements $SettingsPanelDataCopyWith<$Res> {
  factory _$$_SettingsPanelDataCopyWith(_$_SettingsPanelData value,
          $Res Function(_$_SettingsPanelData) then) =
      __$$_SettingsPanelDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, List<Widget> settings});
}

/// @nodoc
class __$$_SettingsPanelDataCopyWithImpl<$Res>
    extends _$SettingsPanelDataCopyWithImpl<$Res, _$_SettingsPanelData>
    implements _$$_SettingsPanelDataCopyWith<$Res> {
  __$$_SettingsPanelDataCopyWithImpl(
      _$_SettingsPanelData _value, $Res Function(_$_SettingsPanelData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? settings = null,
  }) {
    return _then(_$_SettingsPanelData(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      settings: null == settings
          ? _value._settings
          : settings // ignore: cast_nullable_to_non_nullable
              as List<Widget>,
    ));
  }
}

/// @nodoc

class _$_SettingsPanelData implements _SettingsPanelData {
  _$_SettingsPanelData(
      {required this.name, required final List<Widget> settings})
      : _settings = settings;

  @override
  final String name;
  final List<Widget> _settings;
  @override
  List<Widget> get settings {
    if (_settings is EqualUnmodifiableListView) return _settings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_settings);
  }

  @override
  String toString() {
    return 'SettingsPanelData(name: $name, settings: $settings)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SettingsPanelData &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._settings, _settings));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, name, const DeepCollectionEquality().hash(_settings));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SettingsPanelDataCopyWith<_$_SettingsPanelData> get copyWith =>
      __$$_SettingsPanelDataCopyWithImpl<_$_SettingsPanelData>(
          this, _$identity);
}

abstract class _SettingsPanelData implements SettingsPanelData {
  factory _SettingsPanelData(
      {required final String name,
      required final List<Widget> settings}) = _$_SettingsPanelData;

  @override
  String get name;
  @override
  List<Widget> get settings;
  @override
  @JsonKey(ignore: true)
  _$$_SettingsPanelDataCopyWith<_$_SettingsPanelData> get copyWith =>
      throw _privateConstructorUsedError;
}
