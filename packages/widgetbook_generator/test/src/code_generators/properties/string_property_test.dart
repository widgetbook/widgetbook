import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:widgetbook_generator/code_generators/properties/string_property.dart';

void main() {
  group(
    '$StringProperty',
    () {
      const stringValue = 'String Value';

      test(
        '.toCode',
        () {
          final instance = StringProperty(
            name: 'name',
            value: stringValue,
          );

          expect(
            instance.toCode(),
            equals("name: '$stringValue'"),
          );
        },
      );
    },
  );
}
