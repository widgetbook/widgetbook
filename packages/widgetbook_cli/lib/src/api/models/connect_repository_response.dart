class ConnectRepositoryResponse {
  const ConnectRepositoryResponse({
    required this.provider,
    required this.repository,
    required this.projectName,
  });

  final String provider;
  final String repository;
  final String projectName;

  // ignore: sort_constructors_first
  factory ConnectRepositoryResponse.fromJson(Map<String, dynamic> json) {
    final project = json['project'] as Map<String, dynamic>;

    return ConnectRepositoryResponse(
      provider: json['provider'] as String,
      repository: json['repository'] as String,
      projectName: project['name'] as String,
    );
  }
}
