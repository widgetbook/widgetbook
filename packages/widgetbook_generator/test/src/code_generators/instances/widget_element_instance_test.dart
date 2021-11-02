import 'package:test/test.dart';
import 'package:widgetbook_generator/code_generators/instances/list_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/story_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/widget_element_instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';
import 'package:widgetbook_generator/models/widgetbook_story_data.dart';

import '../instance_helper.dart';

void main() {
  group(
    '$WidgetElementInstance',
    () {
      const widgetName = 'CustomWidget';

      final instance = WidgetElementInstance(
        name: widgetName,
        stories: [
          WidgetbookStoryData(
            name: 'story1',
            importStatement: '',
            typeDefinition: '',
            dependencies: [],
            storyName: 'Story1',
            widgetName: widgetName,
          ),
          WidgetbookStoryData(
            name: 'story2',
            importStatement: '',
            typeDefinition: '',
            dependencies: [],
            storyName: 'Story2',
            widgetName: widgetName,
          ),
        ],
      );

      testName('WidgetElement', instance: instance);

      test(
        '.properties returns a StringProperty and Property containing a list',
        () {
          expect(
            instance.properties,
            equals(
              [
                Property.string(
                  key: 'name',
                  value: widgetName,
                ),
                Property(
                  key: 'stories',
                  instance: ListInstance(instances: [
                    StoryInstance(storyName: 'Story1', functionName: 'story1'),
                    StoryInstance(storyName: 'Story2', functionName: 'story2'),
                  ]),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
