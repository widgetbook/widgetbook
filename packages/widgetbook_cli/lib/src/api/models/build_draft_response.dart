/// A build draft response can either be a  or an Upload response.
/// 1. [TurboBuildResponse] for turbo builds when `turbo` key exists.
/// 2. [DraftBuildResponse] for normal builds drafts.
abstract class BuildDraftResponse {
  const BuildDraftResponse({required this.buildId});

  final String buildId;

  // ignore: sort_constructors_first
  factory BuildDraftResponse.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    if (type == 'turbo') {
      return TurboBuildResponse.fromJson(json);
    } else if (type == 'draft') {
      return DraftBuildResponse.fromJson(json);
    } else {
      throw ArgumentError('Unknown build draft response: $json');
    }
  }

  bool get isTurbo => this is TurboBuildResponse;
  bool get isDraft => this is DraftBuildResponse;

  TurboBuildResponse get asTurbo {
    if (isTurbo) return this as TurboBuildResponse;
    throw StateError('BuildDraftResponse is not a Turbo response');
  }

  DraftBuildResponse get asDraft {
    if (isDraft) return this as DraftBuildResponse;
    throw StateError('BuildDraftResponse is not an Upload response');
  }
}

class TurboBuildResponse extends BuildDraftResponse {
  const TurboBuildResponse({
    required super.buildId,
    required this.buildUrl,
  });

  final String buildUrl;

  // ignore: sort_constructors_first
  factory TurboBuildResponse.fromJson(Map<String, dynamic> json) {
    return TurboBuildResponse(
      buildId: json['buildId'] as String,
      buildUrl: json['buildUrl'] as String,
    );
  }
}

class DraftBuildResponse extends BuildDraftResponse {
  const DraftBuildResponse({
    required super.buildId,
    required this.baseHref,
    required this.storage,
  });

  final String baseHref;
  final StorageInfo storage;

  // ignore: sort_constructors_first
  factory DraftBuildResponse.fromJson(Map<String, dynamic> json) {
    return DraftBuildResponse(
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
