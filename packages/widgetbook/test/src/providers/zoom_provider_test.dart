import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/providers/zoom_provider.dart';
import 'package:widgetbook/src/providers/zoom_state.dart';
import '../../helper.dart';

void main() {
  group(
    '$ZoomProvider',
    () {
      testWidgets(
        'emits 1.25 when zoomIn is called',
        (WidgetTester tester) async {
          await tester.pumpWidgetWithMaterialApp(
            ZoomBuilder(
              child: Container(),
            ),
          );

          var themeProviderFinder = find.byType(ZoomProvider);
          expect(themeProviderFinder, findsOneWidget);

          var themeProvider =
              tester.firstWidget(themeProviderFinder) as ZoomProvider;

          themeProvider = await tester.invokeAndPumpProvider(() {
            themeProvider.zoomIn();
          });

          expect(
            themeProvider.state,
            equals(
              ZoomState(zoomLevel: 1.25),
            ),
          );
        },
      );

      testWidgets(
        'emits 0.75 when zoomOut is called',
        (WidgetTester tester) async {
          await tester.pumpWidgetWithMaterialApp(
            ZoomBuilder(
              child: Container(),
            ),
          );

          var themeProviderFinder = find.byType(ZoomProvider);
          expect(themeProviderFinder, findsOneWidget);

          var themeProvider =
              tester.firstWidget(themeProviderFinder) as ZoomProvider;

          themeProvider = await tester.invokeAndPumpProvider(() {
            themeProvider.zoomOut();
          });

          expect(
            themeProvider.state,
            equals(
              ZoomState(zoomLevel: 0.75),
            ),
          );
        },
      );

      testWidgets(
        'emits State.normal() when resetToNormal is called',
        (WidgetTester tester) async {
          await tester.pumpWidgetWithMaterialApp(
            ZoomBuilder(
              child: Container(),
            ),
          );

          var themeProviderFinder = find.byType(ZoomProvider);
          expect(themeProviderFinder, findsOneWidget);

          var themeProvider =
              tester.firstWidget(themeProviderFinder) as ZoomProvider;

          themeProvider = await tester.invokeAndPumpProvider(() {
            themeProvider.resetToNormal();
          });

          expect(
            themeProvider.state,
            equals(
              ZoomState.normal(),
            ),
          );
        },
      );

      group(
        'emits',
        () {
          double scaleToTest = 2.00;
          testWidgets(
            '$scaleToTest when setScale is called with scale = $scaleToTest',
            (WidgetTester tester) async {
              await tester.pumpWidgetWithMaterialApp(
                ZoomBuilder(
                  child: Container(),
                ),
              );

              var themeProviderFinder = find.byType(ZoomProvider);
              expect(themeProviderFinder, findsOneWidget);

              var themeProvider =
                  tester.firstWidget(themeProviderFinder) as ZoomProvider;

              themeProvider = await tester.invokeAndPumpProvider(() {
                themeProvider.setScale(scaleToTest);
              });

              expect(
                themeProvider.state,
                equals(
                  ZoomState(zoomLevel: scaleToTest),
                ),
              );
            },
          );
        },
      );

      testWidgets(
        '.of returns $ZoomProvider instance',
        (WidgetTester tester) async {
          await tester.pumpWidgetWithMaterialApp(
            ZoomBuilder(
              child: Container(),
            ),
          );

          final BuildContext context = tester.element(find.byType(Container));
          var themeProvider = ZoomProvider.of(context);
          expect(
            themeProvider,
            isNot(null),
          );
        },
      );

      testWidgets(
        '.state defaults to ZoomState.normal()',
        (WidgetTester tester) async {
          await tester.pumpWidgetWithMaterialApp(
            ZoomBuilder(
              child: Container(),
            ),
          );

          var themeProviderFinder = find.byType(ZoomProvider);
          expect(themeProviderFinder, findsOneWidget);

          var themeProvider =
              tester.firstWidget(themeProviderFinder) as ZoomProvider;

          expect(
            themeProvider.state,
            equals(
              ZoomState.normal(),
            ),
          );
        },
      );
    },
  );
}
