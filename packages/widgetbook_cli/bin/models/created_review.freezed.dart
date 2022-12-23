// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'created_review.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CreatedReview _$CreatedReviewFromJson(Map<String, dynamic> json) {
  return _CreatedReview.fromJson(json);
}

/// @nodoc
mixin _$CreatedReview {
  String get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreatedReviewCopyWith<CreatedReview> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatedReviewCopyWith<$Res> {
  factory $CreatedReviewCopyWith(
          CreatedReview value, $Res Function(CreatedReview) then) =
      _$CreatedReviewCopyWithImpl<$Res>;
  $Res call({String id});
}

/// @nodoc
class _$CreatedReviewCopyWithImpl<$Res>
    implements $CreatedReviewCopyWith<$Res> {
  _$CreatedReviewCopyWithImpl(this._value, this._then);

  final CreatedReview _value;
  // ignore: unused_field
  final $Res Function(CreatedReview) _then;

  @override
  $Res call({
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_CreatedReviewCopyWith<$Res>
    implements $CreatedReviewCopyWith<$Res> {
  factory _$$_CreatedReviewCopyWith(
          _$_CreatedReview value, $Res Function(_$_CreatedReview) then) =
      __$$_CreatedReviewCopyWithImpl<$Res>;
  @override
  $Res call({String id});
}

/// @nodoc
class __$$_CreatedReviewCopyWithImpl<$Res>
    extends _$CreatedReviewCopyWithImpl<$Res>
    implements _$$_CreatedReviewCopyWith<$Res> {
  __$$_CreatedReviewCopyWithImpl(
      _$_CreatedReview _value, $Res Function(_$_CreatedReview) _then)
      : super(_value, (v) => _then(v as _$_CreatedReview));

  @override
  _$_CreatedReview get _value => super._value as _$_CreatedReview;

  @override
  $Res call({
    Object? id = freezed,
  }) {
    return _then(_$_CreatedReview(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CreatedReview implements _CreatedReview {
  _$_CreatedReview({required this.id});

  factory _$_CreatedReview.fromJson(Map<String, dynamic> json) =>
      _$$_CreatedReviewFromJson(json);

  @override
  final String id;

  @override
  String toString() {
    return 'CreatedReview(id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CreatedReview &&
            const DeepCollectionEquality().equals(other.id, id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(id));

  @JsonKey(ignore: true)
  @override
  _$$_CreatedReviewCopyWith<_$_CreatedReview> get copyWith =>
      __$$_CreatedReviewCopyWithImpl<_$_CreatedReview>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CreatedReviewToJson(this);
  }
}

abstract class _CreatedReview implements CreatedReview {
  factory _CreatedReview({required final String id}) = _$_CreatedReview;

  factory _CreatedReview.fromJson(Map<String, dynamic> json) =
      _$_CreatedReview.fromJson;

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_CreatedReviewCopyWith<_$_CreatedReview> get copyWith =>
      throw _privateConstructorUsedError;
}
