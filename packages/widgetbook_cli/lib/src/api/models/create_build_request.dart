import 'story_record.dart';

/// The v4 batched create request.
///
/// Replaces the legacy inline `scenarios[]` with story metadata only
/// ([stories]) plus the promised total snapshot count
/// ([expectedSnapshotCount]). The snapshots themselves are streamed later via
/// the append endpoint. Mirrors the batched shape of the server's
/// `CreateBuildV4RequestDto` (see widgetbook-premium
/// `apps/server/src/modules/cli/build.dto.ts`).
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
  });

  final String apiKey;
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

  Map<String, dynamic> toJson() {
    return {
      'apiKey': apiKey,
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
    };
  }
}
