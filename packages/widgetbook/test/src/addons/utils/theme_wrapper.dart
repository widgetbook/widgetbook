import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/addon.dart';
import 'package:widgetbook/src/addons/addon_injector_widget.dart';
import 'package:widgetbook/src/addons/addon_provider.dart';
import 'package:widgetbook/src/addons/theme_addon/theme_selection_provider.dart';
import 'package:widgetbook/widgetbook.dart';

import './addons.dart';
import 'custom_app_theme.dart';

Widget addOnProviderWrapper<T>({
  required Widget child,
  required List<WidgetbookAddOn> addons,
}) =>
    AddonInjectorWidget(
      addons: addons,
      routerData: const <String, dynamic>{},
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => AddOnProvider(
              addons,
            ),
          ),
        ],
        child: Builder(
          builder: (builder) => MediaQuery.fromWindow(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: child,
            ),
          ),
        ),
      ),
    );

ThemeSettingProvider<T> getThemeSettingProvider<T>(
  WidgetTester tester,
) {
  final BuildContext context = tester.element(
    // For the side by side view, we'll find multiple ColoredBoxes
    // However, since we are just aiming to get the context it doesn't matter
    // which one we found first because both will contain the
    // ThemeSettingProvider within their BuilContext
    find
        .byKey(
          coloredBoxKey,
        )
        .first,
  );

  final provider = context.read<ThemeSettingProvider<T>>();
  return provider;
}

Future<void> ensureCorrectThemeIsRendered<T>({
  required WidgetTester tester,
  required Widget sut,
  required ThemeAddon<T> themeAddon,
}) async {
  await tester.pumpWidget(
    addOnProviderWrapper<T>(
      child: sut,
      addons: [themeAddon],
    ),
  );
  await tester.pumpAndSettle();

  final coloredBoxFinder = find.byKey(coloredBoxKey);
  expect(coloredBoxFinder, findsOneWidget);
  final coloredBox = coloredBoxFinder.evaluate().single.widget as ColoredBox;

  expect(coloredBox.color, equals(colorBlue));
}

Future<void> ensureMultipleThemesRenderedSideBySide<T>({
  required WidgetTester tester,
  required Widget sut,
  required ThemeAddon<T> themeAddon,
  WidgetbookTheme<T>? updateTheme,
  bool checkSingleTheme = false,
}) async {
  await tester.pumpWidget(
    addOnProviderWrapper<ThemeData>(
      child: sut,
      addons: [themeAddon],
    ),
  );

  updateTheme != null
      ? getThemeSettingProvider<T>(tester).tapped(
          updateTheme,
        )
      : null;

  await tester.pumpAndSettle();

  final coloredBoxFinder = find.byKey(coloredBoxKey);

  expect(coloredBoxFinder, findsWidgets);

  final coloredBoxColors = coloredBoxFinder.evaluate().map((e) {
    final coloredBox = e.widget as ColoredBox;
    return coloredBox.color;
  }).toList();

  expect(
    coloredBoxColors.length,
    equals(
      checkSingleTheme ? 1 : 2,
    ),
  );

  expect(
    coloredBoxColors,
    equals(
      checkSingleTheme
          ? [
              colorBlue,
            ]
          : [
              colorBlue,
              colorYellow,
            ],
    ),
  );
}
