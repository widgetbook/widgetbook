import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/addons/addons.dart';
import 'package:widgetbook/src/addons/theme_addon/theme_selection_provider.dart';
import 'package:widgetbook/src/workbench/renderer.dart';

import 'utils/custom_app_theme.dart';
import 'utils/widget_wrapper.dart';

void main() {
  late Renderer sut;
  final rendererKey = GlobalKey();

  setUpAll(() {
    sut = Renderer(
      key: rendererKey,
      appBuilder: (context, child) {
        final frameBuilder = context.frameBuilder;
        final theme = context.theme<AppThemeData>();
        return AppTheme(
          data: theme,
          child: frameBuilder.builder(
            context,
            child,
          ),
        );
      },
      useCaseBuilder: (context) => Scaffold(
        backgroundColor: AppTheme.of(context).color,
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
          addOnProviderWrapper(
            child: sut,
          ),
        );

        expect(find.byKey(rendererKey), findsOneWidget);
      },
    );
    testWidgets(
      'renders one Text Widget',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          addOnProviderWrapper(
            child: sut,
          ),
        );

        expect(find.byType(Text), findsOneWidget);
      },
    );

    testWidgets(
      'renders the correct text',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          addOnProviderWrapper(
            child: sut,
          ),
        );

        expect(find.text('This is the home page'), findsOneWidget);
      },
    );
    testWidgets(
      'renders the correct theme',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          addOnProviderWrapper(
            child: sut,
          ),
        );
        await tester.pumpAndSettle();

        final scaffoldFinder = find.byType(Scaffold);
        expect(scaffoldFinder, findsOneWidget);
        final scaffold = scaffoldFinder.evaluate().single.widget as Scaffold;

        expect(scaffold.backgroundColor, equals(customColor));
      },
    );

    testWidgets(
      'renders theme side by side when 2 active themes are activated',
      (WidgetTester tester) async {
        final provider = ThemeSettingProvider(
          CustomThemeSetting<AppThemeData>(
            activeThemes: {customTheme},
            themes: [customTheme, customTheme2],
          ),
        );

        await tester
            .pumpWidget(addOnProviderWrapper(child: sut, provider: provider));
        provider.tapped(customTheme2);

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
              customColor,
              customColor2,
            ],
          ),
        );
      },
    );

    testWidgets(
      'can de-activate $customTheme2 when $ThemeSettingProvider..tapped(customTheme2) is called',
      (WidgetTester tester) async {
        final provider = ThemeSettingProvider(
          CustomThemeSetting<AppThemeData>(
            activeThemes: {customTheme},
            themes: [customTheme, customTheme2],
          ),
        );

        await tester.pumpWidget(
          addOnProviderWrapper(
            child: sut,
            provider: provider,
          ),
        );

        await tester.pumpAndSettle();
        provider.tapped(customTheme2);
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
              customColor,
              customColor2,
            ],
          ),
        );

        provider.tapped(customTheme2);
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
              customColor,
            ],
          ),
        );
      },
    );
  });
}
