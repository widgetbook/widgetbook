class BuildDraftResponse {
  const BuildDraftResponse({
    required this.buildId,
    required this.baseHref,
    required this.urls,
  });

  final String buildId;
  final String baseHref;
  final Map<String, String> urls;

  // ignore: sort_constructors_first
  factory BuildDraftResponse.fromJson(Map<String, dynamic> json) {
    return BuildDraftResponse(
      buildId: json['buildId'] as String,
      baseHref: json['baseHref'] as String,
      urls: Map<String, String>.from(json['urls'] as Map),
    );
  }
}
