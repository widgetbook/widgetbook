class ConnectRepositoryResponse {
  const ConnectRepositoryResponse({
    required this.provider,
    required this.repository,
  });

  final String provider;
  final String repository;

  // ignore: sort_constructors_first
  factory ConnectRepositoryResponse.fromJson(Map<String, dynamic> json) {
    return ConnectRepositoryResponse(
      provider: json['provider'] as String,
      repository: json['repository'] as String,
    );
  }
}
