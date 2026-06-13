/// Response of `POST v4/builds/{buildId}/snapshots`.
///
/// Mirrors the server's `AppendSnapshotsResponseDto` (see widgetbook-premium
/// `apps/server/src/modules/cli/build.response.ts`).
class AppendSnapshotsResponse {
  const AppendSnapshotsResponse({
    required this.inserted,
  });

  /// Number of snapshot rows persisted by this batch.
  final int inserted;

  // ignore: sort_constructors_first
  factory AppendSnapshotsResponse.fromJson(Map<String, dynamic> json) {
    return AppendSnapshotsResponse(
      inserted: json['inserted'] as int,
    );
  }
}
