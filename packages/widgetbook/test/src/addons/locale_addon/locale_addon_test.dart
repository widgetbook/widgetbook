import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../utils/addon_test_helper.dart';
import 'locale_addon_utilities.dart';

void main() {
  final setting = LocalizationSetting.firstAsSelected(
    locales: locales,
    localizationsDelegates: localizationsDelegates,
  );
  final addon = LocalizationAddon(
    setting: setting,
  );

  group('$LocalizationAddon', () {
    testWidgets(
      'can access locale via the context',
      (WidgetTester tester) async {
        await testAddon(
          tester: tester,
          addon: addon,
          expect: (context) => expect(
            context.localization,
            equals(setting),
          ),
        );
      },
    );

    testWidgets(
      'can activate a locale',
      (WidgetTester tester) async {
        await testAddon(
          tester: tester,
          addon: addon,
          act: (context) async => addon.onChanged(
            context,
            setting.copyWith(activeLocale: frenchLocale),
          ),
          expect: (context) => expect(
            context.localization!.activeLocale,
            equals(frenchLocale),
          ),
        );
      },
    );

    testWidgets(
      'can activate locale via Widget',
      (WidgetTester tester) async {
        await testAddon(
          tester: tester,
          addon: addon,
          act: (context) async {
            final dropdownFinder = find.byType(DropdownMenu<Locale>);
            await tester.tap(dropdownFinder);
            await tester.pumpAndSettle();

            final textFinder = find.byWidgetPredicate(
              (widget) => widget is Text && widget.data == 'de',
            );
            await tester.tap(textFinder.last);
            await tester.pumpAndSettle();
          },
          expect: (context) => expect(
            context.localization!.activeLocale,
            equals(germanLocale),
          ),
        );
      },
    );

    testWidgets(
      'supports locales with same language code',
      (tester) async {
        await testAddon(
          tester: tester,
          addon: addon,
          act: (context) async => addon.onChanged(
            context,
            setting.copyWith(
              activeLocale: engLocaleGb,
            ),
          ),
          expect: (context) {
            expect(
              context.localization!.activeLocale,
              equals(engLocaleGb),
            );
          },
        );
      },
    );
  });
}
