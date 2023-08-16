import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:widgetbook_generator/instances/list_instance.dart';
import 'package:widgetbook_generator/instances/string_instance.dart';

void main() {
  group(
    '$ListInstance',
    () {
      test(
        'empty list',
        () {
          const instance = ListInstance<StringInstance>(
            instances: [],
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
          const instance = ListInstance<StringInstance>(
            instances: [
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

      test(
        'with type',
        () {
          const instance = ListInstance<StringInstance>(
            type: 'String',
            instances: [
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
              "<String>['value1', 'value2',]",
            ),
          );
        },
      );
    },
  );
}
