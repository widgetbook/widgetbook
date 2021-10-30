import 'package:test/test.dart';
import 'package:widgetbook_generator/code_generators/instances/lambda_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/story_instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';

import '../instance_helper.dart';

void main() {
  group(
    '$StoryInstance',
    () {
      const storyName = 'Test';
      const storyBuilder = 'someStory';

      final instance = StoryInstance(
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
                  instance: LambdaInstance(
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
