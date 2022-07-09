// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'theme_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ThemeData _$ThemeDataFromJson(Map<String, dynamic> json) {
  return _ThemeData.fromJson(json);
}

/// @nodoc
mixin _$ThemeData {
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ThemeDataCopyWith<ThemeData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThemeDataCopyWith<$Res> {
  factory $ThemeDataCopyWith(ThemeData value, $Res Function(ThemeData) then) =
      _$ThemeDataCopyWithImpl<$Res>;
  $Res call({String name});
}

/// @nodoc
class _$ThemeDataCopyWithImpl<$Res> implements $ThemeDataCopyWith<$Res> {
  _$ThemeDataCopyWithImpl(this._value, this._then);

  final ThemeData _value;
  // ignore: unused_field
  final $Res Function(ThemeData) _then;

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
abstract class _$$_ThemeDataCopyWith<$Res> implements $ThemeDataCopyWith<$Res> {
  factory _$$_ThemeDataCopyWith(
          _$_ThemeData value, $Res Function(_$_ThemeData) then) =
      __$$_ThemeDataCopyWithImpl<$Res>;
  @override
  $Res call({String name});
}

/// @nodoc
class __$$_ThemeDataCopyWithImpl<$Res> extends _$ThemeDataCopyWithImpl<$Res>
    implements _$$_ThemeDataCopyWith<$Res> {
  __$$_ThemeDataCopyWithImpl(
      _$_ThemeData _value, $Res Function(_$_ThemeData) _then)
      : super(_value, (v) => _then(v as _$_ThemeData));

  @override
  _$_ThemeData get _value => super._value as _$_ThemeData;

  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_$_ThemeData(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ThemeData implements _ThemeData {
  _$_ThemeData({required this.name});

  factory _$_ThemeData.fromJson(Map<String, dynamic> json) =>
      _$$_ThemeDataFromJson(json);

  @override
  final String name;

  @override
  String toString() {
    return 'ThemeData(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ThemeData &&
            const DeepCollectionEquality().equals(other.name, name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(name));

  @JsonKey(ignore: true)
  @override
  _$$_ThemeDataCopyWith<_$_ThemeData> get copyWith =>
      __$$_ThemeDataCopyWithImpl<_$_ThemeData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ThemeDataToJson(this);
  }
}

abstract class _ThemeData implements ThemeData {
  factory _ThemeData({required final String name}) = _$_ThemeData;

  factory _ThemeData.fromJson(Map<String, dynamic> json) =
      _$_ThemeData.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ThemeDataCopyWith<_$_ThemeData> get copyWith =>
      throw _privateConstructorUsedError;
}
