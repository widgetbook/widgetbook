import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../utils/addon_test_helper.dart';

void main() {
  group(
    '$TextScaleAddon',
    () {
      const textScales = [
        1.0,
        2.0,
        3.0,
      ];
      final setting = TextScaleSetting.firstAsSelected(
        textScales: textScales,
      );
      final addon = TextScaleAddon(
        setting: setting,
      );

      testWidgets(
        'can access text scale factor via the context',
        (WidgetTester tester) async {
          await testAddon(
            tester: tester,
            addon: addon,
            expect: (context) => expect(
              context.textScale,
              equals(1),
            ),
          );
        },
      );

      testWidgets(
        'can activate a text scale factor',
        (WidgetTester tester) async {
          await testAddon(
            tester: tester,
            addon: addon,
            act: () async => addon.onChanged(
              setting.copyWith(
                activeTextScale: 2,
              ),
            ),
            expect: (context) => expect(
              context.textScale,
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
              context.textScale,
              equals(2),
            ),
          );
        },
      );
    },
  );
}
