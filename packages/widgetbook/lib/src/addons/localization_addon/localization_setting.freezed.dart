// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'localization_setting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LocalizationSetting {
  Set<Locale> get activeLocales => throw _privateConstructorUsedError;
  List<Locale> get locales => throw _privateConstructorUsedError;
  List<LocalizationsDelegate<dynamic>> get localizationsDelegates =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LocalizationSettingCopyWith<LocalizationSetting> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocalizationSettingCopyWith<$Res> {
  factory $LocalizationSettingCopyWith(
          LocalizationSetting value, $Res Function(LocalizationSetting) then) =
      _$LocalizationSettingCopyWithImpl<$Res>;
  $Res call(
      {Set<Locale> activeLocales,
      List<Locale> locales,
      List<LocalizationsDelegate<dynamic>> localizationsDelegates});
}

/// @nodoc
class _$LocalizationSettingCopyWithImpl<$Res>
    implements $LocalizationSettingCopyWith<$Res> {
  _$LocalizationSettingCopyWithImpl(this._value, this._then);

  final LocalizationSetting _value;
  // ignore: unused_field
  final $Res Function(LocalizationSetting) _then;

  @override
  $Res call({
    Object? activeLocales = freezed,
    Object? locales = freezed,
    Object? localizationsDelegates = freezed,
  }) {
    return _then(_value.copyWith(
      activeLocales: activeLocales == freezed
          ? _value.activeLocales
          : activeLocales // ignore: cast_nullable_to_non_nullable
              as Set<Locale>,
      locales: locales == freezed
          ? _value.locales
          : locales // ignore: cast_nullable_to_non_nullable
              as List<Locale>,
      localizationsDelegates: localizationsDelegates == freezed
          ? _value.localizationsDelegates
          : localizationsDelegates // ignore: cast_nullable_to_non_nullable
              as List<LocalizationsDelegate<dynamic>>,
    ));
  }
}

/// @nodoc
abstract class _$$_LocalizationSettingCopyWith<$Res>
    implements $LocalizationSettingCopyWith<$Res> {
  factory _$$_LocalizationSettingCopyWith(_$_LocalizationSetting value,
          $Res Function(_$_LocalizationSetting) then) =
      __$$_LocalizationSettingCopyWithImpl<$Res>;
  @override
  $Res call(
      {Set<Locale> activeLocales,
      List<Locale> locales,
      List<LocalizationsDelegate<dynamic>> localizationsDelegates});
}

/// @nodoc
class __$$_LocalizationSettingCopyWithImpl<$Res>
    extends _$LocalizationSettingCopyWithImpl<$Res>
    implements _$$_LocalizationSettingCopyWith<$Res> {
  __$$_LocalizationSettingCopyWithImpl(_$_LocalizationSetting _value,
      $Res Function(_$_LocalizationSetting) _then)
      : super(_value, (v) => _then(v as _$_LocalizationSetting));

  @override
  _$_LocalizationSetting get _value => super._value as _$_LocalizationSetting;

  @override
  $Res call({
    Object? activeLocales = freezed,
    Object? locales = freezed,
    Object? localizationsDelegates = freezed,
  }) {
    return _then(_$_LocalizationSetting(
      activeLocales: activeLocales == freezed
          ? _value._activeLocales
          : activeLocales // ignore: cast_nullable_to_non_nullable
              as Set<Locale>,
      locales: locales == freezed
          ? _value._locales
          : locales // ignore: cast_nullable_to_non_nullable
              as List<Locale>,
      localizationsDelegates: localizationsDelegates == freezed
          ? _value._localizationsDelegates
          : localizationsDelegates // ignore: cast_nullable_to_non_nullable
              as List<LocalizationsDelegate<dynamic>>,
    ));
  }
}

/// @nodoc

class _$_LocalizationSetting implements _LocalizationSetting {
  _$_LocalizationSetting(
      {required final Set<Locale> activeLocales,
      required final List<Locale> locales,
      required final List<LocalizationsDelegate<dynamic>>
          localizationsDelegates})
      : _activeLocales = activeLocales,
        _locales = locales,
        _localizationsDelegates = localizationsDelegates;

  final Set<Locale> _activeLocales;
  @override
  Set<Locale> get activeLocales {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_activeLocales);
  }

  final List<Locale> _locales;
  @override
  List<Locale> get locales {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_locales);
  }

  final List<LocalizationsDelegate<dynamic>> _localizationsDelegates;
  @override
  List<LocalizationsDelegate<dynamic>> get localizationsDelegates {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_localizationsDelegates);
  }

  @override
  String toString() {
    return 'LocalizationSetting(activeLocales: $activeLocales, locales: $locales, localizationsDelegates: $localizationsDelegates)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LocalizationSetting &&
            const DeepCollectionEquality()
                .equals(other._activeLocales, _activeLocales) &&
            const DeepCollectionEquality().equals(other._locales, _locales) &&
            const DeepCollectionEquality().equals(
                other._localizationsDelegates, _localizationsDelegates));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_activeLocales),
      const DeepCollectionEquality().hash(_locales),
      const DeepCollectionEquality().hash(_localizationsDelegates));

  @JsonKey(ignore: true)
  @override
  _$$_LocalizationSettingCopyWith<_$_LocalizationSetting> get copyWith =>
      __$$_LocalizationSettingCopyWithImpl<_$_LocalizationSetting>(
          this, _$identity);
}

abstract class _LocalizationSetting implements LocalizationSetting {
  factory _LocalizationSetting(
      {required final Set<Locale> activeLocales,
      required final List<Locale> locales,
      required final List<LocalizationsDelegate<dynamic>>
          localizationsDelegates}) = _$_LocalizationSetting;

  @override
  Set<Locale> get activeLocales;
  @override
  List<Locale> get locales;
  @override
  List<LocalizationsDelegate<dynamic>> get localizationsDelegates;
  @override
  @JsonKey(ignore: true)
  _$$_LocalizationSettingCopyWith<_$_LocalizationSetting> get copyWith =>
      throw _privateConstructorUsedError;
}
