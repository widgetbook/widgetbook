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
            instance.name,
            equals(
              'Story',
            ),
          );

          expect(
            instance.properties,
            equals(
              [
                StringProperty(
                  name: 'name',
                  value: storyName,
                ),
                FunctionProperty(
                  name: 'builder',
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
