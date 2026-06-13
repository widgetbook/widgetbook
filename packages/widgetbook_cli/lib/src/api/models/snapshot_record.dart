import '../../cache/cache.dart';
import 'story_record.dart';

/// One snapshot in a batched append request
/// (`POST v4/builds/{buildId}/snapshots`).
///
/// Mirrors the snapshot-bearing fields of a [ScenarioRecord] minus the story
/// metadata (which was already sent at create time via [StoryRecord]).
///
/// Mirrors the server's `SnapshotRecord` DTO (see widgetbook-premium
/// `apps/server/src/modules/cli/build.dto.ts`).
class SnapshotRecord {
  const SnapshotRecord({
    required this.scenario,
    required this.image,
    required this.navPath,
    required this.semantics,
  });

  final ScenarioMetadata scenario;
  final ImageMetadata image;

  /// The OWNING STORY's navPath, i.e. the SAME string as that story's
  /// [StoryRecord.navPath]:
  /// `component.path + "/" + component.name + "/" + story.name`.
  ///
  /// NOT [ScenarioMetadata.path]. The server links the snapshot to its story
  /// via `deterministicStoryId(buildId, navPath)`; the snapshot row's own path
  /// comes from `scenario.path` server-side. Get this exactly right or
  /// snapshots will not link.
  final String navPath;

  /// Opaque semantics map, sent verbatim from the cache.
  final Map<String, dynamic> semantics;

  Map<String, dynamic> toJson() {
    return {
      'scenario': scenario.toJson(),
      'image': image.toJson(),
      'navPath': navPath,
      'semantics': semantics,
    };
  }
}
