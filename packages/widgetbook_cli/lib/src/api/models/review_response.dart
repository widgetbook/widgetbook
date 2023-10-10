import 'upload_task.dart';

class Review {
  const Review({
    required this.id,
  });

  final String id;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
    };
  }

  // ignore: sort_constructors_first
  factory Review.fromJson(Map<String, dynamic> map) {
    return Review(
      id: map['id'] as String,
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
