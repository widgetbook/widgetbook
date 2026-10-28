/// Typed representation of the arguments passed to the push command.
class BuildPushArgs {
  const BuildPushArgs({
    required this.apiKey,
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

  final String apiKey;
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
