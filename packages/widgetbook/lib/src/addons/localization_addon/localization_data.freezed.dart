// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
      _$LocalizationDataCopyWithImpl<$Res, LocalizationData>;
  @useResult
  $Res call(
      {Locale activeLocale,
      List<Locale> supportedLocales,
      List<LocalizationsDelegate<dynamic>> localizationsDelegates});
}

/// @nodoc
class _$LocalizationDataCopyWithImpl<$Res, $Val extends LocalizationData>
    implements $LocalizationDataCopyWith<$Res> {
  _$LocalizationDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeLocale = null,
    Object? supportedLocales = null,
    Object? localizationsDelegates = null,
  }) {
    return _then(_value.copyWith(
      activeLocale: null == activeLocale
          ? _value.activeLocale
          : activeLocale // ignore: cast_nullable_to_non_nullable
              as Locale,
      supportedLocales: null == supportedLocales
          ? _value.supportedLocales
          : supportedLocales // ignore: cast_nullable_to_non_nullable
              as List<Locale>,
      localizationsDelegates: null == localizationsDelegates
          ? _value.localizationsDelegates
          : localizationsDelegates // ignore: cast_nullable_to_non_nullable
              as List<LocalizationsDelegate<dynamic>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LocalizationDataCopyWith<$Res>
    implements $LocalizationDataCopyWith<$Res> {
  factory _$$_LocalizationDataCopyWith(
          _$_LocalizationData value, $Res Function(_$_LocalizationData) then) =
      __$$_LocalizationDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Locale activeLocale,
      List<Locale> supportedLocales,
      List<LocalizationsDelegate<dynamic>> localizationsDelegates});
}

/// @nodoc
class __$$_LocalizationDataCopyWithImpl<$Res>
    extends _$LocalizationDataCopyWithImpl<$Res, _$_LocalizationData>
    implements _$$_LocalizationDataCopyWith<$Res> {
  __$$_LocalizationDataCopyWithImpl(
      _$_LocalizationData _value, $Res Function(_$_LocalizationData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeLocale = null,
    Object? supportedLocales = null,
    Object? localizationsDelegates = null,
  }) {
    return _then(_$_LocalizationData(
      activeLocale: null == activeLocale
          ? _value.activeLocale
          : activeLocale // ignore: cast_nullable_to_non_nullable
              as Locale,
      supportedLocales: null == supportedLocales
          ? _value._supportedLocales
          : supportedLocales // ignore: cast_nullable_to_non_nullable
              as List<Locale>,
      localizationsDelegates: null == localizationsDelegates
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
    if (_supportedLocales is EqualUnmodifiableListView)
      return _supportedLocales;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_supportedLocales);
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
    return 'LocalizationData(activeLocale: $activeLocale, supportedLocales: $supportedLocales, localizationsDelegates: $localizationsDelegates)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LocalizationData &&
            (identical(other.activeLocale, activeLocale) ||
                other.activeLocale == activeLocale) &&
            const DeepCollectionEquality()
                .equals(other._supportedLocales, _supportedLocales) &&
            const DeepCollectionEquality().equals(
                other._localizationsDelegates, _localizationsDelegates));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      activeLocale,
      const DeepCollectionEquality().hash(_supportedLocales),
      const DeepCollectionEquality().hash(_localizationsDelegates));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
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
  Locale get activeLocale;
  @override
  List<Locale> get supportedLocales;
  @override
  List<LocalizationsDelegate<dynamic>> get localizationsDelegates;
  @override
  @JsonKey(ignore: true)
  _$$_LocalizationDataCopyWith<_$_LocalizationData> get copyWith =>
      throw _privateConstructorUsedError;
}
