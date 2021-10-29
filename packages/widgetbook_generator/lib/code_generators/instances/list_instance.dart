import 'package:collection/collection.dart';

import 'package:widgetbook_generator/code_generators/instances/base_instance.dart';

class ListInstance<T extends BaseInstance> extends BaseInstance {
  const ListInstance({
    required this.instances,
    this.trailingComma = true,
  });

  final List<T> instances;
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
