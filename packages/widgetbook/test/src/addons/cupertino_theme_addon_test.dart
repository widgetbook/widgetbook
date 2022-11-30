import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/theme_addon/theme_selection_provider.dart';
import 'package:widgetbook/src/workbench/renderer.dart';
import 'package:widgetbook/widgetbook.dart';

import 'utils/addons.dart';
import 'utils/cupertino_app_theme.dart';
import 'utils/custom_app_theme.dart';
import 'utils/theme_wrapper.dart';

void main() {
  late Renderer sut;
  final rendererKey = GlobalKey();

  setUp(() {
    sut = Renderer(
      key: rendererKey,
      appBuilder: cupertinoAppBuilder,
      useCaseBuilder: (context) => ColoredBox(
        key: coloredBoxKey,
        color: CupertinoTheme.of(context).primaryColor,
      ),
    );
  });

  group('$CupertinoThemeAddon', () {
    testWidgets(
      'renders the correct theme',
      (WidgetTester tester) async {
        await ensureCorrectThemeIsRendered<CupertinoThemeData>(
          tester: tester,
          sut: sut,
          addons: [
            cupertinoThemeAddon,
          ],
        );
      },
    );

    testWidgets(
      'renders theme side by side when 2 active themes are activated',
      (WidgetTester tester) async {
        await renderAddonSideBySide<CupertinoThemeData>(
          itemsCollection: coloredBoxColorList,
          expectedValues: <Color>[
            colorBlue,
            colorYellow,
          ],
          itemsKey: coloredBoxKey,
          tester: tester,
          sut: sut,
          addons: [
            CupertinoThemeAddon(
              themeSetting: cupertinoThemeSetting.copyWith(
                activeThemes: {
                  blueCupertinoWidgetbookTheme,
                  yellowCupertinoWidgetbookTheme
                },
              ),
            ),
          ],
        );
      },
    );

    testWidgets(
      'can activate yellowCupertinoWidgetbookTheme when $ThemeSettingProvider..tapped(yellowCupertinoWidgetbookTheme) is called',
      (WidgetTester tester) async {
        await renderAddonSideBySide<CupertinoThemeData>(
          itemsKey: coloredBoxKey,
          itemsCollection: coloredBoxColorList,
          tester: tester,
          sut: sut,
          addons: [
            cupertinoThemeAddon,
          ],
          shouldUpdate: true,
          updateAddon: (context) async =>
              context.read<ThemeSettingProvider<CupertinoThemeData>>().tapped(
                    yellowCupertinoWidgetbookTheme,
                  ),
          expectedValues: <Color>[
            colorBlue,
            colorYellow,
          ],
        );
      },
    );
    testWidgets(
      'can de-activate yellowCupertinoWidgetbookTheme when $ThemeSettingProvider..tapped(yellowCupertinoWidgetbookTheme) is called',
      (WidgetTester tester) async {
        await renderAddonSideBySide<AppThemeData>(
          itemsKey: coloredBoxKey,
          itemsCollection: coloredBoxColorList,
          tester: tester,
          sut: sut,
          addons: [
            CupertinoThemeAddon(
              themeSetting: cupertinoThemeSetting.copyWith(
                activeThemes: {
                  blueCupertinoWidgetbookTheme,
                  yellowCupertinoWidgetbookTheme
                },
              ),
            ),
          ],
          shouldUpdate: true,
          updateAddon: (context) async =>
              context.read<ThemeSettingProvider<CupertinoThemeData>>().tapped(
                    yellowCupertinoWidgetbookTheme,
                  ),
          expectedValues: <Color>[
            colorBlue,
          ],
        );
      },
    );
  });
}
