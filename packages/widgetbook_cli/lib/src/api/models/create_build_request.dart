import '../../cache/cache.dart';

class CreateBuildRequest {
  const CreateBuildRequest({
    required this.apiKey,
    required this.versionControlProvider,
    required this.repository,
    required this.actor,
    required this.branch,
    required this.sha,
    required this.mergedResultSha,
    required this.scenarios,
    required this.size,
    required this.hash,
  });

  final String apiKey;
  final String versionControlProvider;
  final String repository;
  final String actor;
  final String branch;
  final String sha;
  final String? mergedResultSha;
  final List<ScenarioRecord> scenarios;
  final int size;
  final String? hash;

  Map<String, dynamic> toJson() {
    return {
      'apiKey': apiKey,
      'versionControlProvider': versionControlProvider,
      'repository': repository,
      'actor': actor,
      'branch': branch,
      'sha': sha,
      'mergedResultSha': mergedResultSha,
      'scenarios': scenarios.map((scenario) => scenario.toJson()).toList(),
      'size': size,
      'hash': hash,
    };
  }
}
