import 'package:widgetbook_generator/code_generators/instances/instance.dart';
import 'package:widgetbook_generator/code_generators/instances/list_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/widgetbook_use_case_instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';
import 'package:widgetbook_generator/models/widgetbook_story_data.dart';

/// An instance for WidgetElementInstance
class WidgetbookWidgetInstance extends Instance {
  /// Creates a new instance of [WidgetbookWidgetInstance]
  WidgetbookWidgetInstance({
    required String name,
    required List<WidgetbookStoryData> stories,
  }) : super(
          name: 'WidgetbookWidget',
          properties: [
            Property.string(key: 'name', value: name),
            Property(
              key: 'stories',
              instance: ListInstance<StoryInstance>(
                instances: stories
                    .map((story) => StoryInstance(
                          storyName: story.storyName,
                          functionName: story.name,
                        ))
                    .toList(),
              ),
            ),
          ],
        );
}
