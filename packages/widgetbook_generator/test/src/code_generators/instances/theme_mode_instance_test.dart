import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:widgetbook_generator/code_generators/instances/theme_mode_instance.dart';

void main() {
  group(
    '$ThemeModeInstance',
    () {
      test(
        '.toCode returns correct code',
        () {
          const instance = ThemeModeInstance(name: 'dark');

          expect(
            instance.toCode(),
            equals('ThemeMode.dark'),
          );
        },
      );
    },
  );
}
