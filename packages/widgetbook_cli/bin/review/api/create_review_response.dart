import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/review.dart';

part 'create_review_response.freezed.dart';
part 'create_review_response.g.dart';

@freezed
class CreateReviewResponse with _$CreateReviewResponse {
  factory CreateReviewResponse({
    required Review review,
  }) = _CreateReviewResponse;

  factory CreateReviewResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateReviewResponseFromJson(json);
}
