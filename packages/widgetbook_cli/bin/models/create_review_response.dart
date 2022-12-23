import 'package:freezed_annotation/freezed_annotation.dart';

import 'created_review.dart';

part 'create_review_response.freezed.dart';
part 'create_review_response.g.dart';

@freezed
class CreateReviewResponse with _$CreateReviewResponse {
  factory CreateReviewResponse({
    required CreatedReview review,
  }) = _CreateReviewResponse;

  factory CreateReviewResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateReviewResponseFromJson(json);
}
