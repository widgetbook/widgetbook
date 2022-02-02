// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'localization_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$LocalizationStateTearOff {
  const _$LocalizationStateTearOff();

  _LocalizationState call(
      {List<LocalizationsDelegate<dynamic>>? localizationsDelegates}) {
    return _LocalizationState(
      localizationsDelegates: localizationsDelegates,
    );
  }
}

/// @nodoc
const $LocalizationState = _$LocalizationStateTearOff();

/// @nodoc
mixin _$LocalizationState {
  List<LocalizationsDelegate<dynamic>>? get localizationsDelegates =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LocalizationStateCopyWith<LocalizationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocalizationStateCopyWith<$Res> {
  factory $LocalizationStateCopyWith(
          LocalizationState value, $Res Function(LocalizationState) then) =
      _$LocalizationStateCopyWithImpl<$Res>;
  $Res call({List<LocalizationsDelegate<dynamic>>? localizationsDelegates});
}

/// @nodoc
class _$LocalizationStateCopyWithImpl<$Res>
    implements $LocalizationStateCopyWith<$Res> {
  _$LocalizationStateCopyWithImpl(this._value, this._then);

  final LocalizationState _value;
  // ignore: unused_field
  final $Res Function(LocalizationState) _then;

  @override
  $Res call({
    Object? localizationsDelegates = freezed,
  }) {
    return _then(_value.copyWith(
      localizationsDelegates: localizationsDelegates == freezed
          ? _value.localizationsDelegates
          : localizationsDelegates // ignore: cast_nullable_to_non_nullable
              as List<LocalizationsDelegate<dynamic>>?,
    ));
  }
}

/// @nodoc
abstract class _$LocalizationStateCopyWith<$Res>
    implements $LocalizationStateCopyWith<$Res> {
  factory _$LocalizationStateCopyWith(
          _LocalizationState value, $Res Function(_LocalizationState) then) =
      __$LocalizationStateCopyWithImpl<$Res>;
  @override
  $Res call({List<LocalizationsDelegate<dynamic>>? localizationsDelegates});
}

/// @nodoc
class __$LocalizationStateCopyWithImpl<$Res>
    extends _$LocalizationStateCopyWithImpl<$Res>
    implements _$LocalizationStateCopyWith<$Res> {
  __$LocalizationStateCopyWithImpl(
      _LocalizationState _value, $Res Function(_LocalizationState) _then)
      : super(_value, (v) => _then(v as _LocalizationState));

  @override
  _LocalizationState get _value => super._value as _LocalizationState;

  @override
  $Res call({
    Object? localizationsDelegates = freezed,
  }) {
    return _then(_LocalizationState(
      localizationsDelegates: localizationsDelegates == freezed
          ? _value.localizationsDelegates
          : localizationsDelegates // ignore: cast_nullable_to_non_nullable
              as List<LocalizationsDelegate<dynamic>>?,
    ));
  }
}

/// @nodoc

class _$_LocalizationState implements _LocalizationState {
  _$_LocalizationState({this.localizationsDelegates});

  @override
  final List<LocalizationsDelegate<dynamic>>? localizationsDelegates;

  @override
  String toString() {
    return 'LocalizationState(localizationsDelegates: $localizationsDelegates)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LocalizationState &&
            const DeepCollectionEquality()
                .equals(other.localizationsDelegates, localizationsDelegates));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(localizationsDelegates));

  @JsonKey(ignore: true)
  @override
  _$LocalizationStateCopyWith<_LocalizationState> get copyWith =>
      __$LocalizationStateCopyWithImpl<_LocalizationState>(this, _$identity);
}

abstract class _LocalizationState implements LocalizationState {
  factory _LocalizationState(
          {List<LocalizationsDelegate<dynamic>>? localizationsDelegates}) =
      _$_LocalizationState;

  @override
  List<LocalizationsDelegate<dynamic>>? get localizationsDelegates;
  @override
  @JsonKey(ignore: true)
  _$LocalizationStateCopyWith<_LocalizationState> get copyWith =>
      throw _privateConstructorUsedError;
}
