// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'organizer_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$OrganizerStateTearOff {
  const _$OrganizerStateTearOff();

  _OrganizerState call(
      {required List<WidgetbookCategory> allCategories,
      required List<WidgetbookCategory> filteredCategories,
      required String searchTerm}) {
    return _OrganizerState(
      allCategories: allCategories,
      filteredCategories: filteredCategories,
      searchTerm: searchTerm,
    );
  }
}

/// @nodoc
const $OrganizerState = _$OrganizerStateTearOff();

/// @nodoc
mixin _$OrganizerState {
  List<WidgetbookCategory> get allCategories =>
      throw _privateConstructorUsedError;
  List<WidgetbookCategory> get filteredCategories =>
      throw _privateConstructorUsedError;
  String get searchTerm => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OrganizerStateCopyWith<OrganizerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrganizerStateCopyWith<$Res> {
  factory $OrganizerStateCopyWith(
          OrganizerState value, $Res Function(OrganizerState) then) =
      _$OrganizerStateCopyWithImpl<$Res>;
  $Res call(
      {List<WidgetbookCategory> allCategories,
      List<WidgetbookCategory> filteredCategories,
      String searchTerm});
}

/// @nodoc
class _$OrganizerStateCopyWithImpl<$Res>
    implements $OrganizerStateCopyWith<$Res> {
  _$OrganizerStateCopyWithImpl(this._value, this._then);

  final OrganizerState _value;
  // ignore: unused_field
  final $Res Function(OrganizerState) _then;

  @override
  $Res call({
    Object? allCategories = freezed,
    Object? filteredCategories = freezed,
    Object? searchTerm = freezed,
  }) {
    return _then(_value.copyWith(
      allCategories: allCategories == freezed
          ? _value.allCategories
          : allCategories // ignore: cast_nullable_to_non_nullable
              as List<WidgetbookCategory>,
      filteredCategories: filteredCategories == freezed
          ? _value.filteredCategories
          : filteredCategories // ignore: cast_nullable_to_non_nullable
              as List<WidgetbookCategory>,
      searchTerm: searchTerm == freezed
          ? _value.searchTerm
          : searchTerm // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$OrganizerStateCopyWith<$Res>
    implements $OrganizerStateCopyWith<$Res> {
  factory _$OrganizerStateCopyWith(
          _OrganizerState value, $Res Function(_OrganizerState) then) =
      __$OrganizerStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<WidgetbookCategory> allCategories,
      List<WidgetbookCategory> filteredCategories,
      String searchTerm});
}

/// @nodoc
class __$OrganizerStateCopyWithImpl<$Res>
    extends _$OrganizerStateCopyWithImpl<$Res>
    implements _$OrganizerStateCopyWith<$Res> {
  __$OrganizerStateCopyWithImpl(
      _OrganizerState _value, $Res Function(_OrganizerState) _then)
      : super(_value, (v) => _then(v as _OrganizerState));

  @override
  _OrganizerState get _value => super._value as _OrganizerState;

  @override
  $Res call({
    Object? allCategories = freezed,
    Object? filteredCategories = freezed,
    Object? searchTerm = freezed,
  }) {
    return _then(_OrganizerState(
      allCategories: allCategories == freezed
          ? _value.allCategories
          : allCategories // ignore: cast_nullable_to_non_nullable
              as List<WidgetbookCategory>,
      filteredCategories: filteredCategories == freezed
          ? _value.filteredCategories
          : filteredCategories // ignore: cast_nullable_to_non_nullable
              as List<WidgetbookCategory>,
      searchTerm: searchTerm == freezed
          ? _value.searchTerm
          : searchTerm // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_OrganizerState implements _OrganizerState {
  _$_OrganizerState(
      {required this.allCategories,
      required this.filteredCategories,
      required this.searchTerm});

  @override
  final List<WidgetbookCategory> allCategories;
  @override
  final List<WidgetbookCategory> filteredCategories;
  @override
  final String searchTerm;

  @override
  String toString() {
    return 'OrganizerState(allCategories: $allCategories, filteredCategories: $filteredCategories, searchTerm: $searchTerm)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OrganizerState &&
            const DeepCollectionEquality()
                .equals(other.allCategories, allCategories) &&
            const DeepCollectionEquality()
                .equals(other.filteredCategories, filteredCategories) &&
            const DeepCollectionEquality()
                .equals(other.searchTerm, searchTerm));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(allCategories),
      const DeepCollectionEquality().hash(filteredCategories),
      const DeepCollectionEquality().hash(searchTerm));

  @JsonKey(ignore: true)
  @override
  _$OrganizerStateCopyWith<_OrganizerState> get copyWith =>
      __$OrganizerStateCopyWithImpl<_OrganizerState>(this, _$identity);
}

abstract class _OrganizerState implements OrganizerState {
  factory _OrganizerState(
      {required List<WidgetbookCategory> allCategories,
      required List<WidgetbookCategory> filteredCategories,
      required String searchTerm}) = _$_OrganizerState;

  @override
  List<WidgetbookCategory> get allCategories;
  @override
  List<WidgetbookCategory> get filteredCategories;
  @override
  String get searchTerm;
  @override
  @JsonKey(ignore: true)
  _$OrganizerStateCopyWith<_OrganizerState> get copyWith =>
      throw _privateConstructorUsedError;
}
