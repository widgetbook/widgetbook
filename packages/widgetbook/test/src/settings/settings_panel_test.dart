import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/settings/settings.dart';

import '../../helper/helper.dart';

void main() {
  group(
    '$SettingsPanel',
    () {
      const title = 'Panel Title';

      testWidgets(
        'given settings data has a name, '
        'then the name is displayed',
        (tester) async {
          await tester.pumpWidgetWithMaterialApp(
            SettingsPanel(
              settings: [
                SettingsPanelData(
                  name: title,
                  builder: (_) => [],
                ),
              ],
            ),
          );

          expect(
            find.text(title),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'given settings data is empty, '
        'then a hint about being empty is displayed',
        (tester) async {
          await tester.pumpWidgetWithMaterialApp(
            SettingsPanel(
              settings: [
                SettingsPanelData(
                  name: title,
                  builder: (_) => [],
                ),
              ],
            ),
          );

          expect(
            find.text('No $title available'),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'given settings data is not empty, '
        'then their widgets will be displayed',
        (tester) async {
          await tester.pumpWidgetWithMaterialApp(
            SettingsPanel(
              settings: [
                SettingsPanelData(
                  name: title,
                  builder: (_) => const [
                    Placeholder(),
                    Placeholder(),
                    Placeholder(),
                  ],
                ),
              ],
            ),
          );

          expect(
            find.byType(Placeholder),
            findsNWidgets(3),
          );
        },
      );
    },
  );
}
