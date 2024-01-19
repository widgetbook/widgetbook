import '../git/git.dart';

/// Typed representation of the arguments passed to the push command.
class BuildPushArgs {
  const BuildPushArgs({
    required this.apiKey,
    required this.branch,
    required this.commit,
    required this.path,
    required this.vendor,
    required this.actor,
    required this.repository,
    this.baseBranch,
  });

  final String apiKey;
  final String branch;
  final String commit;
  final String path;
  final String vendor;
  final String actor;
  final String repository;

  // TODO: remove when API endpoint no longer needs this
  final Reference? baseBranch;
}
