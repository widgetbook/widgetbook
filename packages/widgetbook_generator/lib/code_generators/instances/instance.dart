import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

import '../properties/property.dart';
import 'base_instance.dart';

/// An [Instance] specifies a code element like `Container()`.
/// [Instance] is used to specify and generate code structures so the Widgetbook
/// can be created an tested easily.
@immutable
abstract class Instance extends BaseInstance {
  /// Create a new instance of [Instance]
  ///
  /// [name] specifies the name of the runtime instance which will be create
  /// for the Flutter instance of class `Container`, [name] would be `Container`
  /// as well
  ///
  /// [properties] specifies the properties set for the instance. e.g.,
  /// the instance `SizedBox(width: 20)`, would have one [Property] `width`.
  const Instance({
    required this.name,
    required this.properties,
    this.genericParameters = const <String>[],
    this.namedConstructor,
    this.trailingComma = true,
  });

  /// The name for the instance.
  /// This is basically the class name of the instance.
  ///
  /// For example: `Container`, `Text` or `SizedBox`
  final String name;

  /// Identifier of named constructor
  final String? namedConstructor;

  final List<String> genericParameters;

  /// The properties which are defined by the instance.
  final List<Property> properties;

  /// Specifies if a trailing comma should be inserted into the code.
  /// This leads to better code formatting.
  final bool trailingComma;

  String _propertiesToCode() {
    final codeForProperties =
        properties.map((property) => property.toCode()).toList();

    return codeForProperties.join(', ');
  }

  @override
  String toCode() {
    final stringBuffer = StringBuffer()..write(name);

    if (namedConstructor != null) {
      stringBuffer
        ..write('.')
        ..write(namedConstructor);
    }

    if (genericParameters.isNotEmpty) {
      stringBuffer
        ..write('<')
        ..write(genericParameters.join(', '))
        ..write('>');
    }

    stringBuffer
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
  String toString() => 'Instance('
      'name: $name, properties: $properties, '
      'trailingComma: $trailingComma'
      ')';
}
