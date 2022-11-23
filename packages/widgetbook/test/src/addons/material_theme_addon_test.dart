import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/addons/theme_addon/theme_selection_provider.dart';

import 'package:widgetbook/src/workbench/renderer.dart';

import 'utils/custom_app_theme.dart';
import 'utils/default_theme_wrapper.dart';
import 'utils/material_app_theme.dart';

void main() {
  late Renderer sut;
  final rendererKey = GlobalKey();

  setUpAll(() {
    sut = Renderer(
      key: rendererKey,
      appBuilder: materialAppBuilder,
      useCaseBuilder: (context) => Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'This is the home page',
              ),
            ],
          ),
        ),
      ),
    );
  });

  group('$Renderer', () {
    testWidgets(
      'renders correctly',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          addOnProviderWrapper<ThemeData>(
            child: sut,
            themeAddon: materialThemeAddon,
            themeSetting: materialThemeSetting,
            theme: blueMaterialWidgetbookTheme,
          ),
        );

        expect(find.byKey(rendererKey), findsOneWidget);
      },
    );
    testWidgets(
      'renders one Text Widget',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          addOnProviderWrapper<ThemeData>(
            child: sut,
            themeAddon: materialThemeAddon,
            themeSetting: materialThemeSetting,
            theme: blueMaterialWidgetbookTheme,
          ),
        );

        expect(find.byType(Text), findsOneWidget);
      },
    );

    testWidgets(
      'renders the correct text',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          addOnProviderWrapper<ThemeData>(
            child: sut,
            themeAddon: materialThemeAddon,
            themeSetting: materialThemeSetting,
            theme: blueMaterialWidgetbookTheme,
          ),
        );

        expect(find.text('This is the home page'), findsOneWidget);
      },
    );
    testWidgets(
      'renders the correct theme',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          addOnProviderWrapper<ThemeData>(
            child: sut,
            themeAddon: materialThemeAddon,
            themeSetting: materialThemeSetting,
            theme: blueMaterialWidgetbookTheme,
          ),
        );
        await tester.pumpAndSettle();

        final scaffoldFinder = find.byType(Scaffold);
        expect(scaffoldFinder, findsOneWidget);
        final scaffold = scaffoldFinder.evaluate().single.widget as Scaffold;

        expect(scaffold.backgroundColor, equals(colorBlue));
      },
    );

    testWidgets(
      'renders theme side by side when 2 active themes are activated',
      (WidgetTester tester) async {
        final provider = ThemeSettingProvider<ThemeData>(
          materialThemeSetting,
        );

        await tester.pumpWidget(
          addOnProviderWrapper<ThemeData>(
            child: sut,
            themeAddon: materialThemeAddon,
            themeSetting: materialThemeSetting,
            provider: provider,
            theme: blueMaterialWidgetbookTheme,
          ),
        );
        provider.tapped(yellowMaterialWidgetbookTheme);

        await tester.pumpAndSettle();

        final scaffoldFinderUpdated = find.byType(Scaffold);
        expect(scaffoldFinderUpdated, findsWidgets);
        final updatedScaffoldColors = scaffoldFinderUpdated.evaluate().map((e) {
          final scaffold = e.widget as Scaffold;
          return scaffold.backgroundColor;
        }).toList();

        expect(
          updatedScaffoldColors.length,
          equals(
            2,
          ),
        );

        expect(
          updatedScaffoldColors,
          equals(
            [
              colorBlue,
              colorYellow,
            ],
          ),
        );
      },
    );

    testWidgets(
      'can de-activate $customTheme2 when $ThemeSettingProvider..tapped(customTheme2) is called',
      (WidgetTester tester) async {
        final provider = ThemeSettingProvider(
          materialThemeSetting,
        );

        await tester.pumpWidget(
          addOnProviderWrapper<ThemeData>(
            child: sut,
            themeAddon: materialThemeAddon,
            themeSetting: materialThemeSetting,
            provider: provider,
            theme: blueMaterialWidgetbookTheme,
          ),
        );

        await tester.pumpAndSettle();
        provider.tapped(yellowMaterialWidgetbookTheme);
        await tester.pumpAndSettle();

        final scaffoldFinderUpdated = find.byType(Scaffold);

        expect(scaffoldFinderUpdated, findsWidgets);

        final updatedScaffoldColors = scaffoldFinderUpdated.evaluate().map((e) {
          final scaffold = e.widget as Scaffold;
          return scaffold.backgroundColor;
        }).toList();

        expect(
          updatedScaffoldColors.length,
          equals(
            2,
          ),
        );

        expect(
          updatedScaffoldColors,
          equals(
            [
              colorBlue,
              colorYellow,
            ],
          ),
        );

        provider.tapped(yellowMaterialWidgetbookTheme);
        await tester.pumpAndSettle();

        final updatedScaffold = find.byType(Scaffold);

        final updatedScaffoldColor = updatedScaffold.evaluate().map((e) {
          final scaffold = e.widget as Scaffold;
          return scaffold.backgroundColor;
        }).toList();

        expect(
          updatedScaffoldColor,
          equals(
            [
              colorBlue,
            ],
          ),
        );
      },
    );
  });
}
