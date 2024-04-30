import '../../models/models.dart';

class BuildDraftRequest {
  const BuildDraftRequest({
    required this.apiKey,
    required this.versionControlProvider,
    required this.repository,
    required this.actor,
    required this.branch,
    required this.sha,
    required this.useCases,
    required this.size,
  });

  final String apiKey;
  final String versionControlProvider;
  final String repository;
  final String actor;
  final String branch;
  final String sha;
  final List<UseCaseMetadata> useCases;

  // Build file size in bytes
  final int size;

  Map<String, dynamic> toJson() {
    return {
      'apiKey': apiKey,
      'versionControlProvider': versionControlProvider,
      'repository': repository,
      'actor': actor,
      'branch': branch,
      'sha': sha,
      'useCases': useCases.map((x) => x.toJson()).toList(),
      'size': size,
    };
  }
}
