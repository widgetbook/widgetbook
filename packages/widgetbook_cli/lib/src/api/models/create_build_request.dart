import 'api_key.dart';
import 'story_record.dart';

class CreateBuildRequest {
  const CreateBuildRequest({
    required this.apiKey,
    required this.versionControlProvider,
    required this.repository,
    required this.actor,
    required this.branch,
    required this.sha,
    required this.mergedResultSha,
    required this.stories,
    required this.expectedSnapshotCount,
    required this.size,
    required this.hash,
    this.projectName,
  });

  final ApiKey apiKey;
  final String versionControlProvider;
  final String repository;
  final String actor;
  final String branch;
  final String sha;
  final String? mergedResultSha;
  final List<StoryRecord> stories;
  final int expectedSnapshotCount;
  final int size;
  final String? hash;
  final String? projectName;

  Map<String, dynamic> toJson() {
    return {
      ...apiKey.toJson(),
      'versionControlProvider': versionControlProvider,
      'repository': repository,
      'actor': actor,
      'branch': branch,
      'sha': sha,
      'mergedResultSha': mergedResultSha,
      'stories': stories.map((story) => story.toJson()).toList(),
      'expectedSnapshotCount': expectedSnapshotCount,
      'size': size,
      'hash': hash,
      if (projectName != null) 'projectName': projectName,
    };
  }
}
