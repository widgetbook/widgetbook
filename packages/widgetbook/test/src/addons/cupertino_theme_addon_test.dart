import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/theme_addon/theme_selection_provider.dart';
import 'package:widgetbook/src/workbench/renderer.dart';
import 'package:widgetbook/widgetbook.dart';

import 'utils/addon_test_helper.dart';
import 'utils/addons.dart';
import 'utils/cupertino_app_theme.dart';
import 'utils/custom_app_theme.dart';
import 'utils/extensions/widget_tester_extension.dart';
import 'utils/theme_wrapper.dart';

Widget cupertinoThemeAddonWrapper({
  required Widget child,
  WidgetbookTheme<CupertinoThemeData>? activeTheme,
}) {
  return addOnProviderWrapper<dynamic>(
    child: child,
    addons: [
      CupertinoThemeAddon(
        setting: cupertinoThemeSetting.copyWith(
          activeTheme: blueCupertinoWidgetbookTheme,
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
          sut: renderer,
          addons: [
            cupertinoThemeAddon,
          ],
        );
      },
    );

    testWidgets(
      'renders with 1 active theme',
      (WidgetTester tester) async {
        await testAddon(
          tester: tester,
          build: (child) => cupertinoThemeAddonWrapper(
            child: child,
            activeTheme: blueCupertinoWidgetbookTheme,
          ),
          child: renderer,
          expect: () {
            final context = tester.findContextByKey(coloredBoxKey);

            final coloredBoxFromContext =
                context.read<ThemeSettingProvider<CupertinoThemeData>>();
            expect(
              coloredBoxFromContext.value.activeTheme,
              equals(blueCupertinoWidgetbookTheme),
            );

            expectThemeColor(colorData: colorBlue);
          },
        );
      },
    );

    testWidgets(
      'can activate yellowCupertinoWidgetbookTheme when $ThemeSettingProvider..tapped(yellowCupertinoWidgetbookTheme) is called',
      (WidgetTester tester) async {
        await testAddon(
          tester: tester,
          build: (child) => cupertinoThemeAddonWrapper(
            child: child,
            activeTheme: blueCupertinoWidgetbookTheme,
          ),
          child: renderer,
          act: (context) async => context
              .read<ThemeSettingProvider<CupertinoThemeData>>()
              .tapped(yellowCupertinoWidgetbookTheme),
          expect: () {
            final context = tester.findContextByKey(coloredBoxKey);

            final coloredBoxFromContext =
                context.read<ThemeSettingProvider<CupertinoThemeData>>();
            expect(
              coloredBoxFromContext.value.activeTheme,
              equals(yellowCupertinoWidgetbookTheme),
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
          build: (child) => cupertinoThemeAddonWrapper(
            child: child,
            activeTheme: blueCupertinoWidgetbookTheme,
          ),
          child: renderer,
          act: (context) async =>
              context.read<ThemeSettingProvider<CupertinoThemeData>>()
                ..tapped(yellowCupertinoWidgetbookTheme)
                ..tapped(blueCupertinoWidgetbookTheme),
          expect: () {
            final context = tester.findContextByKey(coloredBoxKey);

            final coloredBoxFromContext =
                context.read<ThemeSettingProvider<CupertinoThemeData>>();
            expect(
              coloredBoxFromContext.value.activeTheme,
              equals(blueCupertinoWidgetbookTheme),
            );

            expectThemeColor(colorData: colorBlue);
          },
        );
      },
    );
  });
}
