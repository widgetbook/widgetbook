import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/settings/settings.dart';

import '../../helper/widget_test_helper.dart';

void main() {
  group(
    '$SettingsPanel',
    () {
      const content = 'Frames';
      testWidgets(
        'shows Tab and hint text',
        (tester) async {
          await tester.pumpWidgetWithMaterialApp(
            SettingsPanel(
              settings: [
                SettingsPanelData(
                  name: content,
                  builder: (_) => [],
                ),
              ],
            ),
          );

          final contentFinder = find.byWidgetPredicate(
            (widget) => widget is Text && widget.data == content,
          );
          final hintTextFinder = find.byWidgetPredicate(
            (widget) => widget is Text && widget.data == 'No Frames available',
          );

          expect(hintTextFinder, findsOneWidget);
          expect(contentFinder, findsOneWidget);
        },
      );

      testWidgets(
        'shows Tab and hint text',
        (tester) async {
          const widget = Text(
            'Text',
            key: ValueKey('Text'),
          );
          await tester.pumpWidgetWithMaterialApp(
            SettingsPanel(
              settings: [
                SettingsPanelData(
                  name: content,
                  builder: (_) => [
                    widget,
                  ],
                ),
              ],
            ),
          );

          final contentFinder = find.byWidgetPredicate(
            (widget) => widget is Text && widget.data == content,
          );
          final widgetFinder = find.byKey(
            widget.key!,
          );

          expect(widgetFinder, findsOneWidget);
          expect(contentFinder, findsOneWidget);
        },
      );
    },
  );
}
