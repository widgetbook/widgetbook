// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'use_cases_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UseCasesState {
  Map<String, WidgetbookUseCase> get useCases =>
      throw _privateConstructorUsedError;
  String? get selectedUseCasePath => throw _privateConstructorUsedError;
  WidgetbookUseCase? get selectedUseCase => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UseCasesStateCopyWith<UseCasesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UseCasesStateCopyWith<$Res> {
  factory $UseCasesStateCopyWith(
          UseCasesState value, $Res Function(UseCasesState) then) =
      _$UseCasesStateCopyWithImpl<$Res, UseCasesState>;
  @useResult
  $Res call(
      {Map<String, WidgetbookUseCase> useCases,
      String? selectedUseCasePath,
      WidgetbookUseCase? selectedUseCase});
}

/// @nodoc
class _$UseCasesStateCopyWithImpl<$Res, $Val extends UseCasesState>
    implements $UseCasesStateCopyWith<$Res> {
  _$UseCasesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? useCases = null,
    Object? selectedUseCasePath = freezed,
    Object? selectedUseCase = freezed,
  }) {
    return _then(_value.copyWith(
      useCases: null == useCases
          ? _value.useCases
          : useCases // ignore: cast_nullable_to_non_nullable
              as Map<String, WidgetbookUseCase>,
      selectedUseCasePath: freezed == selectedUseCasePath
          ? _value.selectedUseCasePath
          : selectedUseCasePath // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedUseCase: freezed == selectedUseCase
          ? _value.selectedUseCase
          : selectedUseCase // ignore: cast_nullable_to_non_nullable
              as WidgetbookUseCase?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UseCasesStateCopyWith<$Res>
    implements $UseCasesStateCopyWith<$Res> {
  factory _$$_UseCasesStateCopyWith(
          _$_UseCasesState value, $Res Function(_$_UseCasesState) then) =
      __$$_UseCasesStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, WidgetbookUseCase> useCases,
      String? selectedUseCasePath,
      WidgetbookUseCase? selectedUseCase});
}

/// @nodoc
class __$$_UseCasesStateCopyWithImpl<$Res>
    extends _$UseCasesStateCopyWithImpl<$Res, _$_UseCasesState>
    implements _$$_UseCasesStateCopyWith<$Res> {
  __$$_UseCasesStateCopyWithImpl(
      _$_UseCasesState _value, $Res Function(_$_UseCasesState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? useCases = null,
    Object? selectedUseCasePath = freezed,
    Object? selectedUseCase = freezed,
  }) {
    return _then(_$_UseCasesState(
      useCases: null == useCases
          ? _value._useCases
          : useCases // ignore: cast_nullable_to_non_nullable
              as Map<String, WidgetbookUseCase>,
      selectedUseCasePath: freezed == selectedUseCasePath
          ? _value.selectedUseCasePath
          : selectedUseCasePath // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedUseCase: freezed == selectedUseCase
          ? _value.selectedUseCase
          : selectedUseCase // ignore: cast_nullable_to_non_nullable
              as WidgetbookUseCase?,
    ));
  }
}

/// @nodoc

class _$_UseCasesState implements _UseCasesState {
  _$_UseCasesState(
      {final Map<String, WidgetbookUseCase> useCases =
          const <String, WidgetbookUseCase>{},
      this.selectedUseCasePath,
      this.selectedUseCase})
      : _useCases = useCases;

  final Map<String, WidgetbookUseCase> _useCases;
  @override
  @JsonKey()
  Map<String, WidgetbookUseCase> get useCases {
    if (_useCases is EqualUnmodifiableMapView) return _useCases;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_useCases);
  }

  @override
  final String? selectedUseCasePath;
  @override
  final WidgetbookUseCase? selectedUseCase;

  @override
  String toString() {
    return 'UseCasesState(useCases: $useCases, selectedUseCasePath: $selectedUseCasePath, selectedUseCase: $selectedUseCase)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UseCasesState &&
            const DeepCollectionEquality().equals(other._useCases, _useCases) &&
            (identical(other.selectedUseCasePath, selectedUseCasePath) ||
                other.selectedUseCasePath == selectedUseCasePath) &&
            (identical(other.selectedUseCase, selectedUseCase) ||
                other.selectedUseCase == selectedUseCase));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_useCases),
      selectedUseCasePath,
      selectedUseCase);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UseCasesStateCopyWith<_$_UseCasesState> get copyWith =>
      __$$_UseCasesStateCopyWithImpl<_$_UseCasesState>(this, _$identity);
}

abstract class _UseCasesState implements UseCasesState {
  factory _UseCasesState(
      {final Map<String, WidgetbookUseCase> useCases,
      final String? selectedUseCasePath,
      final WidgetbookUseCase? selectedUseCase}) = _$_UseCasesState;

  @override
  Map<String, WidgetbookUseCase> get useCases;
  @override
  String? get selectedUseCasePath;
  @override
  WidgetbookUseCase? get selectedUseCase;
  @override
  @JsonKey(ignore: true)
  _$$_UseCasesStateCopyWith<_$_UseCasesState> get copyWith =>
      throw _privateConstructorUsedError;
}
