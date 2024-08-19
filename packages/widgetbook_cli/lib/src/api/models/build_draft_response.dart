class BuildDraftResponse {
  const BuildDraftResponse({
    required this.buildId,
    required this.baseHref,
    required this.storage,
  });

  final String buildId;
  final String baseHref;
  final StorageInfo storage;

  // ignore: sort_constructors_first
  factory BuildDraftResponse.fromJson(Map<String, dynamic> json) {
    return BuildDraftResponse(
      buildId: json['buildId'] as String,
      baseHref: json['baseHref'] as String,
      storage: StorageInfo.fromJson(json['storage'] as Map<String, dynamic>),
    );
  }
}

class StorageInfo {
  const StorageInfo({
    required this.url,
    required this.fields,
  });

  final String url;
  final Map<String, String> fields;

  // ignore: sort_constructors_first
  factory StorageInfo.fromJson(Map<String, dynamic> json) {
    return StorageInfo(
      url: json['url'] as String,
      fields: Map<String, String>.from(json['fields'] as Map),
    );
  }
}
