import 'snapshot_record.dart';

class AppendSnapshotsRequest {
  const AppendSnapshotsRequest({
    required this.snapshots,
  });

  final List<SnapshotRecord> snapshots;

  Map<String, dynamic> toJson() {
    return {
      'snapshots': snapshots.map((snapshot) => snapshot.toJson()).toList(),
    };
  }
}
