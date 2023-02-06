import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

import '../../../helper/widget_tester_extension.dart';

void main() {
  group(
    '$SettingGroup',
    () {
      testWidgets(
        'has $Divider when 2 Settings are present',
        (tester) async {
          const key1 = ValueKey('Key 1');
          const key2 = ValueKey('Key 2');
          await tester.pumpWidgetWithMaterial(
            child: const SettingGroup(
              settings: [
                Text(
                  'Text 1',
                  key: key1,
                ),
                Text(
                  'Text 2',
                  key: key2,
                ),
              ],
            ),
          );

          final text1Finder = find.byKey(key1);
          final text2Finder = find.byKey(key2);
          final dividerFinder = find.byType(Divider);

          expect(text1Finder, findsOneWidget);
          expect(text2Finder, findsOneWidget);
          expect(dividerFinder, findsOneWidget);
        },
      );

      testWidgets(
        'has no $Divider when no Settings are present',
        (tester) async {
          await tester.pumpWidgetWithMaterial(
            child: const SettingGroup(
              settings: [],
            ),
          );

          final dividerFinder = find.byType(Divider);

          expect(dividerFinder, findsNothing);
        },
      );
    },
  );
}
