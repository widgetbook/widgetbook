import 'package:widgetbook_generator/code_generators/code_generator.dart';
import 'package:widgetbook_generator/code_generators/properties/function_property.dart';
import 'package:widgetbook_generator/code_generators/properties/string_property.dart';

class StoryGenerator extends CodeGenerator {
  StoryGenerator({
    required String name,
    required String functionName,
  }) : super(
          instanceName: 'Story',
          properties: [
            StringProperty(
              key: 'name',
              value: name,
            ),
            FunctionProperty(
              key: 'builder',
              parameters: const [
                'context',
              ],
              functionName: functionName,
            )
          ],
        );
}
