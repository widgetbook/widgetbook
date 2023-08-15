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
    this.type,
    this.trailingComma = true,
  });

  /// Specifies the instances injected into the list.
  final List<T> instances;

  /// Specifies actual type of the generate list.
  final String? type;

  /// Specifies if a trailing comma should be inserted into the code.
  /// This leads to better code formatting.
  final bool trailingComma;

  @override
  String toCode() {
    final buffer = StringBuffer();

    if (type != null) {
      buffer.write('<$type>');
    }

    buffer.write('[');
    buffer.write(
      instances.map((instance) => instance.toCode()).join(', '),
    );

    if (trailingComma && instances.isNotEmpty) {
      buffer.write(',');
    }

    buffer.write(']');

    return buffer.toString();
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
