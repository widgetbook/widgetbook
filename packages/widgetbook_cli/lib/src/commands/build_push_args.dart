import '../api/api.dart';

/// Typed representation of the arguments passed to the push command.
class BuildPushArgs {
  const BuildPushArgs({
    required this.apiKey,
    required this.project,
    required this.path,
    required this.branch,
    required this.commit,
    required this.mergedResultCommit,
    required this.vendor,
    required this.actor,
    required this.repository,
    required this.noTurbo,
    required this.allowExisting,
  });

  final ApiKey apiKey;

  /// Name of the Widgetbook Cloud project, required with a [WorkspaceApiKey].
  final String? project;

  final String path;
  final String branch;
  final String commit;
  final String? mergedResultCommit;
  final String vendor;
  final String actor;
  final String repository;
  final bool noTurbo;

  /// Whether to exit successfully instead of failing when a build for this
  /// commit already exists on Widgetbook Cloud.
  final bool allowExisting;
}
