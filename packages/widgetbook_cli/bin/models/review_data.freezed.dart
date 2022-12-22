// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'review_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ReviewData {
  List<ChangedUseCase> get useCases => throw _privateConstructorUsedError;
  String get buildId => throw _privateConstructorUsedError;
  String get projectId => throw _privateConstructorUsedError;
  String get baseSha => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ReviewDataCopyWith<ReviewData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewDataCopyWith<$Res> {
  factory $ReviewDataCopyWith(
          ReviewData value, $Res Function(ReviewData) then) =
      _$ReviewDataCopyWithImpl<$Res>;
  $Res call(
      {List<ChangedUseCase> useCases,
      String buildId,
      String projectId,
      String baseSha});
}

/// @nodoc
class _$ReviewDataCopyWithImpl<$Res> implements $ReviewDataCopyWith<$Res> {
  _$ReviewDataCopyWithImpl(this._value, this._then);

  final ReviewData _value;
  // ignore: unused_field
  final $Res Function(ReviewData) _then;

  @override
  $Res call({
    Object? useCases = freezed,
    Object? buildId = freezed,
    Object? projectId = freezed,
    Object? baseSha = freezed,
  }) {
    return _then(_value.copyWith(
      useCases: useCases == freezed
          ? _value.useCases
          : useCases // ignore: cast_nullable_to_non_nullable
              as List<ChangedUseCase>,
      buildId: buildId == freezed
          ? _value.buildId
          : buildId // ignore: cast_nullable_to_non_nullable
              as String,
      projectId: projectId == freezed
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as String,
      baseSha: baseSha == freezed
          ? _value.baseSha
          : baseSha // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_ReviewDataCopyWith<$Res>
    implements $ReviewDataCopyWith<$Res> {
  factory _$$_ReviewDataCopyWith(
          _$_ReviewData value, $Res Function(_$_ReviewData) then) =
      __$$_ReviewDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<ChangedUseCase> useCases,
      String buildId,
      String projectId,
      String baseSha});
}

/// @nodoc
class __$$_ReviewDataCopyWithImpl<$Res> extends _$ReviewDataCopyWithImpl<$Res>
    implements _$$_ReviewDataCopyWith<$Res> {
  __$$_ReviewDataCopyWithImpl(
      _$_ReviewData _value, $Res Function(_$_ReviewData) _then)
      : super(_value, (v) => _then(v as _$_ReviewData));

  @override
  _$_ReviewData get _value => super._value as _$_ReviewData;

  @override
  $Res call({
    Object? useCases = freezed,
    Object? buildId = freezed,
    Object? projectId = freezed,
    Object? baseSha = freezed,
  }) {
    return _then(_$_ReviewData(
      useCases: useCases == freezed
          ? _value._useCases
          : useCases // ignore: cast_nullable_to_non_nullable
              as List<ChangedUseCase>,
      buildId: buildId == freezed
          ? _value.buildId
          : buildId // ignore: cast_nullable_to_non_nullable
              as String,
      projectId: projectId == freezed
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as String,
      baseSha: baseSha == freezed
          ? _value.baseSha
          : baseSha // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ReviewData implements _ReviewData {
  _$_ReviewData(
      {required final List<ChangedUseCase> useCases,
      required this.buildId,
      required this.projectId,
      required this.baseSha})
      : _useCases = useCases;

  final List<ChangedUseCase> _useCases;
  @override
  List<ChangedUseCase> get useCases {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_useCases);
  }

  @override
  final String buildId;
  @override
  final String projectId;
  @override
  final String baseSha;

  @override
  String toString() {
    return 'ReviewData(useCases: $useCases, buildId: $buildId, projectId: $projectId, baseSha: $baseSha)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReviewData &&
            const DeepCollectionEquality().equals(other._useCases, _useCases) &&
            const DeepCollectionEquality().equals(other.buildId, buildId) &&
            const DeepCollectionEquality().equals(other.projectId, projectId) &&
            const DeepCollectionEquality().equals(other.baseSha, baseSha));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_useCases),
      const DeepCollectionEquality().hash(buildId),
      const DeepCollectionEquality().hash(projectId),
      const DeepCollectionEquality().hash(baseSha));

  @JsonKey(ignore: true)
  @override
  _$$_ReviewDataCopyWith<_$_ReviewData> get copyWith =>
      __$$_ReviewDataCopyWithImpl<_$_ReviewData>(this, _$identity);
}

abstract class _ReviewData implements ReviewData {
  factory _ReviewData(
      {required final List<ChangedUseCase> useCases,
      required final String buildId,
      required final String projectId,
      required final String baseSha}) = _$_ReviewData;

  @override
  List<ChangedUseCase> get useCases => throw _privateConstructorUsedError;
  @override
  String get buildId => throw _privateConstructorUsedError;
  @override
  String get projectId => throw _privateConstructorUsedError;
  @override
  String get baseSha => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ReviewDataCopyWith<_$_ReviewData> get copyWith =>
      throw _privateConstructorUsedError;
}
