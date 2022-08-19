// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'localization_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LocalizationData {
  Locale get activeLocale => throw _privateConstructorUsedError;
  List<Locale> get supportedLocales => throw _privateConstructorUsedError;
  List<LocalizationsDelegate<dynamic>> get localizationsDelegates =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LocalizationDataCopyWith<LocalizationData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocalizationDataCopyWith<$Res> {
  factory $LocalizationDataCopyWith(
          LocalizationData value, $Res Function(LocalizationData) then) =
      _$LocalizationDataCopyWithImpl<$Res>;
  $Res call(
      {Locale activeLocale,
      List<Locale> supportedLocales,
      List<LocalizationsDelegate<dynamic>> localizationsDelegates});
}

/// @nodoc
class _$LocalizationDataCopyWithImpl<$Res>
    implements $LocalizationDataCopyWith<$Res> {
  _$LocalizationDataCopyWithImpl(this._value, this._then);

  final LocalizationData _value;
  // ignore: unused_field
  final $Res Function(LocalizationData) _then;

  @override
  $Res call({
    Object? activeLocale = freezed,
    Object? supportedLocales = freezed,
    Object? localizationsDelegates = freezed,
  }) {
    return _then(_value.copyWith(
      activeLocale: activeLocale == freezed
          ? _value.activeLocale
          : activeLocale // ignore: cast_nullable_to_non_nullable
              as Locale,
      supportedLocales: supportedLocales == freezed
          ? _value.supportedLocales
          : supportedLocales // ignore: cast_nullable_to_non_nullable
              as List<Locale>,
      localizationsDelegates: localizationsDelegates == freezed
          ? _value.localizationsDelegates
          : localizationsDelegates // ignore: cast_nullable_to_non_nullable
              as List<LocalizationsDelegate<dynamic>>,
    ));
  }
}

/// @nodoc
abstract class _$$_LocalizationDataCopyWith<$Res>
    implements $LocalizationDataCopyWith<$Res> {
  factory _$$_LocalizationDataCopyWith(
          _$_LocalizationData value, $Res Function(_$_LocalizationData) then) =
      __$$_LocalizationDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {Locale activeLocale,
      List<Locale> supportedLocales,
      List<LocalizationsDelegate<dynamic>> localizationsDelegates});
}

/// @nodoc
class __$$_LocalizationDataCopyWithImpl<$Res>
    extends _$LocalizationDataCopyWithImpl<$Res>
    implements _$$_LocalizationDataCopyWith<$Res> {
  __$$_LocalizationDataCopyWithImpl(
      _$_LocalizationData _value, $Res Function(_$_LocalizationData) _then)
      : super(_value, (v) => _then(v as _$_LocalizationData));

  @override
  _$_LocalizationData get _value => super._value as _$_LocalizationData;

  @override
  $Res call({
    Object? activeLocale = freezed,
    Object? supportedLocales = freezed,
    Object? localizationsDelegates = freezed,
  }) {
    return _then(_$_LocalizationData(
      activeLocale: activeLocale == freezed
          ? _value.activeLocale
          : activeLocale // ignore: cast_nullable_to_non_nullable
              as Locale,
      supportedLocales: supportedLocales == freezed
          ? _value._supportedLocales
          : supportedLocales // ignore: cast_nullable_to_non_nullable
              as List<Locale>,
      localizationsDelegates: localizationsDelegates == freezed
          ? _value._localizationsDelegates
          : localizationsDelegates // ignore: cast_nullable_to_non_nullable
              as List<LocalizationsDelegate<dynamic>>,
    ));
  }
}

/// @nodoc

class _$_LocalizationData implements _LocalizationData {
  _$_LocalizationData(
      {required this.activeLocale,
      required final List<Locale> supportedLocales,
      required final List<LocalizationsDelegate<dynamic>>
          localizationsDelegates})
      : _supportedLocales = supportedLocales,
        _localizationsDelegates = localizationsDelegates;

  @override
  final Locale activeLocale;
  final List<Locale> _supportedLocales;
  @override
  List<Locale> get supportedLocales {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_supportedLocales);
  }

  final List<LocalizationsDelegate<dynamic>> _localizationsDelegates;
  @override
  List<LocalizationsDelegate<dynamic>> get localizationsDelegates {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_localizationsDelegates);
  }

  @override
  String toString() {
    return 'LocalizationData(activeLocale: $activeLocale, supportedLocales: $supportedLocales, localizationsDelegates: $localizationsDelegates)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LocalizationData &&
            const DeepCollectionEquality()
                .equals(other.activeLocale, activeLocale) &&
            const DeepCollectionEquality()
                .equals(other._supportedLocales, _supportedLocales) &&
            const DeepCollectionEquality().equals(
                other._localizationsDelegates, _localizationsDelegates));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(activeLocale),
      const DeepCollectionEquality().hash(_supportedLocales),
      const DeepCollectionEquality().hash(_localizationsDelegates));

  @JsonKey(ignore: true)
  @override
  _$$_LocalizationDataCopyWith<_$_LocalizationData> get copyWith =>
      __$$_LocalizationDataCopyWithImpl<_$_LocalizationData>(this, _$identity);
}

abstract class _LocalizationData implements LocalizationData {
  factory _LocalizationData(
      {required final Locale activeLocale,
      required final List<Locale> supportedLocales,
      required final List<LocalizationsDelegate<dynamic>>
          localizationsDelegates}) = _$_LocalizationData;

  @override
  Locale get activeLocale => throw _privateConstructorUsedError;
  @override
  List<Locale> get supportedLocales => throw _privateConstructorUsedError;
  @override
  List<LocalizationsDelegate<dynamic>> get localizationsDelegates =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_LocalizationDataCopyWith<_$_LocalizationData> get copyWith =>
      throw _privateConstructorUsedError;
}
