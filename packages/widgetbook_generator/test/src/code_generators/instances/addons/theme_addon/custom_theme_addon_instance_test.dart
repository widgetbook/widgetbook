import 'package:test/test.dart';
import 'package:widgetbook_generator/code_generators/instances/instances.dart';

import '../../../../mocks/mocks.dart';

void main() {
  group(
    '$CustomThemeAddonInstance',
    () {
      test('.name is "CustomThemeAddon"', () {
        final sut = CustomThemeAddonInstance(
          themes: themes,
          themeType: 'ThemeData',
        );
        expect(sut.name, equals('CustomThemeAddon'));
      });
    },
  );
}
