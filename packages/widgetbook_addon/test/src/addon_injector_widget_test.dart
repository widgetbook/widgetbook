import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nested/nested.dart';
import 'package:widgetbook_addon/widgetbook_addon.dart';

import '../helper/custom_addon.dart';
import '../helper/widget_test_helper.dart';

void main() {
  group(
    '$AddonInjectorWidget',
    () {
      testWidgets(
        'returns child widget when addons are empty',
        (WidgetTester tester) async {
          await tester.pumpWidgetWithMaterialApp(
            AddonInjectorWidget(
              routerData: {},
              addons: [],
              child: Text('single child'),
            ),
          );

          final childFinder = find.descendant(
            of: find.byType(AddonInjectorWidget),
            matching: find.byType(Text),
          );

          expect(childFinder, findsOneWidget);
        },
      );

      testWidgets(
        'returns [Nested] widget when addons are available',
        (WidgetTester tester) async {
          await tester.pumpWidgetWithMaterialApp(
            AddonInjectorWidget(
              routerData: {},
              addons: [
                CustomAddOn(
                  setting: CustomAddOnSetting(
                    data: 'test',
                  ),
                )
              ],
              child: Text('single child'),
            ),
          );

          final nestedFinder = find.descendant(
            of: find.byType(AddonInjectorWidget),
            matching: find.byType(Nested),
          );

          final childFinder = find.descendant(
            of: find.byType(AddonInjectorWidget),
            matching: find.byType(Text),
          );

          expect(nestedFinder, findsOneWidget);
          expect(childFinder, findsOneWidget);
        },
      );
    },
  );
}
