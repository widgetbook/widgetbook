import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

import '../../../helper/widget_tester_extension.dart';

void main() {
  group(
    '$SettingsPanel',
    () {
      const content = 'Frames';
      testWidgets(
        'shows Tab and hint text',
        (tester) async {
          await tester.pumpWidgetWithMaterial(
            child: SettingsPanel(
              settings: [
                SettingsPanelData(name: content, settings: const []),
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
          await tester.pumpWidgetWithMaterial(
            child: SettingsPanel(
              settings: [
                SettingsPanelData(
                  name: content,
                  settings: const [
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
