import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

import 'package:widgetbook_generator/code_generators/instances/base_instance.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';

@immutable
abstract class Instance extends BaseInstance {
  const Instance({
    required this.name,
    required this.properties,
    this.trailingComma = true,
  });

  final String name;
  final List<Property> properties;
  final bool trailingComma;

  String _propertiesToCode() {
    final codeForProperties =
        properties.map((property) => property.toCode()).toList();

    return codeForProperties.join(', ');
  }

  @override
  String toCode() {
    final stringBuffer = StringBuffer()
      ..write(name)
      ..write('(')
      ..write(
        _propertiesToCode(),
      );

    if (trailingComma && properties.isNotEmpty) {
      stringBuffer.write(',');
    }

    stringBuffer.write(')');
    return stringBuffer.toString();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Instance &&
        other.name == name &&
        listEquals(other.properties, properties) &&
        other.trailingComma == trailingComma;
  }

  @override
  int get hashCode =>
      name.hashCode ^ properties.hashCode ^ trailingComma.hashCode;

  @override
  String toString() =>
      'Instance(name: $name, properties: $properties, trailingComma: $trailingComma)';
}
