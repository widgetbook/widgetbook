import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:widgetbook_generator/code_generators/instances/list_instance.dart';
import 'package:widgetbook_generator/code_generators/instances/string_instance.dart';

void main() {
  group(
    '$ListInstance',
    () {
      test(
        'empty list',
        () {
          final instance = ListInstance(
            instances: const [],
          );

          expect(
            instance.toCode(),
            equals(
              '[]',
            ),
          );
        },
      );

      test(
        'with values',
        () {
          final instance = ListInstance(
            instances: const [
              StringInstance.value(
                'value1',
              ),
              StringInstance.value(
                'value2',
              ),
            ],
          );

          expect(
            instance.toCode(),
            equals(
              "['value1', 'value2',]",
            ),
          );
        },
      );
    },
  );
}
