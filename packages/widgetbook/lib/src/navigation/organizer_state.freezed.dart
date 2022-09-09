// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'organizer_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
abstract class _$$_OrganizerStateCopyWith<$Res>
    implements $OrganizerStateCopyWith<$Res> {
  factory _$$_OrganizerStateCopyWith(
          _$_OrganizerState value, $Res Function(_$_OrganizerState) then) =
      __$$_OrganizerStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<WidgetbookCategory> allCategories,
      List<WidgetbookCategory> filteredCategories,
      String searchTerm});
}

/// @nodoc
class __$$_OrganizerStateCopyWithImpl<$Res>
    extends _$OrganizerStateCopyWithImpl<$Res>
    implements _$$_OrganizerStateCopyWith<$Res> {
  __$$_OrganizerStateCopyWithImpl(
      _$_OrganizerState _value, $Res Function(_$_OrganizerState) _then)
      : super(_value, (v) => _then(v as _$_OrganizerState));

  @override
  _$_OrganizerState get _value => super._value as _$_OrganizerState;

  @override
  $Res call({
    Object? allCategories = freezed,
    Object? filteredCategories = freezed,
    Object? searchTerm = freezed,
  }) {
    return _then(_$_OrganizerState(
      allCategories: allCategories == freezed
          ? _value._allCategories
          : allCategories // ignore: cast_nullable_to_non_nullable
              as List<WidgetbookCategory>,
      filteredCategories: filteredCategories == freezed
          ? _value._filteredCategories
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
      {required final List<WidgetbookCategory> allCategories,
      required final List<WidgetbookCategory> filteredCategories,
      required this.searchTerm})
      : _allCategories = allCategories,
        _filteredCategories = filteredCategories;

  final List<WidgetbookCategory> _allCategories;
  @override
  List<WidgetbookCategory> get allCategories {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allCategories);
  }

  final List<WidgetbookCategory> _filteredCategories;
  @override
  List<WidgetbookCategory> get filteredCategories {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredCategories);
  }

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
            other is _$_OrganizerState &&
            const DeepCollectionEquality()
                .equals(other._allCategories, _allCategories) &&
            const DeepCollectionEquality()
                .equals(other._filteredCategories, _filteredCategories) &&
            const DeepCollectionEquality()
                .equals(other.searchTerm, searchTerm));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_allCategories),
      const DeepCollectionEquality().hash(_filteredCategories),
      const DeepCollectionEquality().hash(searchTerm));

  @JsonKey(ignore: true)
  @override
  _$$_OrganizerStateCopyWith<_$_OrganizerState> get copyWith =>
      __$$_OrganizerStateCopyWithImpl<_$_OrganizerState>(this, _$identity);
}

abstract class _OrganizerState implements OrganizerState {
  factory _OrganizerState(
      {required final List<WidgetbookCategory> allCategories,
      required final List<WidgetbookCategory> filteredCategories,
      required final String searchTerm}) = _$_OrganizerState;

  @override
  List<WidgetbookCategory> get allCategories;
  @override
  List<WidgetbookCategory> get filteredCategories;
  @override
  String get searchTerm;
  @override
  @JsonKey(ignore: true)
  _$$_OrganizerStateCopyWith<_$_OrganizerState> get copyWith =>
      throw _privateConstructorUsedError;
}
