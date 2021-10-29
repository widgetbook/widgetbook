import 'package:widgetbook_generator/code_generators/instances/function_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';

class StoryInstance extends Instance {
  StoryInstance({
    required String storyName,
    required String functionName,
  }) : super(
          name: 'Story',
          properties: [
            Property.string(
              key: 'name',
              value: storyName,
            ),
            Property(
              key: 'builder',
              instance: FunctionInstance(
                name: functionName,
                parameters: const [
                  'context',
                ],
              ),
            ),
          ],
        );
}
