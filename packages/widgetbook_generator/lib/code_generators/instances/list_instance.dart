import 'package:widgetbook_generator/code_generators/instances/base_instance.dart';

class ListInstance extends BaseInstance {
  ListInstance({
    required this.instances,
    this.trailingComma = true,
  });

  final List<BaseInstance> instances;
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
}
