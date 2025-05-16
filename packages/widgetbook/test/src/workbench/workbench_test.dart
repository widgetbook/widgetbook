import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/workbench/workbench.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

void main() {
  group(
    '$Workbench',
    () {
      testWidgets(
        'given a home widget, '
        'then it is displayed when no use case is selected',
        (tester) async {
          final state = WidgetbookState(
            appBuilder: materialAppBuilder,
            home: const Placeholder(),
            root: WidgetbookRoot(
              children: [],
            ),
          );

          await tester.pumpWidgetWithState(
            state: state,
            builder: (_) => const Workbench(),
          );

          expect(
            find.byType(Placeholder),
            findsOne,
          );
        },
      );

      testWidgets(
        'given a home widget, '
        'then it is not displayed when a use case is selected',
        (tester) async {
          const useCaseName = 'use-case';
          final state = WidgetbookState(
            appBuilder: materialAppBuilder,
            home: const Placeholder(),
            path: useCaseName,
            root: WidgetbookRoot(
              children: [
                WidgetbookUseCase(
                  name: useCaseName,
                  builder: (context) => const Text(useCaseName),
                ),
              ],
            ),
          );

          await tester.pumpWidgetWithState(
            state: state,
            builder: (_) => const Workbench(),
          );

          await tester.pumpAndSettle();

          expect(
            find.byType(Placeholder),
            findsNothing,
          );

          expect(
            find.text(useCaseName),
            findsOneWidget,
          );
        },
      );
    },
  );
}
