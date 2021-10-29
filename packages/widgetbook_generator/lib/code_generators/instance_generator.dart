import 'package:widgetbook_generator/code_generators/instances/instance.dart';

class InstanceGenerator {
  InstanceGenerator({
    required this.instance,
    this.trailingComma = true,
  });

  final Instance instance;
  final bool trailingComma;

  String propertiesToCode() {
    final codeForProperties =
        instance.properties.map((property) => property.toCode()).toList();

    return codeForProperties.join(',\n');
  }

  String toCode(Instance instance) {
    final stringBuffer = StringBuffer()
      ..write(instance.name)
      ..write('(')
      ..write(
        propertiesToCode(),
      );

    if (trailingComma && instance.properties.isNotEmpty) {
      stringBuffer.write(',');
    }

    stringBuffer.write(')');
    return stringBuffer.toString();
  }
}
