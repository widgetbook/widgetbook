class CliArgs {
  const CliArgs({
    required this.apiKey,
    required this.branch,
    required this.commit,
    required this.gitProvider,
    required this.path,
    this.gitHubToken,
    this.prNumber,
    this.baseBranch,
  });

  final String apiKey;
  final String branch;
  final String commit;
  final String gitProvider;
  final String path;
  final String? gitHubToken;
  final String? prNumber;
  final String? baseBranch;
}
