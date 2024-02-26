import 'upload_task.dart';

class Review {
  const Review({
    required this.id,
    required this.projectId,
  });

  final String id;
  final String projectId;

  // ignore: sort_constructors_first
  factory Review.fromJson(Map<String, dynamic> map) {
    return Review(
      id: map['id'] as String,
      projectId: map['projectId'] as String,
    );
  }
}

class ReviewResponse {
  const ReviewResponse({
    required this.review,
    required this.tasks,
  });

  final Review review;
  final List<UploadTask> tasks;

  // ignore: sort_constructors_first
  factory ReviewResponse.fromJson(Map<String, dynamic> map) {
    return ReviewResponse(
      review: Review.fromJson(map['review'] as Map<String, dynamic>),
      tasks: List<UploadTask>.from(
        (map['tasks'] as List<dynamic>).map<UploadTask>(
          (x) => UploadTask.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}

class ReviewSyncResponse {
  const ReviewSyncResponse({
    required this.reviewId,
  });

  final String reviewId;

  // ignore: sort_constructors_first
  factory ReviewSyncResponse.fromJson(Map<String, dynamic> map) {
    return ReviewSyncResponse(
      reviewId: map['reviewId'] as String,
    );
  }
}
