import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

import '../../../helper/widget_tester_extension.dart';

void main() {
  group(
    '$ComplexSetting',
    () {
      const content = 'Frame';
      testWidgets(
        'shows sections',
        (tester) async {
          const widget = Text(
            'Text',
            key: ValueKey('Text'),
          );
          const key1 = ValueKey('Key 1');
          const key2 = ValueKey('Key 2');
          await tester.pumpWidgetWithMaterial(
            child: ComplexSetting(
              name: 'Frame',
              setting: widget,
              sections: [
                SettingSectionData(
                  name: 'Section 1',
                  settings: [
                    const Text(
                      'Text 1',
                      key: key1,
                    ),
                  ],
                ),
                SettingSectionData(
                  name: 'Section 2',
                  settings: [
                    const Text(
                      'Text 2',
                      key: key2,
                    ),
                  ],
                ),
              ],
            ),
          );

          final text1Finder = find.byKey(key1);
          final text2Finder = find.byKey(key2);
          final frameTextFinder = find.byWidgetPredicate(
            (widget) => widget is Text && widget.data == 'Frame',
          );
          final section1Finder = find.byWidgetPredicate(
            (widget) => widget is Text && widget.data == 'Section 1',
          );
          final section2Finder = find.byWidgetPredicate(
            (widget) => widget is Text && widget.data == 'Section 2',
          );
          final contentFinder = find.byWidgetPredicate(
            (widget) => widget is Text && widget.data == content,
          );

          expect(frameTextFinder, findsOneWidget);
          expect(section1Finder, findsOneWidget);
          expect(section2Finder, findsOneWidget);
          expect(text1Finder, findsOneWidget);
          expect(text2Finder, findsOneWidget);
          expect(contentFinder, findsOneWidget);
        },
      );

      testWidgets(
        'shows no sections',
        (tester) async {
          const widget = Text(
            'Text',
            key: ValueKey('Text'),
          );

          await tester.pumpWidgetWithMaterial(
            child: const ComplexSetting(
              name: 'Frame',
              setting: widget,
            ),
          );

          final frameTextFinder = find.byWidgetPredicate(
            (widget) => widget is Text && widget.data == 'Frame',
          );

          final contentFinder = find.byWidgetPredicate(
            (widget) => widget is Text && widget.data == content,
          );

          expect(frameTextFinder, findsOneWidget);
          expect(contentFinder, findsOneWidget);
        },
      );
    },
  );
}
