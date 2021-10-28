import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';

@immutable
class FunctionProperty extends Property {
  FunctionProperty({
    required String name,
    required this.functionName,
    this.parameters = const <String>[],
  }) : super(
          name: name,
        );

  final String functionName;
  final List<String> parameters;

  String parametersToCode() {
    return parameters.join(', ');
  }

  @override
  String valueToCode() {
    final parameters = parametersToCode();
    return '($parameters) => $functionName($parameters)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is FunctionProperty &&
        other.name == name &&
        other.functionName == functionName &&
        listEquals(other.parameters, parameters);
  }

  @override
  int get hashCode =>
      functionName.hashCode ^ parameters.hashCode ^ name.hashCode;
}
