import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/test/font_loader.dart';

void main() {
  group('bareFamilyAliases', () {
    test('aliases a dependency package font to its bare family name', () {
      // Regression test for widgetbook#1991: a font declared by a dependency
      // package and referenced without a `package:` argument fell back to the
      // test font, rendering every glyph as a filled black rectangle.
      final aliases = bareFamilyAliases([
        'MaterialIcons',
        'packages/assets/My Custom Font',
      ]);

      expect(aliases, {'packages/assets/My Custom Font': 'My Custom Font'});
    });

    test('leaves root package families untouched', () {
      final aliases = bareFamilyAliases(['MaterialIcons', 'Inter']);

      expect(aliases, isEmpty);
    });

    test('does not shadow a family already declared by the root package', () {
      final aliases = bareFamilyAliases([
        'Inter',
        'packages/design_system/Inter',
      ]);

      expect(aliases, isEmpty);
    });

    test('does not alias a family declared by more than one package', () {
      final aliases = bareFamilyAliases([
        'packages/design_system/Inter',
        'packages/legacy_theme/Inter',
      ]);

      expect(aliases, isEmpty);
    });

    test('keeps aliasing the Roboto that widgetbook supplies', () {
      final aliases = bareFamilyAliases(['packages/widgetbook/Roboto']);

      expect(aliases, {'packages/widgetbook/Roboto': 'Roboto'});
    });
  });
}
