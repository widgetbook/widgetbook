class PublishArgs {
  const PublishArgs({
    required this.apiKey,
    required this.branch,
    required this.commit,
    required this.path,
    required this.vendor,
    required this.actor,
    required this.repository,
    this.gitHubToken,
    this.prNumber,
    this.baseBranch,
    this.baseSha,
  });

  final String apiKey;
  final String branch;
  final String commit;
  final String path;
  final String vendor;
  final String actor;
  final String repository;
  final String? gitHubToken;
  final String? prNumber;

  // TODO instead of having this as two separate values we should use
  // BranchReference instead. However; this is currently not well implemented
  final String? baseBranch;
  final String? baseSha;

  @override
  bool operator ==(covariant PublishArgs other) {
    if (identical(this, other)) return true;

    return other.apiKey == apiKey &&
        other.branch == branch &&
        other.commit == commit &&
        other.path == path &&
        other.vendor == vendor &&
        other.actor == actor &&
        other.repository == repository &&
        other.gitHubToken == gitHubToken &&
        other.prNumber == prNumber &&
        other.baseBranch == baseBranch &&
        other.baseSha == baseSha;
  }

  @override
  int get hashCode {
    return apiKey.hashCode ^
        branch.hashCode ^
        commit.hashCode ^
        path.hashCode ^
        vendor.hashCode ^
        actor.hashCode ^
        repository.hashCode ^
        gitHubToken.hashCode ^
        prNumber.hashCode ^
        baseBranch.hashCode ^
        baseSha.hashCode;
  }
}
