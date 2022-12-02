import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/addons.dart';
import 'package:widgetbook/src/addons/theme_addon/theme_selection_provider.dart';
import 'package:widgetbook/src/workbench/renderer.dart';

import 'utils/addons.dart';
import 'utils/custom_app_theme.dart';
import 'utils/theme_wrapper.dart';

void main() {
  late Renderer sut;
  final rendererKey = GlobalKey();

  setUp(() {
    sut = Renderer(
      key: rendererKey,
      appBuilder: (context, child) {
        final theme = context.theme<AppThemeData>();
        return AppTheme(
          data: theme,
          child: child,
        );
      },
      useCaseBuilder: (context) => ColoredBox(
        key: coloredBoxKey,
        color: AppTheme.of(context).color,
      ),
    );
  });

  group('$CustomThemeAddon', () {
    // testWidgets(
    //   'renders the correct theme',
    //   (WidgetTester tester) async {
    //     await ensureCorrectThemeIsRendered<AppThemeData>(
    //       tester: tester,
    //       sut: sut,
    //       addons: [
    //         customThemeAddon,
    //       ],
    //     );
    //   },
    // );

    // testWidgets(
    //   'renders theme side by side when 2 active themes are activated',
    //   (WidgetTester tester) async {
    //     await renderAddonSideBySide<AppThemeData>(
    //       itemsCollection: coloredBoxColorList,
    //       expectedValues: <Color>[
    //         colorBlue,
    //         colorYellow,
    //       ],
    //       itemsKey: coloredBoxKey,
    //       tester: tester,
    //       sut: sut,
    //       addons: [
    //         CustomThemeAddon<AppThemeData>(
    //           themeSetting: customThemeSetting.copyWith(
    //             activeThemes: {
    //               blueCustomWidgetbookTheme,
    //               yellowCustomWidgetbookTheme
    //             },
    //           ),
    //         ),
    //       ],
    //     );
    //   },
    // );
    // testWidgets(
    //   'can activate yellowCustomWidgetbookTheme when $ThemeSettingProvider..tapped(yellowCustomWidgetbookThemeomTheme2) is called',
    //   (WidgetTester tester) async {
    //     await renderAddonSideBySide<AppThemeData>(
    //       itemsKey: coloredBoxKey,
    //       itemsCollection: coloredBoxColorList,
    //       tester: tester,
    //       sut: sut,
    //       addons: [
    //         customThemeAddon,
    //       ],
    //       shouldUpdate: true,
    //       updateAddon: (context) async =>
    //           context.read<ThemeSettingProvider<AppThemeData>>().tapped(
    //                 yellowCustomWidgetbookTheme,
    //               ),
    //       expectedValues: <Color>[
    //         colorBlue,
    //         colorYellow,
    //       ],
    //     );
    //   },
    // );
    testWidgets(
      'can de-activate yellowCustomWidgetbookTheme when $ThemeSettingProvider..tapped(yellowCustomWidgetbookTheme) is called',
      (WidgetTester tester) async {
        await renderAddonSideBySide<AppThemeData>(
          itemsKey: coloredBoxKey,
          itemsCollection: coloredBoxColorList,
          tester: tester,
          sut: sut,
          addons: [
            CustomThemeAddon<AppThemeData>(
              themeSetting: customThemeSetting.copyWith(
                activeThemes: {
                  blueCustomWidgetbookTheme,
                  yellowCustomWidgetbookTheme,
                  brownCustomWidgetbookTheme,
                },
              ),
            ),
          ],
          shouldUpdate: true,
          updateAddon: (context) async =>
              context.read<ThemeSettingProvider<AppThemeData>>().tapped(
                    yellowCustomWidgetbookTheme,
                  ),
          expectedValues: <Color>[
            colorBlue,
            colorBrown,
          ],
        );
      },
    );
  });
}
