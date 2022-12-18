import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/text_scale_addon/text_scale_provider.dart';
import 'package:widgetbook/src/addons/text_scale_addon/text_scale_selection_provider.dart';
import 'package:widgetbook/src/workbench/renderer.dart';
import 'package:widgetbook/widgetbook.dart';

import '../utils/addon_test_helper.dart';
import '../utils/addons.dart';
import '../utils/extensions/widget_tester_extension.dart';
import '../utils/theme_wrapper.dart';

Widget textScaleAddonWrapper({
  required Widget child,
  required List<double> textScales,
  double? activeTextScale,
}) {
  return addOnProviderWrapper<dynamic>(
    child: child,
    addons: [
      TextScaleAddon(
        setting: TextScaleSetting(
          activeTextScale: activeTextScale ?? textScales.first,
          textScales: textScales,
        ),
      )
    ],
  );
}

void main() {
  late Renderer renderer;
  final rendererKey = GlobalKey();
  const mediaQueryKey = Key('MediaQuery');

  setUp(() {
    renderer = Renderer(
      key: rendererKey,
      appBuilder: (context, child) {
        return MediaQuery(
          key: mediaQueryKey,
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: context.textScale,
          ),
          child: child,
        );
      },
      useCaseBuilder: (context) => Text(
        'Text scale factor',
        key: textKey,
        textScaleFactor: MediaQuery.of(context).textScaleFactor,
      ),
    );
  });

  group('$TextScaleAddon', () {
    testWidgets(
      'can access text scale factor via the context',
      (WidgetTester tester) async {
        await testAddon(
          tester: tester,
          build: (child) => textScaleAddonWrapper(
            child: child,
            textScales: [1, 2],
            activeTextScale: 1,
          ),
          child: renderer,
          expect: () {
            final context = tester.findContextByKey(textKey);

            // Check if provider has expected text scale
            final scaleFactor = context.read<TextScaleProvider>();
            expect(scaleFactor.value, 1);

            expectTextScale(textScales: 1);

            // Check if media query has expected text scale
            final mediaQueryFinder = find.byKey(mediaQueryKey);
            final mediaQuery =
                mediaQueryFinder.evaluate().last.widget as MediaQuery;
            expect(mediaQuery.data.textScaleFactor, equals(1));
          },
        );
      },
    );

    testWidgets(
      'can activate a text scale factor',
      (WidgetTester tester) async {
        await testAddon(
          tester: tester,
          build: (child) => textScaleAddonWrapper(
            child: child,
            textScales: [1, 2],
            activeTextScale: 1,
          ),
          child: renderer,
          act: (context) async =>
              context.read<TextScaleSettingProvider>().tapped(2),
          expect: () => expectTextScale(
            textScales: 2,
          ),
        );
      },
    );

    testWidgets(
      'activates text scale factor in order',
      (WidgetTester tester) async {
        await testAddon(
          tester: tester,
          child: renderer,
          build: (child) => textScaleAddonWrapper(
            child: child,
            textScales: [1, 2, 3],
            activeTextScale: 1,
          ),
          act: (context) async {
            context.read<TextScaleSettingProvider>()
              ..tapped(3)
              ..tapped(2);
          },
          expect: () => expectTextScale(
            textScales: 2,
          ),
        );
      },
    );
  });
}
