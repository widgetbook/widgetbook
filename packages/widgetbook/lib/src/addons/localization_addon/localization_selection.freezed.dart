// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'localization_selection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LocalizationSelection {
  Set<Locale> get activeLocales => throw _privateConstructorUsedError;
  List<Locale> get locales => throw _privateConstructorUsedError;
  List<LocalizationsDelegate<dynamic>> get localizationsDelegates =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LocalizationSelectionCopyWith<LocalizationSelection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocalizationSelectionCopyWith<$Res> {
  factory $LocalizationSelectionCopyWith(LocalizationSelection value,
          $Res Function(LocalizationSelection) then) =
      _$LocalizationSelectionCopyWithImpl<$Res>;
  $Res call(
      {Set<Locale> activeLocales,
      List<Locale> locales,
      List<LocalizationsDelegate<dynamic>> localizationsDelegates});
}

/// @nodoc
class _$LocalizationSelectionCopyWithImpl<$Res>
    implements $LocalizationSelectionCopyWith<$Res> {
  _$LocalizationSelectionCopyWithImpl(this._value, this._then);

  final LocalizationSelection _value;
  // ignore: unused_field
  final $Res Function(LocalizationSelection) _then;

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
abstract class _$$_LocalizationSelectionCopyWith<$Res>
    implements $LocalizationSelectionCopyWith<$Res> {
  factory _$$_LocalizationSelectionCopyWith(_$_LocalizationSelection value,
          $Res Function(_$_LocalizationSelection) then) =
      __$$_LocalizationSelectionCopyWithImpl<$Res>;
  @override
  $Res call(
      {Set<Locale> activeLocales,
      List<Locale> locales,
      List<LocalizationsDelegate<dynamic>> localizationsDelegates});
}

/// @nodoc
class __$$_LocalizationSelectionCopyWithImpl<$Res>
    extends _$LocalizationSelectionCopyWithImpl<$Res>
    implements _$$_LocalizationSelectionCopyWith<$Res> {
  __$$_LocalizationSelectionCopyWithImpl(_$_LocalizationSelection _value,
      $Res Function(_$_LocalizationSelection) _then)
      : super(_value, (v) => _then(v as _$_LocalizationSelection));

  @override
  _$_LocalizationSelection get _value =>
      super._value as _$_LocalizationSelection;

  @override
  $Res call({
    Object? activeLocales = freezed,
    Object? locales = freezed,
    Object? localizationsDelegates = freezed,
  }) {
    return _then(_$_LocalizationSelection(
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

class _$_LocalizationSelection implements _LocalizationSelection {
  _$_LocalizationSelection(
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
    return 'LocalizationSelection(activeLocales: $activeLocales, locales: $locales, localizationsDelegates: $localizationsDelegates)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LocalizationSelection &&
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
  _$$_LocalizationSelectionCopyWith<_$_LocalizationSelection> get copyWith =>
      __$$_LocalizationSelectionCopyWithImpl<_$_LocalizationSelection>(
          this, _$identity);
}

abstract class _LocalizationSelection implements LocalizationSelection {
  factory _LocalizationSelection(
      {required final Set<Locale> activeLocales,
      required final List<Locale> locales,
      required final List<LocalizationsDelegate<dynamic>>
          localizationsDelegates}) = _$_LocalizationSelection;

  @override
  Set<Locale> get activeLocales => throw _privateConstructorUsedError;
  @override
  List<Locale> get locales => throw _privateConstructorUsedError;
  @override
  List<LocalizationsDelegate<dynamic>> get localizationsDelegates =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_LocalizationSelectionCopyWith<_$_LocalizationSelection> get copyWith =>
      throw _privateConstructorUsedError;
}
