class CreateBuildRequest {
  const CreateBuildRequest({
    required this.apiKey,
    required this.branchName,
    required this.repositoryName,
    required this.commitSha,
    required this.actor,
    required this.provider,
  });

  final String apiKey;
  final String branchName;
  final String repositoryName;
  final String commitSha;
  final String actor;
  final String provider;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'apiKey': apiKey,
      'branchName': branchName,
      'repositoryName': repositoryName,
      'commitSha': commitSha,
      'actor': actor,
      'provider': provider,
    };
  }

  // ignore: sort_constructors_first
  factory CreateBuildRequest.fromJson(Map<String, dynamic> map) {
    return CreateBuildRequest(
      apiKey: map['apiKey'] as String,
      branchName: map['branchName'] as String,
      repositoryName: map['repositoryName'] as String,
      commitSha: map['commitSha'] as String,
      actor: map['actor'] as String,
      provider: map['provider'] as String,
    );
  }
}
