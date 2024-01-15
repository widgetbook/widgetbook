class BuildDraftResponse {
  const BuildDraftResponse({
    required this.buildId,
    required this.storageUrl,
  });

  final String buildId;
  final String storageUrl;

  // ignore: sort_constructors_first
  factory BuildDraftResponse.fromJson(Map<String, dynamic> json) {
    return BuildDraftResponse(
      buildId: json['buildId'] as String,
      storageUrl: json['storageUrl'] as String,
    );
  }
}
