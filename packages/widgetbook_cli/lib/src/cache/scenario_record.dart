import 'component_metadata.dart';
import 'image_metadata.dart';
import 'scenario_metadata.dart';
import 'story_metadata.dart';

class ScenarioRecord {
  const ScenarioRecord({
    required this.component,
    required this.story,
    required this.scenario,
    required this.image,
    required this.semantics,
  });

  final StoryMetadata story;
  final ComponentMetadata component;
  final ImageMetadata image;
  final ScenarioMetadata scenario;
  final Map<String, dynamic> semantics;

  /// The owning story's navigation path, computed exactly as the server's
  /// legacy `storyNavPath`:
  /// `component.path + "/" + component.name + "/" + story.name`.
  ///
  /// Sent RAW to the server (it normalizes it). The batched create request
  /// sends this on each story record, and every appended snapshot record sends
  /// the SAME string for its owning story so the server links the snapshot to
  /// the right story via its deterministic id.
  String get storyNavPath =>
      '${component.path}/${component.name}/${story.name}';

  // ignore: sort_constructors_first
  factory ScenarioRecord.fromJson(Map<String, dynamic> json) {
    final component = ComponentMetadata.fromJson(
      json['component'] as Map<String, dynamic>,
    );
    final story = StoryMetadata.fromJson(
      json['story'] as Map<String, dynamic>,
    );
    final scenario = ScenarioMetadata.fromJson(
      json['scenario'] as Map<String, dynamic>,
    );
    final image = ImageMetadata.fromJson(
      json['image'] as Map<String, dynamic>,
    );
    final semantics = json['semantics'] as Map<String, dynamic>;

    return ScenarioRecord(
      component: component,
      story: story,
      scenario: scenario,
      image: image,
      semantics: semantics,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'component': component.toJson(),
      'story': story.toJson(),
      'scenario': scenario.toJson(),
      'image': image.toJson(),
      'semantics': semantics,
    };
  }
}
