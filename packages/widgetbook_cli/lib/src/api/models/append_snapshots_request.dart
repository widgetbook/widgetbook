import 'snapshot_record.dart';

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
