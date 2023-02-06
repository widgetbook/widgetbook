import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/theme_addon/theme_selection_provider.dart';
import 'package:widgetbook/src/workbench/renderer.dart';
import 'package:widgetbook/widgetbook.dart';

import 'utils/addon_test_helper.dart';
import 'utils/addons.dart';
import 'utils/custom_app_theme.dart';
import 'utils/extensions/widget_tester_extension.dart';
import 'utils/material_app_theme.dart';
import 'utils/theme_wrapper.dart';

Widget materialThemeAddonWrapper({
  required Widget child,
  WidgetbookTheme<ThemeData>? activeTheme,
}) {
  return addOnProviderWrapper<dynamic>(
    child: child,
    addons: [
      MaterialThemeAddon(
        setting: materialThemeSetting.copyWith(
          activeTheme: blueMaterialWidgetbookTheme,
        ),
      ),
    ],
  );
}

void main() {
  late Renderer renderer;
  final rendererKey = GlobalKey();

  setUp(() {
    renderer = Renderer(
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
          sut: renderer,
          addons: [
            materialThemeAddon,
          ],
        );
      },
    );

    testWidgets(
      'renders with 1 active theme',
      (WidgetTester tester) async {
        await testAddon(
          tester: tester,
          build: (child) => materialThemeAddonWrapper(
            child: child,
            activeTheme: blueMaterialWidgetbookTheme,
          ),
          child: renderer,
          expect: () {
            final context = tester.findContextByKey(coloredBoxKey);

            final coloredBoxFromContext =
                context.read<ThemeSettingProvider<ThemeData>>();
            expect(
              coloredBoxFromContext.value.activeTheme,
              equals(blueMaterialWidgetbookTheme),
            );

            expectThemeColor(colorData: colorBlue);
          },
        );
      },
    );

    testWidgets(
      'can activate yellowMaterialWidgetbookTheme when $ThemeSettingProvider..tapped(yellowMaterialWidgetbookTheme) is called',
      (WidgetTester tester) async {
        await testAddon(
          tester: tester,
          build: (child) => materialThemeAddonWrapper(
            child: child,
            activeTheme: blueMaterialWidgetbookTheme,
          ),
          child: renderer,
          act: (context) async => context
              .read<ThemeSettingProvider<ThemeData>>()
              .tapped(yellowMaterialWidgetbookTheme),
          expect: () {
            final context = tester.findContextByKey(coloredBoxKey);

            final coloredBoxFromContext =
                context.read<ThemeSettingProvider<ThemeData>>();
            expect(
              coloredBoxFromContext.value.activeTheme,
              equals(yellowMaterialWidgetbookTheme),
            );

            expectThemeColor(colorData: colorYellow);
          },
        );
      },
    );
    testWidgets(
      'can switch between themes when$ThemeSettingProvider..tapped(yellowMaterialWidgetbookTheme) is called',
      (WidgetTester tester) async {
        await testAddon(
          tester: tester,
          build: (child) => materialThemeAddonWrapper(
            child: child,
            activeTheme: blueMaterialWidgetbookTheme,
          ),
          child: renderer,
          act: (context) async =>
              context.read<ThemeSettingProvider<ThemeData>>()
                ..tapped(yellowMaterialWidgetbookTheme)
                ..tapped(blueMaterialWidgetbookTheme),
          expect: () {
            final context = tester.findContextByKey(coloredBoxKey);

            final coloredBoxFromContext =
                context.read<ThemeSettingProvider<ThemeData>>();
            expect(
              coloredBoxFromContext.value.activeTheme,
              equals(blueMaterialWidgetbookTheme),
            );

            expectThemeColor(colorData: colorBlue);
          },
        );
      },
    );
  });
}
