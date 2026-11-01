/// Typed representation of the arguments passed to the project disconnect
/// command.
class ProjectDisconnectArgs {
  const ProjectDisconnectArgs({
    required this.apiKey,
    required this.project,
  });

  final String apiKey;

  /// Name of the Widgetbook Cloud project, or `null` to use the only project
  /// the [apiKey] reaches.
  final String? project;
}
