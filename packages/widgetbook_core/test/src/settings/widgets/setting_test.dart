import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

import '../../../helper/widget_tester_extension.dart';

void main() {
  group(
    '$Setting',
    () {
      const content = 'Frame';
      const textWidget = Text(
        'Text',
        key: ValueKey('Text'),
      );
      testWidgets(
        'content is shown',
        (tester) async {
          await tester.pumpWidgetWithMaterial(
            child: const Setting(
              name: content,
              child: textWidget,
            ),
          );

          final contentFinder = find.byWidgetPredicate(
            (widget) => widget is Text && widget.data == content,
          );
          final widgetFinder = find.byKey(textWidget.key!);

          expect(contentFinder, findsOneWidget);
          expect(widgetFinder, findsOneWidget);
        },
      );

      testWidgets(
        'content and trailing is shown',
        (tester) async {
          const key = ValueKey('Placeholder');
          await tester.pumpWidgetWithMaterial(
            child: const Setting(
              name: content,
              trailing: Placeholder(
                key: key,
              ),
              child: textWidget,
            ),
          );

          final contentFinder = find.byWidgetPredicate(
            (widget) => widget is Text && widget.data == content,
          );
          final widgetFinder = find.byKey(textWidget.key!);
          final trailingFinder = find.byKey(key);

          expect(contentFinder, findsOneWidget);
          expect(trailingFinder, findsOneWidget);
          expect(widgetFinder, findsOneWidget);
        },
      );
    },
  );
}
