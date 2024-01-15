class BuildReadyResponse {
  const BuildReadyResponse({
    required this.buildId,
    required this.buildUrl,
  });

  final String buildId;
  final String buildUrl;

  // ignore: sort_constructors_first
  factory BuildReadyResponse.fromJson(Map<String, dynamic> json) {
    return BuildReadyResponse(
      buildId: json['buildId'] as String,
      buildUrl: json['buildUrl'] as String,
    );
  }
}
