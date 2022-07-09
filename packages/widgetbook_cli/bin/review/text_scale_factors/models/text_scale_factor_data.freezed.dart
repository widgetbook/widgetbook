// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'text_scale_factor_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TextScaleFactorData _$TextScaleFactorDataFromJson(Map<String, dynamic> json) {
  return _TextScaleFactorData.fromJson(json);
}

/// @nodoc
mixin _$TextScaleFactorData {
  double get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TextScaleFactorDataCopyWith<TextScaleFactorData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TextScaleFactorDataCopyWith<$Res> {
  factory $TextScaleFactorDataCopyWith(
          TextScaleFactorData value, $Res Function(TextScaleFactorData) then) =
      _$TextScaleFactorDataCopyWithImpl<$Res>;
  $Res call({double value});
}

/// @nodoc
class _$TextScaleFactorDataCopyWithImpl<$Res>
    implements $TextScaleFactorDataCopyWith<$Res> {
  _$TextScaleFactorDataCopyWithImpl(this._value, this._then);

  final TextScaleFactorData _value;
  // ignore: unused_field
  final $Res Function(TextScaleFactorData) _then;

  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
abstract class _$$_TextScaleFactorDataCopyWith<$Res>
    implements $TextScaleFactorDataCopyWith<$Res> {
  factory _$$_TextScaleFactorDataCopyWith(_$_TextScaleFactorData value,
          $Res Function(_$_TextScaleFactorData) then) =
      __$$_TextScaleFactorDataCopyWithImpl<$Res>;
  @override
  $Res call({double value});
}

/// @nodoc
class __$$_TextScaleFactorDataCopyWithImpl<$Res>
    extends _$TextScaleFactorDataCopyWithImpl<$Res>
    implements _$$_TextScaleFactorDataCopyWith<$Res> {
  __$$_TextScaleFactorDataCopyWithImpl(_$_TextScaleFactorData _value,
      $Res Function(_$_TextScaleFactorData) _then)
      : super(_value, (v) => _then(v as _$_TextScaleFactorData));

  @override
  _$_TextScaleFactorData get _value => super._value as _$_TextScaleFactorData;

  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_$_TextScaleFactorData(
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TextScaleFactorData implements _TextScaleFactorData {
  _$_TextScaleFactorData({required this.value});

  factory _$_TextScaleFactorData.fromJson(Map<String, dynamic> json) =>
      _$$_TextScaleFactorDataFromJson(json);

  @override
  final double value;

  @override
  String toString() {
    return 'TextScaleFactorData(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TextScaleFactorData &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @JsonKey(ignore: true)
  @override
  _$$_TextScaleFactorDataCopyWith<_$_TextScaleFactorData> get copyWith =>
      __$$_TextScaleFactorDataCopyWithImpl<_$_TextScaleFactorData>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TextScaleFactorDataToJson(this);
  }
}

abstract class _TextScaleFactorData implements TextScaleFactorData {
  factory _TextScaleFactorData({required final double value}) =
      _$_TextScaleFactorData;

  factory _TextScaleFactorData.fromJson(Map<String, dynamic> json) =
      _$_TextScaleFactorData.fromJson;

  @override
  double get value => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_TextScaleFactorDataCopyWith<_$_TextScaleFactorData> get copyWith =>
      throw _privateConstructorUsedError;
}
