/// Data required for a deployment
class DeploymentData {
  /// Creates a new instance of [DeploymentData].
  DeploymentData({
    required this.branchName,
    required this.repositoryName,
    required this.commitSha,
    required this.actor,
    required this.provider,
    required this.apiKey,
  });

  /// The API key of a project
  final String apiKey;

  /// Name of the branch
  final String branchName;

  /// Name of the repository
  final String repositoryName;

  /// The sha of the commit
  final String commitSha;

  /// Name of the username at the [provider].
  final String actor;

  /// Git cloud provider e.g. GitHub, GitLab, etc
  final String provider;

  /// Copies the data with the provided fields
  DeploymentData copyWith({
    String? apiKey,
    String? branchName,
    String? repositoryName,
    String? commitSha,
    String? actor,
    String? provider,
  }) {
    return DeploymentData(
      apiKey: apiKey ?? this.apiKey,
      branchName: branchName ?? this.branchName,
      repositoryName: repositoryName ?? this.repositoryName,
      commitSha: commitSha ?? this.commitSha,
      actor: actor ?? this.actor,
      provider: provider ?? this.provider,
    );
  }
}
