import 'package:test/test.dart';
import 'package:widgetbook_generator/code_generators/properties/function_property.dart';
import 'package:widgetbook_generator/code_generators/properties/string_property.dart';
import 'package:widgetbook_generator/code_generators/story_generator.dart';

void main() {
  group(
    '$StoryGenerator',
    () {
      const storyName = 'Test';
      const storyBuilder = 'someStory';
      test(
        'descriptiosthn',
        () {
          final instance = StoryGenerator(
            name: storyName,
            functionName: storyBuilder,
          );

          expect(
            instance.instanceName,
            equals(
              'Story',
            ),
          );

          expect(
            instance.properties,
            equals(
              [
                StringProperty(
                  key: 'name',
                  value: storyName,
                ),
                FunctionProperty(
                  key: 'builder',
                  functionName: storyBuilder,
                  parameters: const [
                    'context',
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
