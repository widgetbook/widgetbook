import '../../models/models.dart';

class BuildDraftRequest {
  const BuildDraftRequest({
    required this.apiKey,
    required this.versionControlProvider,
    required this.repository,
    required this.actor,
    required this.branch,
    required this.headSha,
    this.baseSha,
    required this.useCases,
  });

  final String apiKey;
  final String versionControlProvider;
  final String repository;
  final String actor;
  final String branch;
  final String headSha;
  final String? baseSha;
  final List<UseCaseMetadata> useCases;

  Map<String, dynamic> toJson() {
    return {
      'apiKey': apiKey,
      'versionControlProvider': versionControlProvider,
      'repository': repository,
      'actor': actor,
      'branch': branch,
      'headSha': headSha,
      'baseSha': baseSha,
      'useCases': useCases.map((x) => x.toJson()).toList(),
    };
  }
}
