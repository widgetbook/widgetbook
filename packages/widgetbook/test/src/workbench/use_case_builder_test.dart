import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/routing/app_router.dart';
import 'package:widgetbook/src/workbench/use_case_builder.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  group(
    '$UseCaseBuilder',
    () {
      testWidgets(
        'given a home widget, '
        'then it is not displayed when a use case is selected',
        (
          tester,
        ) async {
          tester.view.physicalSize = const Size(1200, 800);
          tester.view.devicePixelRatio = 1.0;

          const useCaseName = 'use-case';

          final state = WidgetbookState(
            appBuilder: materialAppBuilder,
            root: WidgetbookRoot(
              children: [
                WidgetbookUseCase(
                  name: useCaseName,
                  builder: (context) {
                    final enabled = context.knobs.boolean(
                      label: 'Enable',
                      initialValue: true,
                    );

                    if (enabled) {
                      context.knobs.stringOrNull(label: 'String property');
                    } else {
                      context.knobs.intOrNull.slider(label: 'Int property');
                    }
                    context.knobs.doubleOrNull.slider(label: 'Double property');

                    return const Text('Test');
                  },
                ),
              ],
            ),
          );

          final router = AppRouter(
            state: state,
            uri: Uri.parse('/?path=$useCaseName'),
          );
          await tester.pumpWidget(
            WidgetbookScope(
              state: state,
              child: MaterialApp.router(routerConfig: router),
            ),
          );
          await tester.pumpAndSettle();
          expect(find.text('Test'), findsOneWidget);
          final context = tester.element(find.text('Test'));

          /// Verify knobs
          expect(find.text('Enable'), findsOneWidget);
          expect(find.text('String property'), findsOneWidget);
          expect(find.text('Int property'), findsNothing);
          expect(find.text('Double property'), findsOneWidget);

          /// Disable boolean knob
          WidgetbookState.of(
            context,
          ).updateQueryParam('knobs', '{Enable:false}');
          await tester.pumpAndSettle();

          /// Verify knobs again
          expect(find.text('Enable'), findsOneWidget);
          expect(find.text('String property'), findsNothing);
          expect(find.text('Int property'), findsOneWidget);
          expect(find.text('Double property'), findsOneWidget);

          addTearDown(tester.view.resetPhysicalSize);
          addTearDown(tester.view.resetDevicePixelRatio);
        },
      );
    },
  );
}
