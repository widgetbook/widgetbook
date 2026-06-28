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
    this.violations = const [],
  });

  final StoryMetadata story;
  final ComponentMetadata component;
  final ImageMetadata image;
  final ScenarioMetadata scenario;
  final Map<String, dynamic> semantics;
  final List<Map<String, dynamic>> violations;

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
    // Older builds (captured before guideline evaluation existed) omit this.
    final violations = (json['violations'] as List<dynamic>?)
            ?.cast<Map<String, dynamic>>() ??
        const [];

    return ScenarioRecord(
      component: component,
      story: story,
      scenario: scenario,
      image: image,
      semantics: semantics,
      violations: violations,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'component': component.toJson(),
      'story': story.toJson(),
      'scenario': scenario.toJson(),
      'image': image.toJson(),
      'semantics': semantics,
      'violations': violations,
    };
  }
}
