enum UploadTaskStatus {
  success,
  failure,
  warning,
}

class UploadTask {
  const UploadTask({
    required this.status,
    required this.message,
  });

  final UploadTaskStatus status;
  final String message;

  // ignore: sort_constructors_first
  factory UploadTask.fromJson(Map<String, dynamic> map) {
    return UploadTask(
      status: UploadTaskStatus.values.byName(map['status'] as String),
      message: map['message'] as String,
    );
  }
}
