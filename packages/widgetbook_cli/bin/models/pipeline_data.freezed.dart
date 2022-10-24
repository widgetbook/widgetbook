// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'pipeline_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PipelineData _$PipelineDataFromJson(Map<String, dynamic> json) {
  return _PipelineData.fromJson(json);
}

/// @nodoc
mixin _$PipelineData {
  String? get actorName => throw _privateConstructorUsedError;
  String? get repository => throw _privateConstructorUsedError;
  PipelineVendor get pipeline => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PipelineDataCopyWith<PipelineData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PipelineDataCopyWith<$Res> {
  factory $PipelineDataCopyWith(
          PipelineData value, $Res Function(PipelineData) then) =
      _$PipelineDataCopyWithImpl<$Res>;
  $Res call({String? actorName, String? repository, PipelineVendor pipeline});
}

/// @nodoc
class _$PipelineDataCopyWithImpl<$Res> implements $PipelineDataCopyWith<$Res> {
  _$PipelineDataCopyWithImpl(this._value, this._then);

  final PipelineData _value;
  // ignore: unused_field
  final $Res Function(PipelineData) _then;

  @override
  $Res call({
    Object? actorName = freezed,
    Object? repository = freezed,
    Object? pipeline = freezed,
  }) {
    return _then(_value.copyWith(
      actorName: actorName == freezed
          ? _value.actorName
          : actorName // ignore: cast_nullable_to_non_nullable
              as String?,
      repository: repository == freezed
          ? _value.repository
          : repository // ignore: cast_nullable_to_non_nullable
              as String?,
      pipeline: pipeline == freezed
          ? _value.pipeline
          : pipeline // ignore: cast_nullable_to_non_nullable
              as PipelineVendor,
    ));
  }
}

/// @nodoc
abstract class _$$_PipelineDataCopyWith<$Res>
    implements $PipelineDataCopyWith<$Res> {
  factory _$$_PipelineDataCopyWith(
          _$_PipelineData value, $Res Function(_$_PipelineData) then) =
      __$$_PipelineDataCopyWithImpl<$Res>;
  @override
  $Res call({String? actorName, String? repository, PipelineVendor pipeline});
}

/// @nodoc
class __$$_PipelineDataCopyWithImpl<$Res>
    extends _$PipelineDataCopyWithImpl<$Res>
    implements _$$_PipelineDataCopyWith<$Res> {
  __$$_PipelineDataCopyWithImpl(
      _$_PipelineData _value, $Res Function(_$_PipelineData) _then)
      : super(_value, (v) => _then(v as _$_PipelineData));

  @override
  _$_PipelineData get _value => super._value as _$_PipelineData;

  @override
  $Res call({
    Object? actorName = freezed,
    Object? repository = freezed,
    Object? pipeline = freezed,
  }) {
    return _then(_$_PipelineData(
      actorName: actorName == freezed
          ? _value.actorName
          : actorName // ignore: cast_nullable_to_non_nullable
              as String?,
      repository: repository == freezed
          ? _value.repository
          : repository // ignore: cast_nullable_to_non_nullable
              as String?,
      pipeline: pipeline == freezed
          ? _value.pipeline
          : pipeline // ignore: cast_nullable_to_non_nullable
              as PipelineVendor,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PipelineData implements _PipelineData {
  _$_PipelineData({this.actorName, this.repository, required this.pipeline});

  factory _$_PipelineData.fromJson(Map<String, dynamic> json) =>
      _$$_PipelineDataFromJson(json);

  @override
  final String? actorName;
  @override
  final String? repository;
  @override
  final PipelineVendor pipeline;

  @override
  String toString() {
    return 'PipelineData(actorName: $actorName, repository: $repository, pipeline: $pipeline)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PipelineData &&
            const DeepCollectionEquality().equals(other.actorName, actorName) &&
            const DeepCollectionEquality()
                .equals(other.repository, repository) &&
            const DeepCollectionEquality().equals(other.pipeline, pipeline));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(actorName),
      const DeepCollectionEquality().hash(repository),
      const DeepCollectionEquality().hash(pipeline));

  @JsonKey(ignore: true)
  @override
  _$$_PipelineDataCopyWith<_$_PipelineData> get copyWith =>
      __$$_PipelineDataCopyWithImpl<_$_PipelineData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PipelineDataToJson(this);
  }
}

abstract class _PipelineData implements PipelineData {
  factory _PipelineData(
      {final String? actorName,
      final String? repository,
      required final PipelineVendor pipeline}) = _$_PipelineData;

  factory _PipelineData.fromJson(Map<String, dynamic> json) =
      _$_PipelineData.fromJson;

  @override
  String? get actorName => throw _privateConstructorUsedError;
  @override
  String? get repository => throw _privateConstructorUsedError;
  @override
  PipelineVendor get pipeline => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_PipelineDataCopyWith<_$_PipelineData> get copyWith =>
      throw _privateConstructorUsedError;
}
