import 'package:test/test.dart';
import 'package:widgetbook_generator/instances/lambda_instance.dart';
import 'package:widgetbook_generator/instances/property.dart';
import 'package:widgetbook_generator/instances/widgetbook_use_case_instance.dart';

import 'instance_helper.dart';

void main() {
  group(
    '$WidgetbookUseCaseInstance',
    () {
      const storyName = 'Test';
      const storyBuilder = 'someStory';

      final instance = WidgetbookUseCaseInstance(
        useCaseName: storyName,
        functionName: storyBuilder,
      );

      testName('WidgetbookUseCase', instance: instance);

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
