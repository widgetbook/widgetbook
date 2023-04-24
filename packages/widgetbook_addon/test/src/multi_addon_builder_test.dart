import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nested/nested.dart';
import 'package:widgetbook_addon/widgetbook_addon.dart';

import '../helper/custom_addon.dart';
import '../helper/widget_test_helper.dart';

void main() {
  group(
    '$MultiAddonBuilder',
    () {
      testWidgets(
        'returns child widget when addons are empty',
        (WidgetTester tester) async {
          await tester.pumpWidgetWithMaterialApp(
            MultiAddonBuilder(
              addons: [],
              onChanged: (_) {},
              builder: (_, __, ___) => Text('stub'),
              child: Text('single child'),
            ),
          );

          final childFinder = find.descendant(
            of: find.byType(MultiAddonBuilder),
            matching: find.byType(Text),
          );

          expect(childFinder, findsOneWidget);
        },
      );

      testWidgets(
        'returns [Nested] widget when addons are available',
        (WidgetTester tester) async {
          await tester.pumpWidgetWithMaterialApp(
            MultiAddonBuilder(
              addons: [
                CustomAddOn(
                  setting: CustomAddOnSetting(
                    data: 'test',
                  ),
                )
              ],
              onChanged: (_) {},
              builder: (_, __, ___) => Text('stub'),
              child: Text('single child'),
            ),
          );

          final nestedFinder = find.descendant(
            of: find.byType(MultiAddonBuilder),
            matching: find.byType(Nested),
          );

          final childFinder = find.descendant(
            of: find.byType(MultiAddonBuilder),
            matching: find.byType(Text),
          );

          expect(nestedFinder, findsOneWidget);
          expect(childFinder, findsOneWidget);
        },
      );
    },
  );
}
