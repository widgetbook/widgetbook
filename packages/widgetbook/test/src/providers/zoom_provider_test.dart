import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/providers/zoom_provider.dart';
import 'package:widgetbook/src/providers/zoom_state.dart';
import '../../helper/provider_helper.dart';
import '../../helper/widget_test_helper.dart';

extension _WidgetTesterProviderExtension on WidgetTester {
  Future<ZoomProvider> pumpProvider() async {
    final provider = await pumpBuilderAndReturnProvider<ZoomProvider>(
      ZoomBuilder(
        child: Container(),
      ),
    );
    return provider;
  }
}

void main() {
  group(
    '$ZoomProvider',
    () {
      testWidgets(
        'emits 1.25 when zoomIn is called',
        (WidgetTester tester) async {
          var provider = await tester.pumpProvider();

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
          var provider = await tester.pumpProvider();

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
          var provider = await tester.pumpProvider();

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
          const scaleToTest = 2.00;
          testWidgets(
            '$scaleToTest when setScale is called with scale = $scaleToTest',
            (WidgetTester tester) async {
              var provider = await tester.pumpProvider();

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
          final provider = ZoomProvider.of(context);
          expect(
            provider,
            isNot(null),
          );
        },
      );

      testWidgets(
        '.state defaults to ZoomState.normal()',
        (WidgetTester tester) async {
          final provider = await tester.pumpProvider();

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
