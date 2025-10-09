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
  });

  final StoryMetadata story;
  final ComponentMetadata component;
  final ImageMetadata image;
  final ScenarioMetadata scenario;

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

    return ScenarioRecord(
      component: component,
      story: story,
      scenario: scenario,
      image: image,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'component': component.toJson(),
      'story': story.toJson(),
      'scenario': scenario.toJson(),
      'image': image.toJson(),
    };
  }
}
