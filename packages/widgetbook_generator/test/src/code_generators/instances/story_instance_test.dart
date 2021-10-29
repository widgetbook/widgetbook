import 'package:test/test.dart';
import 'package:widgetbook_generator/code_generators/instances/function_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/instance.dart';
import 'package:widgetbook_generator/code_generators/instances/story_instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';

import '../instance_helper.dart';

void main() {
  group(
    '$StoryInstance',
    () {
      const storyName = 'Test';
      const storyBuilder = 'someStory';

      Instance instance = StoryInstance(
        storyName: storyName,
        functionName: storyBuilder,
      );

      testName('Story', instance: instance);

      test(
        ".properties returns a name and a function 'builder'",
        () {
          expect(
            instance.properties,
            equals(
              [
                Property.string(
                  key: 'name',
                  value: storyName,
                ),
                const Property(
                  key: 'builder',
                  instance: FunctionInstance(
                    name: storyBuilder,
                    parameters: [
                      'context',
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
