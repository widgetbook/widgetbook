import 'package:freezed_annotation/freezed_annotation.dart';

part 'created_review.freezed.dart';
part 'created_review.g.dart';

@freezed
class CreatedReview with _$CreatedReview {
  factory CreatedReview({
    required String id,
  }) = _CreatedReview;

  factory CreatedReview.fromJson(Map<String, dynamic> json) =>
      _$CreatedReviewFromJson(json);
}
