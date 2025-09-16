class SubmitBuildResponse {
  const SubmitBuildResponse({
    required this.buildId,
    required this.buildUrl,
  });

  final String buildId;
  final String buildUrl;

  // ignore: sort_constructors_first
  factory SubmitBuildResponse.fromJson(Map<String, dynamic> json) {
    return SubmitBuildResponse(
      buildId: json['buildId'] as String,
      buildUrl: json['buildUrl'] as String,
    );
  }
}
