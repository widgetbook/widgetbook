import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../utils/addon_test_helper.dart';

void main() {
  group(
    '$TextScaleAddon',
    () {
      final addon = TextScaleAddon(
        scales: [1.0, 2.0, 3.0],
      );

      testWidgets(
        'can activate a text scale factor',
        (WidgetTester tester) async {
          await testAddon(
            tester: tester,
            addon: addon,
            act: () async => addon.updateSetting(
              addon.setting.copyWith(
                activeTextScale: 2,
              ),
            ),
            expect: (context) => expect(
              addon.setting.activeTextScale,
              equals(2),
            ),
          );
        },
      );

      testWidgets(
        'can activate text scale factor via Widget',
        (WidgetTester tester) async {
          await testAddon(
            tester: tester,
            addon: addon,
            act: () async {
              final dropdownFinder = find.byType(DropdownMenu<double>);
              await tester.tap(dropdownFinder);
              await tester.pumpAndSettle();

              final textFinder = find.byWidgetPredicate(
                (widget) => widget is Text && widget.data == '2.00',
              );
              await tester.tap(textFinder.last);
              await tester.pumpAndSettle();
            },
            expect: (context) => expect(
              addon.setting.activeTextScale,
              equals(2),
            ),
          );
        },
      );
    },
  );
}
