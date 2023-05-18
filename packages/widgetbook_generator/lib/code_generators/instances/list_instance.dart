import 'package:collection/collection.dart';

import 'base_instance.dart';

/// An instance that allows to define multiple types of [BaseInstance]s as a
/// List.
///
/// [ListInstance] generates code of the form `[Instance1, Instance2, ...]
class ListInstance<T extends BaseInstance> extends BaseInstance {
  /// Creates a new instance of [ListInstance]
  ///
  /// [instances] specifies the instances injected into the list.
  const ListInstance({
    required this.instances,
    this.trailingComma = true,
  });

  /// Specifies the instances injected into the list.
  final List<T> instances;

  /// Specifies if a trailing comma should be inserted into the code.
  /// This leads to better code formatting.
  final bool trailingComma;

  @override
  String toCode() {
    final codeOfValues = instances
        .map(
          (instance) => instance.toCode(),
        )
        .toList();

    final stringBuffer = StringBuffer()
      ..write('[')
      ..write(
        codeOfValues.join(', '),
      );

    if (trailingComma && instances.isNotEmpty) {
      stringBuffer.write(',');
    }

    stringBuffer.write(']');
    return stringBuffer.toString();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is ListInstance<T> &&
        listEquals(other.instances, instances) &&
        other.trailingComma == trailingComma;
  }

  @override
  int get hashCode => instances.hashCode ^ trailingComma.hashCode;

  @override
  String toString() =>
      'ListInstance(instances: $instances, trailingComma: $trailingComma)';
}
