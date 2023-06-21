import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../../helper/matchers.dart';
import '../utils/addon_test_helper.dart';

void main() {
  group('$LocalizationAddon', () {
    test(
      'throws assertion if locales are empty',
      () {
        expect(
          () => LocalizationAddon(
            locales: [],
            localizationsDelegates: [],
          ),
          throwsAssertion('locales cannot be empty'),
        );
      },
    );

    testWidgets(
      'can activate locale',
      (tester) async {
        final addon = LocalizationAddon(
          locales: const [
            Locale('en', 'US'),
            Locale('en', 'GB'),
            Locale('de'),
            Locale('fr'),
          ],
          localizationsDelegates: [
            DefaultWidgetsLocalizations.delegate,
            DefaultMaterialLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate,
          ],
        );

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
            equals(const Locale('de')),
          ),
        );
      },
    );
  });
}
