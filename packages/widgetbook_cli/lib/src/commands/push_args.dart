/// Typed representation of the arguments passed to the push command.
class PushArgs {
  const PushArgs({
    required this.apiKey,
    required this.versionControlProvider,
    required this.repository,
    required this.actor,
    required this.branch,
    required this.headSha,
    this.baseSha,
  });

  final String apiKey;
  final String versionControlProvider;
  final String repository;
  final String actor;
  final String branch;
  final String headSha;
  final String? baseSha;
}
