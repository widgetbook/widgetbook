import '../../cache/cache.dart';
import 'snapshot_record.dart';

/// One Story (logical UI permutation) in the v4 batched create request.
///
/// The batched create flow sends only story metadata up-front; the snapshots
/// themselves arrive later via `POST v4/builds/{buildId}/snapshots`, which
/// keeps the create payload small.
class StoryRecord {
  const StoryRecord({
    required this.component,
    required this.story,
    required this.navPath,
    this.knobsConfigs,
  });

  final ComponentMetadata component;
  final StoryMetadata story;

  /// The story's navPath:
  /// `component.path + "/" + component.name + "/" + story.name`.
  ///
  /// Sent raw; Widgetbook Cloud normalizes it. The owning
  /// [SnapshotRecord.navPath] MUST be this exact same string so appended
  /// snapshots link to this story.
  final String navPath;

  final Map<String, dynamic>? knobsConfigs;

  Map<String, dynamic> toJson() {
    return {
      'component': component.toJson(),
      'story': story.toJson(),
      'navPath': navPath,
      'knobsConfigs': knobsConfigs,
    };
  }
}
