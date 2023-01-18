// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'widgetbook_use_case_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WidgetbookUseCaseData {
  String get path => throw _privateConstructorUsedError;
  UseCaseBuilder get builder => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WidgetbookUseCaseDataCopyWith<WidgetbookUseCaseData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WidgetbookUseCaseDataCopyWith<$Res> {
  factory $WidgetbookUseCaseDataCopyWith(WidgetbookUseCaseData value,
          $Res Function(WidgetbookUseCaseData) then) =
      _$WidgetbookUseCaseDataCopyWithImpl<$Res, WidgetbookUseCaseData>;
  @useResult
  $Res call({String path, UseCaseBuilder builder});
}

/// @nodoc
class _$WidgetbookUseCaseDataCopyWithImpl<$Res,
        $Val extends WidgetbookUseCaseData>
    implements $WidgetbookUseCaseDataCopyWith<$Res> {
  _$WidgetbookUseCaseDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? builder = null,
  }) {
    return _then(_value.copyWith(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      builder: null == builder
          ? _value.builder
          : builder // ignore: cast_nullable_to_non_nullable
              as UseCaseBuilder,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WidgetbookUseCaseDataCopyWith<$Res>
    implements $WidgetbookUseCaseDataCopyWith<$Res> {
  factory _$$_WidgetbookUseCaseDataCopyWith(_$_WidgetbookUseCaseData value,
          $Res Function(_$_WidgetbookUseCaseData) then) =
      __$$_WidgetbookUseCaseDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String path, UseCaseBuilder builder});
}

/// @nodoc
class __$$_WidgetbookUseCaseDataCopyWithImpl<$Res>
    extends _$WidgetbookUseCaseDataCopyWithImpl<$Res, _$_WidgetbookUseCaseData>
    implements _$$_WidgetbookUseCaseDataCopyWith<$Res> {
  __$$_WidgetbookUseCaseDataCopyWithImpl(_$_WidgetbookUseCaseData _value,
      $Res Function(_$_WidgetbookUseCaseData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? builder = null,
  }) {
    return _then(_$_WidgetbookUseCaseData(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      builder: null == builder
          ? _value.builder
          : builder // ignore: cast_nullable_to_non_nullable
              as UseCaseBuilder,
    ));
  }
}

/// @nodoc

class _$_WidgetbookUseCaseData implements _WidgetbookUseCaseData {
  const _$_WidgetbookUseCaseData({required this.path, required this.builder});

  @override
  final String path;
  @override
  final UseCaseBuilder builder;

  @override
  String toString() {
    return 'WidgetbookUseCaseData(path: $path, builder: $builder)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WidgetbookUseCaseData &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.builder, builder) || other.builder == builder));
  }

  @override
  int get hashCode => Object.hash(runtimeType, path, builder);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WidgetbookUseCaseDataCopyWith<_$_WidgetbookUseCaseData> get copyWith =>
      __$$_WidgetbookUseCaseDataCopyWithImpl<_$_WidgetbookUseCaseData>(
          this, _$identity);
}

abstract class _WidgetbookUseCaseData implements WidgetbookUseCaseData {
  const factory _WidgetbookUseCaseData(
      {required final String path,
      required final UseCaseBuilder builder}) = _$_WidgetbookUseCaseData;

  @override
  String get path;
  @override
  UseCaseBuilder get builder;
  @override
  @JsonKey(ignore: true)
  _$$_WidgetbookUseCaseDataCopyWith<_$_WidgetbookUseCaseData> get copyWith =>
      throw _privateConstructorUsedError;
}
