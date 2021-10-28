import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:widgetbook_generator/code_generators/properties/function_property.dart';

void main() {
  group(
    '$FunctionProperty',
    () {
      const functionName = 'testMethod';
      const propertyKey = 'builder';
      test(
        '0 parameters',
        () {
          final instance = FunctionProperty(
            name: propertyKey,
            functionName: functionName,
          );

          expect(
            instance.toCode(),
            equals(
              '$propertyKey: () => $functionName()',
            ),
          );
        },
      );

      test(
        '2 parameters',
        () {
          final instance = FunctionProperty(
            name: propertyKey,
            functionName: functionName,
            parameters: ['context', 'index'],
          );

          expect(
            instance.toCode(),
            equals(
              '$propertyKey: (context, index) => $functionName(context, index)',
            ),
          );
        },
      );
    },
  );
}
