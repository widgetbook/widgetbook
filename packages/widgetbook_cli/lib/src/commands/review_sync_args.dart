class ReviewSyncArgs {
  ReviewSyncArgs({
    required this.apiKey,
    required this.path,
    required this.baseBranch,
    required this.headBranch,
    required this.baseSha,
    required this.headSha,
  });

  final String apiKey;
  final String path;
  final String baseBranch;
  final String headBranch;
  final String baseSha;
  final String headSha;
}
