import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'package:widgetbook_generator/code_generators/properties/property.dart';

@immutable
class FunctionProperty extends Property {
  FunctionProperty({
    required String key,
    required this.functionName,
    this.parameters = const <String>[],
  }) : super(
          key: key,
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
        other.key == key &&
        other.functionName == functionName &&
        listEquals(other.parameters, parameters);
  }

  @override
  int get hashCode =>
      functionName.hashCode ^ parameters.hashCode ^ key.hashCode;
}
