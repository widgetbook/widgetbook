import 'package:widgetbook_generator/code_generators/instances/base_instance.dart';

abstract class CodeGenerator {
  CodeGenerator({
    this.trailingComma = true,
    required this.instance,
  });

  final bool trailingComma;
  final BaseInstance instance;

  String toCode() {
    return instance.toCode();
  }
}
