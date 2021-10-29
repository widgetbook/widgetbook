import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

import 'package:widgetbook_generator/code_generators/instances/base_instance.dart';

@immutable
class FunctionInstance extends BaseInstance {
  const FunctionInstance({
    required this.name,
    this.parameters = const <String>[],
  });

  final String name;
  final List<String> parameters;

  String _parametersToCode() {
    return parameters.join(', ');
  }

  @override
  String toCode() {
    final parameters = _parametersToCode();
    return '($parameters) => $name($parameters)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is FunctionInstance &&
        other.name == name &&
        listEquals(other.parameters, parameters);
  }

  @override
  int get hashCode => name.hashCode ^ parameters.hashCode;
}
