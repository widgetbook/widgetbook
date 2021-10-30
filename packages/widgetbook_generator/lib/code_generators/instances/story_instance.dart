import 'package:widgetbook_generator/code_generators/instances/instance.dart';
import 'package:widgetbook_generator/code_generators/instances/lambda_instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';

/// An instance for Story
class StoryInstance extends Instance {
  /// Creates a new instance of [StoryInstance]
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
              instance: LambdaInstance(
                name: functionName,
                parameters: const [
                  'context',
                ],
              ),
            ),
          ],
        );
}
