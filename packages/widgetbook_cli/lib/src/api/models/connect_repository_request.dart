class ConnectRepositoryRequest {
  const ConnectRepositoryRequest({
    required this.provider,
    required this.repository,
  });

  final String provider;
  final String repository;

  Map<String, dynamic> toJson() {
    return {
      'provider': provider,
      'repository': repository,
    };
  }
}
