/// A Widgetbook Cloud project, addressed by the ids of its workspace and
/// itself.
class CloudProject {
  const CloudProject({
    required this.workspaceId,
    required this.projectId,
    required this.name,
  });

  final String workspaceId;
  final String projectId;
  final String name;

  /// The API path that the routes acting on this project are nested under.
  String get path => 'v4/workspaces/$workspaceId/projects/$projectId';
}
