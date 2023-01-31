import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

import '../../../helper/widget_tester_extension.dart';

void main() {
  group(
    '$SettingHeader',
    () {
      const content = 'Frame';
      testWidgets(
        'content is shown',
        (tester) async {
          await tester.pumpWidgetWithMaterial(
            child: const SettingHeader(
              content: content,
            ),
          );

          final contentFinder = find.byWidgetPredicate(
            (widget) => widget is Text && widget.data == content,
          );

          expect(contentFinder, findsOneWidget);
        },
      );

      testWidgets(
        'content and trailing is shown',
        (tester) async {
          const key = ValueKey('Placeholder');
          await tester.pumpWidgetWithMaterial(
            child: const SettingHeader(
              content: content,
              trailing: Placeholder(
                key: key,
              ),
            ),
          );

          final contentFinder = find.byWidgetPredicate(
            (widget) => widget is Text && widget.data == content,
          );
          final trailingFinder = find.byKey(key);

          expect(contentFinder, findsOneWidget);
          expect(trailingFinder, findsOneWidget);
        },
      );
    },
  );
}
