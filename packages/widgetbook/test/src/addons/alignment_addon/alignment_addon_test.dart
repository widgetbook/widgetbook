import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../utils/addon_test_helper.dart';

void main() {
  group(
    '$AlignmentAddon',
    () {
      final addon = AlignmentAddon();

      testWidgets(
        'can activate alignment',
        (tester) async {
          await testAddon<Alignment>(
            tester: tester,
            addon: addon,
            act: () async {
              final dropdownFinder = find.byType(DropdownMenu<Alignment>);
              await tester.tap(dropdownFinder);
              await tester.pumpAndSettle();

              final textFinder = find.byWidgetPredicate(
                (widget) => widget is Text && widget.data == 'Top Left',
              );
              await tester.tap(textFinder.last);
              await tester.pumpAndSettle();
            },
            expect: (setting) => expect(
              setting,
              equals(Alignment.topLeft),
            ),
          );
        },
      );
    },
  );
}
