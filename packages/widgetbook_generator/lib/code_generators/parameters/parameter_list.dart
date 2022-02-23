import 'package:widgetbook_generator/code_generators/instances/base_instance.dart';
import 'package:widgetbook_generator/code_generators/parameters/parameter.dart';

class ParameterList extends BaseInstance {
  /// Creates a new instance of [ParameterList].
  const ParameterList({
    this.parameters = const <Parameter>[],
    this.trailingComma = true,
  });

  /// Specifies the instances injected into the list.
  final List<Parameter> parameters;

  /// Specifies if a trailing comma should be inserted into the code.
  /// This leads to better code formatting.
  final bool trailingComma;

  @override
  String toCode() {
    final codeOfValues = parameters
        .map(
          (instance) => instance.toCode(),
        )
        .toList();

    final stringBuffer = StringBuffer()
      ..write('(')
      ..write(
        codeOfValues.join(', '),
      );

    if (trailingComma && parameters.isNotEmpty) {
      stringBuffer.write(',');
    }

    stringBuffer.write(')');
    return stringBuffer.toString();
  }
}
