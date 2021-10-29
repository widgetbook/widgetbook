import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:widgetbook_generator/code_generators/instances/double_instance.dart';

void main() {
  group(
    '$DoubleInstance',
    () {
      const value = 20.0;

      test(
        '.toCode returns correct code',
        () {
          const instance = DoubleInstance.value(
            value,
          );

          expect(
            instance.toCode(),
            equals('20.0'),
          );
        },
      );
    },
  );
}
