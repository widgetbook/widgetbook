import 'api_key.dart';
import 'snapshot_record.dart';

class AppendSnapshotsRequest {
  const AppendSnapshotsRequest({
    required this.apiKey,
    required this.snapshots,
  });

  final ApiKey apiKey;
  final List<SnapshotRecord> snapshots;

  Map<String, dynamic> toJson() {
    return {
      ...apiKey.toJson(),
      'snapshots': snapshots.map((snapshot) => snapshot.toJson()).toList(),
    };
  }
}
