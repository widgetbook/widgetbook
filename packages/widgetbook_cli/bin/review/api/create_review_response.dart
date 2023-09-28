import '../models/review.dart';

class CreateReviewResponse {
  const CreateReviewResponse({
    required this.review,
  });

  final Review review;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'review': review.toJson(),
    };
  }

  // ignore: sort_constructors_first
  factory CreateReviewResponse.fromJson(Map<String, dynamic> map) {
    return CreateReviewResponse(
      review: Review.fromJson(map['review'] as Map<String, dynamic>),
    );
  }
}
