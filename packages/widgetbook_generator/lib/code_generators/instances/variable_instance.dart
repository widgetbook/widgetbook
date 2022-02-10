import 'package:widgetbook_generator/code_generators/instances/base_instance.dart';

class VariableInstance extends BaseInstance {
  VariableInstance({
    required this.variableIdentifier,
  }) : super();

  final String variableIdentifier;

  @override
  String toCode() {
    return variableIdentifier;
  }
}
