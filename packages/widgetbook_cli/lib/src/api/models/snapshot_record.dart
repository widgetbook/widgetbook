import '../../cache/cache.dart';

class SnapshotRecord {
  const SnapshotRecord({
    required this.scenario,
    required this.image,
    required this.navPath,
    required this.semantics,
    this.violations = const [],
  });

  final ScenarioMetadata scenario;
  final ImageMetadata image;

  final String navPath;

  final Map<String, dynamic> semantics;

  final List<Map<String, dynamic>> violations;

  Map<String, dynamic> toJson() {
    return {
      'scenario': scenario.toJson(),
      'image': image.toJson(),
      'navPath': navPath,
      'semantics': semantics,
      'violations': violations,
    };
  }
}
