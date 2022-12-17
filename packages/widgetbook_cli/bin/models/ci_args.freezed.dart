// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'ci_args.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CiArgs {
  String? get actor => throw _privateConstructorUsedError;
  String? get repository => throw _privateConstructorUsedError;
  String get vendor => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CiArgsCopyWith<CiArgs> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CiArgsCopyWith<$Res> {
  factory $CiArgsCopyWith(CiArgs value, $Res Function(CiArgs) then) =
      _$CiArgsCopyWithImpl<$Res>;
  $Res call({String? actor, String? repository, String vendor});
}

/// @nodoc
class _$CiArgsCopyWithImpl<$Res> implements $CiArgsCopyWith<$Res> {
  _$CiArgsCopyWithImpl(this._value, this._then);

  final CiArgs _value;
  // ignore: unused_field
  final $Res Function(CiArgs) _then;

  @override
  $Res call({
    Object? actor = freezed,
    Object? repository = freezed,
    Object? vendor = freezed,
  }) {
    return _then(_value.copyWith(
      actor: actor == freezed
          ? _value.actor
          : actor // ignore: cast_nullable_to_non_nullable
              as String?,
      repository: repository == freezed
          ? _value.repository
          : repository // ignore: cast_nullable_to_non_nullable
              as String?,
      vendor: vendor == freezed
          ? _value.vendor
          : vendor // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_CiArgsCopyWith<$Res> implements $CiArgsCopyWith<$Res> {
  factory _$$_CiArgsCopyWith(_$_CiArgs value, $Res Function(_$_CiArgs) then) =
      __$$_CiArgsCopyWithImpl<$Res>;
  @override
  $Res call({String? actor, String? repository, String vendor});
}

/// @nodoc
class __$$_CiArgsCopyWithImpl<$Res> extends _$CiArgsCopyWithImpl<$Res>
    implements _$$_CiArgsCopyWith<$Res> {
  __$$_CiArgsCopyWithImpl(_$_CiArgs _value, $Res Function(_$_CiArgs) _then)
      : super(_value, (v) => _then(v as _$_CiArgs));

  @override
  _$_CiArgs get _value => super._value as _$_CiArgs;

  @override
  $Res call({
    Object? actor = freezed,
    Object? repository = freezed,
    Object? vendor = freezed,
  }) {
    return _then(_$_CiArgs(
      actor: actor == freezed
          ? _value.actor
          : actor // ignore: cast_nullable_to_non_nullable
              as String?,
      repository: repository == freezed
          ? _value.repository
          : repository // ignore: cast_nullable_to_non_nullable
              as String?,
      vendor: vendor == freezed
          ? _value.vendor
          : vendor // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_CiArgs implements _CiArgs {
  const _$_CiArgs({this.actor, this.repository, required this.vendor});

  @override
  final String? actor;
  @override
  final String? repository;
  @override
  final String vendor;

  @override
  String toString() {
    return 'CiArgs(actor: $actor, repository: $repository, vendor: $vendor)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CiArgs &&
            const DeepCollectionEquality().equals(other.actor, actor) &&
            const DeepCollectionEquality()
                .equals(other.repository, repository) &&
            const DeepCollectionEquality().equals(other.vendor, vendor));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(actor),
      const DeepCollectionEquality().hash(repository),
      const DeepCollectionEquality().hash(vendor));

  @JsonKey(ignore: true)
  @override
  _$$_CiArgsCopyWith<_$_CiArgs> get copyWith =>
      __$$_CiArgsCopyWithImpl<_$_CiArgs>(this, _$identity);
}

abstract class _CiArgs implements CiArgs {
  const factory _CiArgs(
      {final String? actor,
      final String? repository,
      required final String vendor}) = _$_CiArgs;

  @override
  String? get actor => throw _privateConstructorUsedError;
  @override
  String? get repository => throw _privateConstructorUsedError;
  @override
  String get vendor => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_CiArgsCopyWith<_$_CiArgs> get copyWith =>
      throw _privateConstructorUsedError;
}
