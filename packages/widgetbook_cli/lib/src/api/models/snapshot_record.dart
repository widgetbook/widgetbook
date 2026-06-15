import '../../cache/cache.dart';
import 'story_record.dart';

/// One snapshot in a batched append request
/// (`POST v4/builds/{buildId}/snapshots`).
///
/// Carries the snapshot-bearing fields of a [ScenarioRecord] minus the story
/// metadata (already sent at create time via [StoryRecord]).
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
  /// NOT [ScenarioMetadata.path]. Snapshots link to their story by matching
  /// this navPath to the story's; get it exactly right or they will not link.
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
