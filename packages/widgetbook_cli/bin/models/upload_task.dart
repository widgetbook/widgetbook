import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload_task.freezed.dart';
part 'upload_task.g.dart';

enum UploadTaskStatus {
  success,
  failure,
  warning,
}

@freezed
class UploadTask with _$UploadTask {
  factory UploadTask({
    required UploadTaskStatus status,
    required String message,
  }) = _UploadTask;

  factory UploadTask.fromJson(Map<String, dynamic> json) =>
      _$UploadTaskFromJson(json);
}
