import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../utils/addon_test_helper.dart';
import 'locale_addon_utilities.dart';

void main() {
  final addon = LocalizationAddon(
    locales: locales,
    localizationsDelegates: localizationsDelegates,
  );

  group('$LocalizationAddon', () {
    testWidgets(
      'can activate locale',
      (WidgetTester tester) async {
        await testAddon<Locale>(
          tester: tester,
          addon: addon,
          act: () async {
            final dropdownFinder = find.byType(DropdownMenu<Locale>);
            await tester.tap(dropdownFinder);
            await tester.pumpAndSettle();

            final textFinder = find.byWidgetPredicate(
              (widget) => widget is Text && widget.data == 'de',
            );
            await tester.tap(textFinder.last);
            await tester.pumpAndSettle();
          },
          expect: (setting) => expect(
            setting,
            equals(germanLocale),
          ),
        );
      },
    );
  });
}
