import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/theme_addon/theme_selection_provider.dart';
import 'package:widgetbook/src/workbench/renderer.dart';
import 'package:widgetbook/widgetbook.dart';

import 'utils/addons.dart';
import 'utils/custom_app_theme.dart';
import 'utils/material_app_theme.dart';
import 'utils/theme_wrapper.dart';

void main() {
  late Renderer sut;
  final rendererKey = GlobalKey();

  setUp(() {
    sut = Renderer(
      key: rendererKey,
      appBuilder: materialAppBuilder,
      useCaseBuilder: (context) => ColoredBox(
        key: coloredBoxKey,
        color: Theme.of(context).primaryColor,
      ),
    );
  });

  group('$MaterialThemeAddon', () {
    testWidgets(
      'renders the correct theme',
      (WidgetTester tester) async {
        await ensureCorrectThemeIsRendered<ThemeData>(
          tester: tester,
          sut: sut,
          addons: [
            materialThemeAddon,
          ],
        );
      },
    );

    testWidgets(
      'renders theme side by side when 2 active themes are activated',
      (WidgetTester tester) async {
        await renderAddonSideBySide<ThemeData>(
          itemsCollection: coloredBoxColorList,
          expectedValues: <Color>[
            colorBlue,
            colorYellow,
          ],
          itemsKey: coloredBoxKey,
          tester: tester,
          sut: sut,
          addons: [
            MaterialThemeAddon(
              themeSetting: materialThemeSetting.copyWith(
                activeThemes: {
                  blueMaterialWidgetbookTheme,
                  yellowMaterialWidgetbookTheme
                },
              ),
            ),
          ],
        );
      },
    );

    testWidgets(
      'can activate yellowMaterialWidgetbookTheme when $ThemeSettingProvider..tapped(yellowMaterialWidgetbookTheme) is called',
      (WidgetTester tester) async {
        await renderAddonSideBySide<ThemeData>(
          itemsKey: coloredBoxKey,
          itemsCollection: coloredBoxColorList,
          tester: tester,
          sut: sut,
          addons: [
            materialThemeAddon,
          ],
          shouldUpdate: true,
          updateAddon: (context) async =>
              context.read<ThemeSettingProvider<ThemeData>>().tapped(
                    yellowMaterialWidgetbookTheme,
                  ),
          expectedValues: <Color>[
            colorBlue,
            colorYellow,
          ],
        );
      },
    );
    testWidgets(
      'can de-activate yellowMaterialWidgetbookTheme when $ThemeSettingProvider..tapped(yellowMaterialWidgetbookTheme) is called',
      (WidgetTester tester) async {
        await renderAddonSideBySide<ThemeData>(
          itemsKey: coloredBoxKey,
          itemsCollection: coloredBoxColorList,
          tester: tester,
          sut: sut,
          addons: [
            MaterialThemeAddon(
              themeSetting: materialThemeSetting.copyWith(
                activeThemes: {
                  blueMaterialWidgetbookTheme,
                  yellowMaterialWidgetbookTheme
                },
              ),
            ),
          ],
          shouldUpdate: true,
          updateAddon: (context) async =>
              context.read<ThemeSettingProvider<ThemeData>>().tapped(
                    yellowMaterialWidgetbookTheme,
                  ),
          expectedValues: <Color>[
            colorBlue,
          ],
        );
      },
    );
  });
}
