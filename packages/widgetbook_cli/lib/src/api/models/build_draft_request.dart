import '../../cache/cache.dart';

class BuildDraftRequest {
  const BuildDraftRequest({
    required this.apiKey,
    required this.versionControlProvider,
    required this.repository,
    required this.actor,
    required this.branch,
    required this.sha,
    required this.mergedResultSha,
    required this.useCases,
    required this.addonsConfigs,
    required this.size,
  });

  final String apiKey;
  final String versionControlProvider;
  final String repository;
  final String actor;
  final String branch;
  final String sha;
  final String? mergedResultSha;
  final List<UseCaseMetadata> useCases;
  final AddonsConfigs? addonsConfigs;
  final int size;

  Map<String, dynamic> toJson() {
    return {
      'apiKey': apiKey,
      'versionControlProvider': versionControlProvider,
      'repository': repository,
      'actor': actor,
      'branch': branch,
      'sha': sha,
      'mergedResultSha': mergedResultSha,
      'useCases': useCases.map((x) => x.toCloudUseCase()).toList(),
      'addonsConfigs': addonsConfigs,
      'size': size,
    };
  }
}
