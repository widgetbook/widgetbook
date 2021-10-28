import 'package:widgetbook_generator/code_generators/properties/property.dart';

class ListProperty extends Property {
  ListProperty({
    required String key,
    required this.properties,
    this.trailingComma = true,
  }) : super(
          key: key,
        );

  final List<Property> properties;
  final bool trailingComma;

  @override
  String valueToCode() {
    final codeOfValues = properties
        .map(
          // TODO this is a bit weird
          // since the key is not used in lists
          (property) => property.valueToCode(),
        )
        .toList();

    final stringBuffer = StringBuffer()
      ..write('[')
      ..write(
        codeOfValues.join(', '),
      );

    if (trailingComma && properties.isNotEmpty) {
      stringBuffer.write(',');
    }

    stringBuffer.write(']');
    return stringBuffer.toString();
  }
}
