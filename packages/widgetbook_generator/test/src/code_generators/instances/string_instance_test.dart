import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:widgetbook_generator/code_generators/instances/string_instance.dart';

void main() {
  group(
    '$StringInstance',
    () {
      const stringValue = 'String Value';

      test(
        '.toCode',
        () {
          const instance = StringInstance.value(
            stringValue,
          );

          expect(
            instance.toCode(),
            equals("'$stringValue'"),
          );
        },
      );
    },
  );
}
