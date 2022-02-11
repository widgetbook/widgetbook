import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:widgetbook_generator/code_generators/instances/theme_instance.dart';
import 'package:widgetbook_generator/models/widgetbook_theme_data.dart';

void main() {
  group(
    '$ThemeInstance',
    () {
      test(
        ".name return 'name'",
        () {
          final instance = ThemeInstance(
            theme: WidgetbookThemeData(
              dependencies: [],
              name: 'getTheme',
              isDefault: false,
              themeName: 'Dark',
              importStatement: '',
            ),
          );
          expect(
            instance.name,
            equals('WidgetbookTheme'),
          );
        },
      );
    },
  );
}
