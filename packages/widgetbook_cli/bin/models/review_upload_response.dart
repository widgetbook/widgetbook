import 'created_review.dart';
import 'upload_task.dart';

class ReviewUploadResponse {
  const ReviewUploadResponse({
    required this.review,
    required this.tasks,
  });

  final CreatedReview review;
  final List<UploadTask> tasks;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'review': review.toJson(),
      'tasks': tasks.map((x) => x.toJson()).toList(),
    };
  }

  // ignore: sort_constructors_first
  factory ReviewUploadResponse.fromJson(Map<String, dynamic> map) {
    return ReviewUploadResponse(
      review: CreatedReview.fromJson(map['review'] as Map<String, dynamic>),
      tasks: List<UploadTask>.from(
        (map['tasks'] as List<dynamic>).map<UploadTask>(
          (x) => UploadTask.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
