import 'package:widgetbook_generator/code_generators/instances/instance.dart';
import 'package:widgetbook_generator/code_generators/instances/list_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/widgetbook_use_case_instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';
import 'package:widgetbook_generator/models/widgetbook_story_data.dart';

/// An instance for WidgetElementInstance
class WidgetbookComponentInstance extends Instance {
  /// Creates a new instance of [WidgetbookComponentInstance]
  WidgetbookComponentInstance({
    required String name,
    required List<WidgetbookStoryData> stories,
    bool isExpanded = false,
  }) : super(
          name: 'WidgetbookComponent',
          properties: [
            Property.string(key: 'name', value: name),
            Property(
              key: 'useCases',
              instance: ListInstance<WidgetbookUseCaseInstance>(
                instances: stories
                    .map((story) => WidgetbookUseCaseInstance(
                          useCaseName: story.storyName,
                          functionName: story.name,
                        ))
                    .toList(),
              ),
            ),
            if (isExpanded) Property.bool(key: 'isExpanded', value: true),
          ],
        );
}
