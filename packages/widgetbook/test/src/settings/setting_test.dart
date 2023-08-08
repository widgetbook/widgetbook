import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/settings/setting.dart';

import '../../helper/helper.dart';

void main() {
  group(
    '$Setting',
    () {
      const title = 'Frame';

      testWidgets(
        'given a setting name, '
        'then it is displayed',
        (tester) async {
          await tester.pumpWidgetWithMaterialApp(
            const Setting(
              name: title,
              child: SizedBox.shrink(),
            ),
          );

          expect(
            find.text(title),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'given a setting description, '
        'then it is displayed',
        (tester) async {
          const description = 'lorem ipusm';

          await tester.pumpWidgetWithMaterialApp(
            const Setting(
              name: title,
              description: description,
              child: SizedBox.shrink(),
            ),
          );

          expect(
            find.text(description),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'given a trailing widget, '
        'then it is displayed along with the name',
        (tester) async {
          await tester.pumpWidgetWithMaterialApp(
            const Setting(
              name: title,
              trailing: Placeholder(),
              child: SizedBox.shrink(),
            ),
          );

          expect(
            find.text(title),
            findsOneWidget,
          );

          expect(
            find.byType(Placeholder),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'given a child widget, '
        'then it is displayed',
        (tester) async {
          await tester.pumpWidgetWithMaterialApp(
            const Setting(
              name: title,
              child: Placeholder(),
            ),
          );

          expect(
            find.byType(Placeholder),
            findsOneWidget,
          );
        },
      );
    },
  );
}
