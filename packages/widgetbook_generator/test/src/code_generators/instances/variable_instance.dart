import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:widgetbook_generator/code_generators/instances/variable_instance.dart';

void main() {
  group(
    '$VariableInstance',
    () {
      test(
        'returns identifier',
        () {
          const variableId = 'test';
          expect(
            const VariableInstance(variableIdentifier: variableId).toCode(),
            equals(variableId),
          );
        },
      );
    },
  );
}
