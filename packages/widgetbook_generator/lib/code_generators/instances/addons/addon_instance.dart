import 'package:widgetbook_generator/code_generators/instances/instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';

class AddOnInstance extends Instance {
  const AddOnInstance({
    required String name,
    required List<Property> properties,
    List<String> genericParameters = const <String>[],
  }) : super(
          name: name,
          properties: properties,
          genericParameters: genericParameters,
        );
}
