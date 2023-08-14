import 'package:freezed_annotation/freezed_annotation.dart';

import 'upload_task.dart';

part 'build_upload_response.freezed.dart';
part 'build_upload_response.g.dart';

enum BuildUploadStatus {
  duplicate,
  success,
  failure,
}

@freezed
class BuildUploadResponse with _$BuildUploadResponse {
  factory BuildUploadResponse({
    required String project,
    required String build,
    required BuildUploadStatus status,
    required List<UploadTask> tasks,
  }) = _BuildUploadResponse;

  factory BuildUploadResponse.fromJson(Map<String, dynamic> json) =>
      _$BuildUploadResponseFromJson(json);
}
