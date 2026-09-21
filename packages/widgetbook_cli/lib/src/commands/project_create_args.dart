import '../api/api.dart';

/// Typed representation of the arguments passed to the project create command.
class ProjectCreateArgs {
  const ProjectCreateArgs({
    required this.apiKey,
    required this.project,
    required this.allowExisting,
  });

  final WorkspaceApiKey apiKey;
  final String project;

  /// Whether to exit successfully instead of failing when a project with this
  /// name already exists in the workspace.
  final bool allowExisting;
}
