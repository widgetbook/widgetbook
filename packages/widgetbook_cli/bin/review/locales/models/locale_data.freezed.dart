// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'locale_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LocaleData _$LocaleDataFromJson(Map<String, dynamic> json) {
  return _LocaleData.fromJson(json);
}

/// @nodoc
mixin _$LocaleData {
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LocaleDataCopyWith<LocaleData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocaleDataCopyWith<$Res> {
  factory $LocaleDataCopyWith(
          LocaleData value, $Res Function(LocaleData) then) =
      _$LocaleDataCopyWithImpl<$Res>;
  $Res call({String name});
}

/// @nodoc
class _$LocaleDataCopyWithImpl<$Res> implements $LocaleDataCopyWith<$Res> {
  _$LocaleDataCopyWithImpl(this._value, this._then);

  final LocaleData _value;
  // ignore: unused_field
  final $Res Function(LocaleData) _then;

  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_LocaleDataCopyWith<$Res>
    implements $LocaleDataCopyWith<$Res> {
  factory _$$_LocaleDataCopyWith(
          _$_LocaleData value, $Res Function(_$_LocaleData) then) =
      __$$_LocaleDataCopyWithImpl<$Res>;
  @override
  $Res call({String name});
}

/// @nodoc
class __$$_LocaleDataCopyWithImpl<$Res> extends _$LocaleDataCopyWithImpl<$Res>
    implements _$$_LocaleDataCopyWith<$Res> {
  __$$_LocaleDataCopyWithImpl(
      _$_LocaleData _value, $Res Function(_$_LocaleData) _then)
      : super(_value, (v) => _then(v as _$_LocaleData));

  @override
  _$_LocaleData get _value => super._value as _$_LocaleData;

  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_$_LocaleData(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LocaleData implements _LocaleData {
  _$_LocaleData({required this.name});

  factory _$_LocaleData.fromJson(Map<String, dynamic> json) =>
      _$$_LocaleDataFromJson(json);

  @override
  final String name;

  @override
  String toString() {
    return 'LocaleData(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LocaleData &&
            const DeepCollectionEquality().equals(other.name, name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(name));

  @JsonKey(ignore: true)
  @override
  _$$_LocaleDataCopyWith<_$_LocaleData> get copyWith =>
      __$$_LocaleDataCopyWithImpl<_$_LocaleData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LocaleDataToJson(this);
  }
}

abstract class _LocaleData implements LocaleData {
  factory _LocaleData({required final String name}) = _$_LocaleData;

  factory _LocaleData.fromJson(Map<String, dynamic> json) =
      _$_LocaleData.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_LocaleDataCopyWith<_$_LocaleData> get copyWith =>
      throw _privateConstructorUsedError;
}
