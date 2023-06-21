import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../../helper/matchers.dart';
import '../utils/addon_test_helper.dart';

void main() {
  group(
    '$TextScaleAddon',
    () {
      test(
        'throws assertion if scales are empty',
        () {
          expect(
            () => TextScaleAddon(
              scales: [],
            ),
            throwsAssertion('scales cannot be empty'),
          );
        },
      );

      testWidgets(
        'can activate text scale factor',
        (tester) async {
          final addon = TextScaleAddon(
            scales: [1.0, 2.0, 3.0],
          );

          await testAddon<double>(
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
            expect: (setting) => expect(
              setting,
              equals(2),
            ),
          );
        },
      );
    },
  );
}
