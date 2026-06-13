import '../../cache/cache.dart';
import 'snapshot_record.dart';

/// One Story (logical UI permutation) in the v4 batched create request.
///
/// The batched create flow sends only story metadata up-front; the snapshots
/// themselves arrive later via `POST v4/builds/{buildId}/snapshots`. This keeps
/// the create payload tiny so the small server task is never asked to parse one
/// giant request.
///
/// Mirrors the server's `StoryRecord` DTO (see widgetbook-premium
/// `apps/server/src/modules/cli/build.dto.ts`).
class StoryRecord {
  const StoryRecord({
    required this.component,
    required this.story,
    required this.navPath,
    this.knobsConfigs,
  });

  final ComponentMetadata component;
  final StoryMetadata story;

  /// The legacy `storyNavPath`:
  /// `component.path + "/" + component.name + "/" + story.name`.
  ///
  /// Sent RAW; the server normalizes it. The owning [SnapshotRecord.navPath]
  /// MUST be this exact same string so the server links snapshots to the story
  /// via its deterministic story id.
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
