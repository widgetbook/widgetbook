import 'project_response.dart';

class ListProjectsResponse {
  const ListProjectsResponse({
    required this.projects,
  });

  final List<ProjectResponse> projects;

  // ignore: sort_constructors_first
  factory ListProjectsResponse.fromJson(Map<String, dynamic> json) {
    return ListProjectsResponse(
      projects: (json['projects'] as List<dynamic>)
          .map(
            (project) =>
                ProjectResponse.fromJson(project as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}
