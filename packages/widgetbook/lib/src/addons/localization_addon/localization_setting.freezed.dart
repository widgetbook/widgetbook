// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'localization_setting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LocalizationSetting {
  Locale get activeLocale => throw _privateConstructorUsedError;
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
      _$LocalizationSettingCopyWithImpl<$Res, LocalizationSetting>;
  @useResult
  $Res call(
      {Locale activeLocale,
      List<Locale> locales,
      List<LocalizationsDelegate<dynamic>> localizationsDelegates});
}

/// @nodoc
class _$LocalizationSettingCopyWithImpl<$Res, $Val extends LocalizationSetting>
    implements $LocalizationSettingCopyWith<$Res> {
  _$LocalizationSettingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeLocale = null,
    Object? locales = null,
    Object? localizationsDelegates = null,
  }) {
    return _then(_value.copyWith(
      activeLocale: null == activeLocale
          ? _value.activeLocale
          : activeLocale // ignore: cast_nullable_to_non_nullable
              as Locale,
      locales: null == locales
          ? _value.locales
          : locales // ignore: cast_nullable_to_non_nullable
              as List<Locale>,
      localizationsDelegates: null == localizationsDelegates
          ? _value.localizationsDelegates
          : localizationsDelegates // ignore: cast_nullable_to_non_nullable
              as List<LocalizationsDelegate<dynamic>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LocalizationSettingCopyWith<$Res>
    implements $LocalizationSettingCopyWith<$Res> {
  factory _$$_LocalizationSettingCopyWith(_$_LocalizationSetting value,
          $Res Function(_$_LocalizationSetting) then) =
      __$$_LocalizationSettingCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Locale activeLocale,
      List<Locale> locales,
      List<LocalizationsDelegate<dynamic>> localizationsDelegates});
}

/// @nodoc
class __$$_LocalizationSettingCopyWithImpl<$Res>
    extends _$LocalizationSettingCopyWithImpl<$Res, _$_LocalizationSetting>
    implements _$$_LocalizationSettingCopyWith<$Res> {
  __$$_LocalizationSettingCopyWithImpl(_$_LocalizationSetting _value,
      $Res Function(_$_LocalizationSetting) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeLocale = null,
    Object? locales = null,
    Object? localizationsDelegates = null,
  }) {
    return _then(_$_LocalizationSetting(
      activeLocale: null == activeLocale
          ? _value.activeLocale
          : activeLocale // ignore: cast_nullable_to_non_nullable
              as Locale,
      locales: null == locales
          ? _value._locales
          : locales // ignore: cast_nullable_to_non_nullable
              as List<Locale>,
      localizationsDelegates: null == localizationsDelegates
          ? _value._localizationsDelegates
          : localizationsDelegates // ignore: cast_nullable_to_non_nullable
              as List<LocalizationsDelegate<dynamic>>,
    ));
  }
}

/// @nodoc

class _$_LocalizationSetting implements _LocalizationSetting {
  _$_LocalizationSetting(
      {required this.activeLocale,
      required final List<Locale> locales,
      required final List<LocalizationsDelegate<dynamic>>
          localizationsDelegates})
      : assert(locales.isNotEmpty, 'locales cannot be empty'),
        _locales = locales,
        _localizationsDelegates = localizationsDelegates;

  @override
  final Locale activeLocale;
  final List<Locale> _locales;
  @override
  List<Locale> get locales {
    if (_locales is EqualUnmodifiableListView) return _locales;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_locales);
  }

  final List<LocalizationsDelegate<dynamic>> _localizationsDelegates;
  @override
  List<LocalizationsDelegate<dynamic>> get localizationsDelegates {
    if (_localizationsDelegates is EqualUnmodifiableListView)
      return _localizationsDelegates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_localizationsDelegates);
  }

  @override
  String toString() {
    return 'LocalizationSetting(activeLocale: $activeLocale, locales: $locales, localizationsDelegates: $localizationsDelegates)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LocalizationSetting &&
            (identical(other.activeLocale, activeLocale) ||
                other.activeLocale == activeLocale) &&
            const DeepCollectionEquality().equals(other._locales, _locales) &&
            const DeepCollectionEquality().equals(
                other._localizationsDelegates, _localizationsDelegates));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      activeLocale,
      const DeepCollectionEquality().hash(_locales),
      const DeepCollectionEquality().hash(_localizationsDelegates));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LocalizationSettingCopyWith<_$_LocalizationSetting> get copyWith =>
      __$$_LocalizationSettingCopyWithImpl<_$_LocalizationSetting>(
          this, _$identity);
}

abstract class _LocalizationSetting implements LocalizationSetting {
  factory _LocalizationSetting(
      {required final Locale activeLocale,
      required final List<Locale> locales,
      required final List<LocalizationsDelegate<dynamic>>
          localizationsDelegates}) = _$_LocalizationSetting;

  @override
  Locale get activeLocale;
  @override
  List<Locale> get locales;
  @override
  List<LocalizationsDelegate<dynamic>> get localizationsDelegates;
  @override
  @JsonKey(ignore: true)
  _$$_LocalizationSettingCopyWith<_$_LocalizationSetting> get copyWith =>
      throw _privateConstructorUsedError;
}
