import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:widgetbook_generator/code_generators/instances/lambda_instance.dart';

void main() {
  group(
    '$LambdaInstance',
    () {
      const functionName = 'testMethod';
      test(
        '0 parameters',
        () {
          const instance = LambdaInstance(
            name: functionName,
          );

          expect(
            instance.toCode(),
            equals(
              '() => $functionName()',
            ),
          );
        },
      );

      test(
        '2 parameters',
        () {
          const instance = LambdaInstance(
            name: functionName,
            parameters: [
              'context',
              'index',
            ],
          );

          expect(
            instance.toCode(),
            equals(
              '(context, index) => $functionName(context, index)',
            ),
          );
        },
      );
    },
  );
}
