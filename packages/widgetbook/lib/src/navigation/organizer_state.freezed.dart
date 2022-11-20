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
  /// The categories before any filter or sorting has been applied
  List<WidgetbookCategory> get initialCategories =>
      throw _privateConstructorUsedError;

  /// The categories that are filtered and sorted.
  List<WidgetbookCategory> get categories => throw _privateConstructorUsedError;
  String get searchTerm => throw _privateConstructorUsedError;
  Sorting? get sorting => throw _privateConstructorUsedError;

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
      {List<WidgetbookCategory> initialCategories,
      List<WidgetbookCategory> categories,
      String searchTerm,
      Sorting? sorting});
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
    Object? initialCategories = freezed,
    Object? categories = freezed,
    Object? searchTerm = freezed,
    Object? sorting = freezed,
  }) {
    return _then(_value.copyWith(
      initialCategories: initialCategories == freezed
          ? _value.initialCategories
          : initialCategories // ignore: cast_nullable_to_non_nullable
              as List<WidgetbookCategory>,
      categories: categories == freezed
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<WidgetbookCategory>,
      searchTerm: searchTerm == freezed
          ? _value.searchTerm
          : searchTerm // ignore: cast_nullable_to_non_nullable
              as String,
      sorting: sorting == freezed
          ? _value.sorting
          : sorting // ignore: cast_nullable_to_non_nullable
              as Sorting?,
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
      {List<WidgetbookCategory> initialCategories,
      List<WidgetbookCategory> categories,
      String searchTerm,
      Sorting? sorting});
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
    Object? initialCategories = freezed,
    Object? categories = freezed,
    Object? searchTerm = freezed,
    Object? sorting = freezed,
  }) {
    return _then(_$_OrganizerState(
      initialCategories: initialCategories == freezed
          ? _value._initialCategories
          : initialCategories // ignore: cast_nullable_to_non_nullable
              as List<WidgetbookCategory>,
      categories: categories == freezed
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<WidgetbookCategory>,
      searchTerm: searchTerm == freezed
          ? _value.searchTerm
          : searchTerm // ignore: cast_nullable_to_non_nullable
              as String,
      sorting: sorting == freezed
          ? _value.sorting
          : sorting // ignore: cast_nullable_to_non_nullable
              as Sorting?,
    ));
  }
}

/// @nodoc

class _$_OrganizerState implements _OrganizerState {
  _$_OrganizerState(
      {required final List<WidgetbookCategory> initialCategories,
      required final List<WidgetbookCategory> categories,
      required this.searchTerm,
      this.sorting})
      : _initialCategories = initialCategories,
        _categories = categories;

  /// The categories before any filter or sorting has been applied
  final List<WidgetbookCategory> _initialCategories;

  /// The categories before any filter or sorting has been applied
  @override
  List<WidgetbookCategory> get initialCategories {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_initialCategories);
  }

  /// The categories that are filtered and sorted.
  final List<WidgetbookCategory> _categories;

  /// The categories that are filtered and sorted.
  @override
  List<WidgetbookCategory> get categories {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  final String searchTerm;
  @override
  final Sorting? sorting;

  @override
  String toString() {
    return 'OrganizerState(initialCategories: $initialCategories, categories: $categories, searchTerm: $searchTerm, sorting: $sorting)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OrganizerState &&
            const DeepCollectionEquality()
                .equals(other._initialCategories, _initialCategories) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality()
                .equals(other.searchTerm, searchTerm) &&
            const DeepCollectionEquality().equals(other.sorting, sorting));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_initialCategories),
      const DeepCollectionEquality().hash(_categories),
      const DeepCollectionEquality().hash(searchTerm),
      const DeepCollectionEquality().hash(sorting));

  @JsonKey(ignore: true)
  @override
  _$$_OrganizerStateCopyWith<_$_OrganizerState> get copyWith =>
      __$$_OrganizerStateCopyWithImpl<_$_OrganizerState>(this, _$identity);
}

abstract class _OrganizerState implements OrganizerState {
  factory _OrganizerState(
      {required final List<WidgetbookCategory> initialCategories,
      required final List<WidgetbookCategory> categories,
      required final String searchTerm,
      final Sorting? sorting}) = _$_OrganizerState;

  @override

  /// The categories before any filter or sorting has been applied
  List<WidgetbookCategory> get initialCategories =>
      throw _privateConstructorUsedError;
  @override

  /// The categories that are filtered and sorted.
  List<WidgetbookCategory> get categories => throw _privateConstructorUsedError;
  @override
  String get searchTerm => throw _privateConstructorUsedError;
  @override
  Sorting? get sorting => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_OrganizerStateCopyWith<_$_OrganizerState> get copyWith =>
      throw _privateConstructorUsedError;
}
