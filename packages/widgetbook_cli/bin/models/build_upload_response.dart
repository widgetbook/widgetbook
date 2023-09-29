import 'upload_task.dart';

enum BuildUploadStatus {
  duplicate,
  success,
  failure,
}

class BuildUploadResponse {
  const BuildUploadResponse({
    required this.project,
    required this.build,
    required this.status,
    required this.tasks,
  });

  final String project;
  final String build;
  final BuildUploadStatus status;
  final List<UploadTask> tasks;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'project': project,
      'build': build,
      'status': status.name,
      'tasks': tasks.map((x) => x.toJson()).toList(),
    };
  }

  // ignore: sort_constructors_first
  factory BuildUploadResponse.fromJson(Map<String, dynamic> map) {
    return BuildUploadResponse(
      project: map['project'] as String,
      build: map['build'] as String,
      status: BuildUploadStatus.values.byName(map['status'] as String),
      tasks: List<UploadTask>.from(
        (map['tasks'] as List<dynamic>).map<UploadTask>(
          (x) => UploadTask.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
