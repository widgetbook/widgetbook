import 'snapshot_record.dart';

/// Body of `POST v4/builds/{buildId}/snapshots` — one batch of snapshot
/// metadata for an in-progress batched build.
///
/// The build id is a path param, not part of this body. Mirrors the server's
/// `AppendSnapshotsV4RequestDto` (see widgetbook-premium
/// `apps/server/src/modules/cli/build.dto.ts`).
class AppendSnapshotsRequest {
  const AppendSnapshotsRequest({
    required this.apiKey,
    required this.snapshots,
  });

  final String apiKey;
  final List<SnapshotRecord> snapshots;

  Map<String, dynamic> toJson() {
    return {
      'apiKey': apiKey,
      'snapshots': snapshots.map((snapshot) => snapshot.toJson()).toList(),
    };
  }
}
