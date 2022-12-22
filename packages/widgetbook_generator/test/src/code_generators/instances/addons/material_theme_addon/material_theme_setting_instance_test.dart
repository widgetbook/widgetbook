import 'package:test/test.dart';
import 'package:widgetbook_generator/code_generators/instances/instances.dart';

import '../../../../mocks/mocks.dart';

void main() {
  group('$MaterialThemeSettingInstance', () {
    test(
      '.name returns "MaterialThemeSetting"',
      () {
        expect(
          MaterialThemeSettingInstance(
            themes: themes,
            defaultTheme: themeLight,
          ).name,
          equals('MaterialThemeSetting'),
        );
      },
    );
  });
}
