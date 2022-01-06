import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:widgetbook_generator/code_generators/instances/boolean_instance.dart';

void main() {
  group(
    '$BooleanInstance',
    () {
      const value = true;

      test(
        '.toCode returns correct code',
        () {
          const instance = BooleanInstance.value(
            value,
          );

          expect(
            instance.toCode(),
            equals('true'),
          );
        },
      );
    },
  );
}
