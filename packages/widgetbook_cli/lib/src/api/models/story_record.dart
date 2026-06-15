import '../../cache/cache.dart';

class StoryRecord {
  const StoryRecord({
    required this.component,
    required this.story,
    required this.navPath,
    this.knobsConfigs,
  });

  final ComponentMetadata component;
  final StoryMetadata story;
  final String navPath;

  final Map<String, dynamic>? knobsConfigs;

  Map<String, dynamic> toJson() {
    return {
      'component': component.toJson(),
      'story': story.toJson(),
      'navPath': navPath,
      'knobsConfigs': knobsConfigs,
    };
  }
}
