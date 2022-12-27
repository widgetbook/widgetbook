// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'create_review_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CreateReviewResponse _$CreateReviewResponseFromJson(Map<String, dynamic> json) {
  return _CreateReviewResponse.fromJson(json);
}

/// @nodoc
mixin _$CreateReviewResponse {
  CreatedReview get review => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreateReviewResponseCopyWith<CreateReviewResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateReviewResponseCopyWith<$Res> {
  factory $CreateReviewResponseCopyWith(CreateReviewResponse value,
          $Res Function(CreateReviewResponse) then) =
      _$CreateReviewResponseCopyWithImpl<$Res>;
  $Res call({CreatedReview review});

  $CreatedReviewCopyWith<$Res> get review;
}

/// @nodoc
class _$CreateReviewResponseCopyWithImpl<$Res>
    implements $CreateReviewResponseCopyWith<$Res> {
  _$CreateReviewResponseCopyWithImpl(this._value, this._then);

  final CreateReviewResponse _value;
  // ignore: unused_field
  final $Res Function(CreateReviewResponse) _then;

  @override
  $Res call({
    Object? review = freezed,
  }) {
    return _then(_value.copyWith(
      review: review == freezed
          ? _value.review
          : review // ignore: cast_nullable_to_non_nullable
              as CreatedReview,
    ));
  }

  @override
  $CreatedReviewCopyWith<$Res> get review {
    return $CreatedReviewCopyWith<$Res>(_value.review, (value) {
      return _then(_value.copyWith(review: value));
    });
  }
}

/// @nodoc
abstract class _$$_CreateReviewResponseCopyWith<$Res>
    implements $CreateReviewResponseCopyWith<$Res> {
  factory _$$_CreateReviewResponseCopyWith(_$_CreateReviewResponse value,
          $Res Function(_$_CreateReviewResponse) then) =
      __$$_CreateReviewResponseCopyWithImpl<$Res>;
  @override
  $Res call({CreatedReview review});

  @override
  $CreatedReviewCopyWith<$Res> get review;
}

/// @nodoc
class __$$_CreateReviewResponseCopyWithImpl<$Res>
    extends _$CreateReviewResponseCopyWithImpl<$Res>
    implements _$$_CreateReviewResponseCopyWith<$Res> {
  __$$_CreateReviewResponseCopyWithImpl(_$_CreateReviewResponse _value,
      $Res Function(_$_CreateReviewResponse) _then)
      : super(_value, (v) => _then(v as _$_CreateReviewResponse));

  @override
  _$_CreateReviewResponse get _value => super._value as _$_CreateReviewResponse;

  @override
  $Res call({
    Object? review = freezed,
  }) {
    return _then(_$_CreateReviewResponse(
      review: review == freezed
          ? _value.review
          : review // ignore: cast_nullable_to_non_nullable
              as CreatedReview,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CreateReviewResponse implements _CreateReviewResponse {
  _$_CreateReviewResponse({required this.review});

  factory _$_CreateReviewResponse.fromJson(Map<String, dynamic> json) =>
      _$$_CreateReviewResponseFromJson(json);

  @override
  final CreatedReview review;

  @override
  String toString() {
    return 'CreateReviewResponse(review: $review)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CreateReviewResponse &&
            const DeepCollectionEquality().equals(other.review, review));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(review));

  @JsonKey(ignore: true)
  @override
  _$$_CreateReviewResponseCopyWith<_$_CreateReviewResponse> get copyWith =>
      __$$_CreateReviewResponseCopyWithImpl<_$_CreateReviewResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CreateReviewResponseToJson(this);
  }
}

abstract class _CreateReviewResponse implements CreateReviewResponse {
  factory _CreateReviewResponse({required final CreatedReview review}) =
      _$_CreateReviewResponse;

  factory _CreateReviewResponse.fromJson(Map<String, dynamic> json) =
      _$_CreateReviewResponse.fromJson;

  @override
  CreatedReview get review => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_CreateReviewResponseCopyWith<_$_CreateReviewResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
