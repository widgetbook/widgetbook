import 'package:widgetbook_generator/code_generators/properties/property.dart';

abstract class CodeGenerator {
  CodeGenerator({
    required this.name,
    this.trailingComma = true,
    this.properties = const <Property>[],
  });

  final String name;
  final bool trailingComma;
  final List<Property> properties;

  void addProperty(Property property) {
    properties.add(property);
  }

  String propertiesToCode() {
    final codeForProperties =
        properties.map((property) => property.toCode()).toList();

    return codeForProperties.join(',\n');
  }

  String toCode() {
    final stringBuffer = StringBuffer()
      ..write(name)
      ..write('(')
      ..write(
        propertiesToCode(),
      );

    if (trailingComma && properties.isNotEmpty) {
      stringBuffer.write(',');
    }

    stringBuffer.write(')');
    return stringBuffer.toString();
  }
}
