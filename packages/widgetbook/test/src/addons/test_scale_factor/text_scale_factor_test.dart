import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/text_scale_addon/text_scale_provider.dart';
import 'package:widgetbook/src/addons/text_scale_addon/text_scale_selection_provider.dart';
import 'package:widgetbook/src/workbench/renderer.dart';
import 'package:widgetbook/widgetbook.dart';

import '../utils/addons.dart';
import '../utils/custom_app_theme.dart';
import '../utils/theme_wrapper.dart';

void main() {
  late Renderer sut;
  final rendererKey = GlobalKey();
  const mediaQueryKey = Key('MediaQuery');

  setUp(() {
    sut = Renderer(
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
        await tester.pumpWidget(
          addOnProviderWrapper<AppThemeData>(
            child: sut,
            addons: [
              textScaleAddon,
            ],
          ),
        );
        await tester.pumpAndSettle();

        final BuildContext context = tester.element(
          find
              .byKey(
                textKey,
              )
              .first,
        );

        final scaleFactor = context.read<TextScaleProvider>();

        expect(scaleFactor.value, 1);

        final textFinder = find.byKey(textKey);

        expect(textFinder, findsOneWidget);
        final text = textFinder.evaluate().single.widget as Text;

        expect(text.textScaleFactor, equals(1));

        final mediaQueryFinder = find.byKey(mediaQueryKey);
        final mediaQuery =
            mediaQueryFinder.evaluate().last.widget as MediaQuery;

        expect(mediaQuery.data.textScaleFactor, equals(1));
      },
    );

    testWidgets(
      'renders text scale factor side by side when 2 text scale factor are activated',
      (WidgetTester tester) async {
        await renderAddonSideBySide<AppThemeData>(
          itemsCollection: textDoubleList,
          expectedValues: <double>[
            1,
            2,
          ],
          itemsKey: textKey,
          tester: tester,
          sut: sut,
          addons: [
            TextScaleAddon(
              setting: TextScaleSetting(
                activeTextScales: {1, 2},
                textScales: [
                  1,
                  2,
                ],
              ),
            ),
          ],
        );
      },
    );
    testWidgets(
      'can set textScaleFactor 2 when $TextScaleSettingProvider..tapped(2) is called',
      (WidgetTester tester) async {
        await renderAddonSideBySide<AppThemeData>(
          itemsCollection: textDoubleList,
          expectedValues: <double>[
            1,
            2,
          ],
          itemsKey: textKey,
          tester: tester,
          sut: sut,
          shouldUpdate: true,
          updateAddon: (context) async =>
              context.read<TextScaleSettingProvider>().tapped(
                    2,
                  ),
          addons: [
            TextScaleAddon(
              setting: TextScaleSetting(
                activeTextScales: {1},
                textScales: [
                  1,
                  2,
                ],
              ),
            ),
          ],
        );
      },
    );

    testWidgets(
      'can de-activate textScaleFactor 2 when $TextScaleSettingProvider..tapped(2) is called',
      (WidgetTester tester) async {
        await renderAddonSideBySide<AppThemeData>(
          itemsCollection: textDoubleList,
          expectedValues: <double>[
            1,
          ],
          itemsKey: textKey,
          tester: tester,
          sut: sut,
          shouldUpdate: true,
          updateAddon: (context) async =>
              context.read<TextScaleSettingProvider>().tapped(
                    2,
                  ),
          addons: [
            TextScaleAddon(
              setting: TextScaleSetting(
                activeTextScales: {1, 2},
                textScales: [
                  1,
                  2,
                ],
              ),
            ),
          ],
        );
      },
    );
  });
}
