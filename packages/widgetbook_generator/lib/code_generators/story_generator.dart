import 'package:widgetbook_generator/code_generators/code_generator.dart';
import 'package:widgetbook_generator/code_generators/properties/function_property.dart';
import 'package:widgetbook_generator/code_generators/properties/string_property.dart';

class StoryGenerator extends CodeGenerator {
  StoryGenerator({
    required String name,
    required String functionName,
  }) : super(
          name: 'Story',
          properties: [
            StringProperty(
              name: 'name',
              value: name,
            ),
            FunctionProperty(
              name: 'builder',
              parameters: [
                'context',
              ],
              functionName: functionName,
            )
          ],
        );
}
