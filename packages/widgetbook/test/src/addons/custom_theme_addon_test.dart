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
import 'utils/theme_wrapper.dart';

Widget customThemeAddonWrapper({
  required Widget child,
  WidgetbookTheme<AppThemeData>? activeTheme,
}) {
  return addOnProviderWrapper<dynamic>(
    child: child,
    addons: [
      CustomThemeAddon<AppThemeData>(
        setting: customThemeSetting.copyWith(
          activeTheme: activeTheme,
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
      appBuilder: (context, child) {
        final theme = context.theme<AppThemeData>();
        return AppTheme(
          data: theme!,
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
    testWidgets(
      'renders the correct theme',
      (WidgetTester tester) async {
        await ensureCorrectThemeIsRendered<AppThemeData>(
          tester: tester,
          sut: renderer,
          addons: [
            customThemeAddon,
          ],
        );
      },
    );

    testWidgets(
      'renders with 1 active theme',
      (WidgetTester tester) async {
        await testAddon(
          tester: tester,
          build: (child) => customThemeAddonWrapper(
            child: child,
            activeTheme: blueCustomWidgetbookTheme,
          ),
          child: renderer,
          expect: () {
            final context = tester.findContextByKey(coloredBoxKey);

            final coloredBoxFromContext =
                context.read<ThemeSettingProvider<AppThemeData>>();
            expect(
              coloredBoxFromContext.value.activeTheme,
              equals(blueCustomWidgetbookTheme),
            );

            expectThemeColor(colorData: colorBlue);
          },
        );
      },
    );
    testWidgets(
      'can activate yellowCustomWidgetbookTheme when $ThemeSettingProvider..tapped(yellowCustomWidgetbookTheme) is called',
      (WidgetTester tester) async {
        await testAddon(
          tester: tester,
          build: (child) => customThemeAddonWrapper(
            child: child,
            activeTheme: blueCustomWidgetbookTheme,
          ),
          child: renderer,
          act: (context) async => context
              .read<ThemeSettingProvider<AppThemeData>>()
              .tapped(yellowCustomWidgetbookTheme),
          expect: () {
            final context = tester.findContextByKey(coloredBoxKey);

            final coloredBoxFromContext =
                context.read<ThemeSettingProvider<AppThemeData>>();
            expect(
              coloredBoxFromContext.value.activeTheme,
              equals(yellowCustomWidgetbookTheme),
            );

            expectThemeColor(colorData: colorYellow);
          },
        );
      },
    );
    testWidgets(
      'activates theme in order',
      (WidgetTester tester) async {
        await testAddon(
          tester: tester,
          build: (child) => customThemeAddonWrapper(
            child: child,
            activeTheme: blueCustomWidgetbookTheme,
          ),
          child: renderer,
          act: (context) async =>
              context.read<ThemeSettingProvider<AppThemeData>>()
                ..tapped(yellowCustomWidgetbookTheme)
                ..tapped(blueCustomWidgetbookTheme),
          expect: () {
            final context = tester.findContextByKey(coloredBoxKey);

            final coloredBoxFromContext =
                context.read<ThemeSettingProvider<AppThemeData>>();
            expect(
              coloredBoxFromContext.value.activeTheme,
              equals(blueCustomWidgetbookTheme),
            );

            expectThemeColor(colorData: colorBlue);
          },
        );
      },
    );
  });
}
