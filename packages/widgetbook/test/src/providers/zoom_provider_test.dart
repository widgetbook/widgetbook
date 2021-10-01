import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/providers/zoom_provider.dart';
import 'package:widgetbook/src/providers/zoom_state.dart';
import '../../helper.dart';

extension _WidgetTesterProviderExtension on WidgetTester {
  Future<ZoomProvider> pumpProvider() async {
    ZoomProvider themeProvider = await this.pumpBuilderAndReturnProvider(
      ZoomBuilder(
        child: Container(),
      ),
    );
    return themeProvider;
  }
}

void main() {
  group(
    '$ZoomProvider',
    () {
      testWidgets(
        'emits 1.25 when zoomIn is called',
        (WidgetTester tester) async {
          ZoomProvider provider = await tester.pumpProvider();

          provider = await tester.invokeMethodAndReturnPumpedProvider(() {
            provider.zoomIn();
          });

          expect(
            provider.state,
            equals(
              ZoomState(zoomLevel: 1.25),
            ),
          );
        },
      );

      testWidgets(
        'emits 0.75 when zoomOut is called',
        (WidgetTester tester) async {
          ZoomProvider provider = await tester.pumpProvider();

          provider = await tester.invokeMethodAndReturnPumpedProvider(() {
            provider.zoomOut();
          });

          expect(
            provider.state,
            equals(
              ZoomState(zoomLevel: 0.75),
            ),
          );
        },
      );

      testWidgets(
        'emits State.normal() when resetToNormal is called',
        (WidgetTester tester) async {
          ZoomProvider provider = await tester.pumpProvider();

          provider = await tester.invokeMethodAndReturnPumpedProvider(() {
            provider.resetToNormal();
          });

          expect(
            provider.state,
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
              ZoomProvider provider = await tester.pumpProvider();

              provider = await tester.invokeMethodAndReturnPumpedProvider(() {
                provider.setScale(scaleToTest);
              });

              expect(
                provider.state,
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
          ZoomProvider provider = await tester.pumpProvider();

          expect(
            provider.state,
            equals(
              ZoomState.normal(),
            ),
          );
        },
      );
    },
  );
}
