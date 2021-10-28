import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:widgetbook_generator/code_generators/properties/list_property.dart';
import 'package:widgetbook_generator/code_generators/properties/string_property.dart';

void main() {
  group(
    '$ListProperty',
    () {
      test(
        'empty property',
        () {
          final instance = ListProperty(
            key: 'test',
            properties: [],
          );

          expect(
            instance.toCode(),
            equals(
              'test: []',
            ),
          );
        },
      );

      test(
        'with properties',
        () {
          const key = 'not important';
          final instance = ListProperty(
            key: 'test',
            properties: [
              StringProperty(
                key: key,
                value: 'value1',
              ),
              StringProperty(
                key: key,
                value: 'value2',
              ),
            ],
          );

          expect(
            instance.toCode(),
            equals(
              "test: ['value1', 'value2',]",
            ),
          );
        },
      );
    },
  );
}
