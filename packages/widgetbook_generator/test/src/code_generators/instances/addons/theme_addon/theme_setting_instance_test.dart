import 'package:test/test.dart';
import 'package:widgetbook_generator/code_generators/instances/instances.dart';

import '../../../../mocks/mocks.dart';

void main() {
  group('$ThemeSettingInstance', () {
    test(
      '.name returns "ThemeSetting"',
      () {
        expect(
          ThemeSettingInstance(
            themes: themes,
            defaultTheme: themeLight,
            themeType: 'ThemeData',
          ).name,
          equals('ThemeSetting'),
        );
      },
    );
  });
}
