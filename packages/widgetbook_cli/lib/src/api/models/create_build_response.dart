/// A build draft response can either be one of two types:
/// 1. [CreateTurboBuildResponse] for turbo builds.
/// 2. [CreateDraftBuildResponse] for draft builds.
abstract class CreateBuildResponse {
  const CreateBuildResponse({required this.buildId});

  final String buildId;

  // ignore: sort_constructors_first
  factory CreateBuildResponse.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    if (type == 'turbo') {
      return CreateTurboBuildResponse.fromJson(json);
    } else if (type == 'draft') {
      return CreateDraftBuildResponse.fromJson(json);
    } else {
      throw ArgumentError('Unknown build draft response: $json');
    }
  }

  bool get isTurbo => this is CreateTurboBuildResponse;
  bool get isDraft => this is CreateDraftBuildResponse;

  CreateTurboBuildResponse get asTurbo {
    if (isTurbo) return this as CreateTurboBuildResponse;
    throw StateError('BuildDraftResponse is not a Turbo response');
  }

  CreateDraftBuildResponse get asDraft {
    if (isDraft) return this as CreateDraftBuildResponse;
    throw StateError('BuildDraftResponse is not an Upload response');
  }
}

class CreateTurboBuildResponse extends CreateBuildResponse {
  const CreateTurboBuildResponse({
    required super.buildId,
    required this.buildUrl,
  });

  final String buildUrl;

  // ignore: sort_constructors_first
  factory CreateTurboBuildResponse.fromJson(Map<String, dynamic> json) {
    return CreateTurboBuildResponse(
      buildId: json['buildId'] as String,
      buildUrl: json['buildUrl'] as String,
    );
  }
}

class CreateDraftBuildResponse extends CreateBuildResponse {
  const CreateDraftBuildResponse({
    required super.buildId,
    required this.baseHref,
    required this.storage,
  });

  final String baseHref;
  final StorageInfo storage;

  // ignore: sort_constructors_first
  factory CreateDraftBuildResponse.fromJson(Map<String, dynamic> json) {
    return CreateDraftBuildResponse(
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
