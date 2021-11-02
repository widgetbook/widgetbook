import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:widgetbook_generator/code_generators/instances/theme_instance.dart';

void main() {
  group(
    '$ThemeInstance',
    () {
      test(
        ".name return 'name'",
        () {
          const instance = ThemeInstance(name: 'name');
          expect(
            instance.name,
            equals('name'),
          );
        },
      );
    },
  );
}
