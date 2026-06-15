import '../../cache/cache.dart';

class SnapshotRecord {
  const SnapshotRecord({
    required this.scenario,
    required this.image,
    required this.navPath,
    required this.semantics,
  });

  final ScenarioMetadata scenario;
  final ImageMetadata image;

  final String navPath;

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
