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

void expectSideBySideTextScales({
  required List<double> textScales,
}) {
  final textFinder = find.byKey(textKey);

  final currentTextScales = textFinder.evaluate().map((e) {
    final text = e.widget as Text;
    return text.textScaleFactor;
  }).toList();

  expect(
    currentTextScales,
    equals(
      textScales,
    ),
  );
}

Widget textScaleAddonWrapper({
  required Widget child,
  required List<double> textScales,
  Set<double>? activeTextScales,
}) {
  return addOnProviderWrapper<dynamic>(
    child: child,
    addons: [
      TextScaleAddon(
        setting: TextScaleSetting(
          activeTextScales: activeTextScales ?? textScales.toSet(),
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
            activeTextScales: {1},
          ),
          child: renderer,
          expect: () {
            final context = tester.findContextByKey(textKey);

            // Check if provider has expected text scale
            final scaleFactor = context.read<TextScaleProvider>();
            expect(scaleFactor.value, 1);

            expectSideBySideTextScales(textScales: [1]);

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
      'renders text scale factor side by side when 2 text scale factor are activated',
      (WidgetTester tester) async {
        await testAddon(
          tester: tester,
          build: (child) => textScaleAddonWrapper(
            child: child,
            textScales: [1, 2],
            activeTextScales: {1},
          ),
          child: renderer,
          act: (context) async =>
              context.read<TextScaleSettingProvider>().tapped(2),
          expect: () => expectSideBySideTextScales(
            textScales: [1, 2],
          ),
        );
      },
    );

    testWidgets(
      'can set textScaleFactor 2 when $TextScaleSettingProvider..tapped(2) is called',
      (WidgetTester tester) async {
        await testAddon(
          tester: tester,
          build: (child) => textScaleAddonWrapper(
            child: child,
            textScales: [1, 2],
            activeTextScales: {1},
          ),
          child: renderer,
          act: (context) async =>
              context.read<TextScaleSettingProvider>().tapped(2),
          expect: () => expectSideBySideTextScales(
            textScales: [1, 2],
          ),
        );
      },
    );

    testWidgets(
      'can de-activate textScaleFactor 2 when $TextScaleSettingProvider..tapped(2) is called',
      (WidgetTester tester) async {
        await testAddon(
          tester: tester,
          child: renderer,
          build: (child) => textScaleAddonWrapper(
            child: child,
            textScales: [1, 2],
          ),
          act: (context) async =>
              context.read<TextScaleSettingProvider>().tapped(2),
          expect: () => expectSideBySideTextScales(
            textScales: [1],
          ),
        );
      },
    );

    testWidgets(
      'activates in order',
      (WidgetTester tester) async {
        await testAddon(
          tester: tester,
          child: renderer,
          build: (child) => textScaleAddonWrapper(
            child: child,
            textScales: [1, 2, 3],
            activeTextScales: {
              1,
            },
          ),
          act: (context) async {
            context.read<TextScaleSettingProvider>()
              ..tapped(3)
              ..tapped(2);
          },
          expect: () => expectSideBySideTextScales(
            textScales: [1, 2, 3],
          ),
        );
      },
    );

    testWidgets(
      'can set textScaleFactor 2 when $TextScaleSettingProvider..tapped(2) is called',
      (WidgetTester tester) async {
        await renderAddonSideBySide<dynamic>(
          itemsCollection: textDoubleList,
          expectedValues: <double>[
            1,
            2,
            3,
          ],
          itemsKey: textKey,
          tester: tester,
          sut: renderer,
          shouldUpdate: true,
          updateAddon: (context) async {
            context.read<TextScaleSettingProvider>().tapped(
                  3,
                );
            context.read<TextScaleSettingProvider>().tapped(
                  2,
                );
          },
          addons: [
            TextScaleAddon(
              setting: TextScaleSetting(
                activeTextScales: {1},
                textScales: [
                  1,
                  2,
                  3,
                ],
              ),
            ),
          ],
        );
      },
    );
  });
}
