import 'package:freezed_annotation/freezed_annotation.dart';

import 'created_review.dart';
import 'upload_task.dart';

part 'review_upload_response.freezed.dart';
part 'review_upload_response.g.dart';

@freezed
class ReviewUploadResponse with _$ReviewUploadResponse {
  factory ReviewUploadResponse({
    required CreatedReview review,
    required List<UploadTask> tasks,
  }) = _ReviewUploadResponse;

  factory ReviewUploadResponse.fromJson(Map<String, dynamic> json) =>
      _$ReviewUploadResponseFromJson(json);
}
