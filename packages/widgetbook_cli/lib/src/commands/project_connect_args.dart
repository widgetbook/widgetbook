/// Typed representation of the arguments passed to the project connect
/// command.
class ProjectConnectArgs {
  const ProjectConnectArgs({
    required this.apiKey,
    required this.project,
    required this.provider,
    required this.repository,
  });

  final String apiKey;

  /// Name of the Widgetbook Cloud project, or `null` to use the only project
  /// the [apiKey] reaches.
  final String? project;

  final String provider;

  /// The repository to connect, as `owner/name`.
  final String repository;
}
