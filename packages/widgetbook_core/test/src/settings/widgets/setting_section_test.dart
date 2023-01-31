import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

import '../../../helper/widget_tester_extension.dart';

void main() {
  group(
    '$SettingSection',
    () {
      const content = 'Frame';
      testWidgets(
        'shows content and settings',
        (tester) async {
          const key1 = ValueKey('Key 1');
          const key2 = ValueKey('Key 2');
          await tester.pumpWidgetWithMaterial(
            child: SettingSection(
              data: SettingSectionData(
                name: content,
                settings: [
                  const Text(
                    'Text 1',
                    key: key1,
                  ),
                  const Text(
                    'Text 2',
                    key: key2,
                  ),
                ],
              ),
            ),
          );

          final text1Finder = find.byKey(key1);
          final text2Finder = find.byKey(key2);
          final contentFinder = find.byWidgetPredicate(
            (widget) => widget is Text && widget.data == content,
          );

          expect(text1Finder, findsOneWidget);
          expect(text2Finder, findsOneWidget);
          expect(contentFinder, findsOneWidget);
        },
      );
    },
  );
}
