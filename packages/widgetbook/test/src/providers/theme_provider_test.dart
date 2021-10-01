import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/providers/theme_provider.dart';

import '../../helper.dart';

void main() {
  group(
    '$ThemeProvider',
    () {
      testWidgets(
        'emits correct state when toggleTheme is called',
        (WidgetTester tester) async {
          await tester.pumpWidgetWithMaterialApp(
            ThemeBuilder(
              child: Container(),
            ),
          );

          var themeProviderFinder = find.byType(ThemeProvider);
          expect(themeProviderFinder, findsOneWidget);

          var themeProvider =
              tester.firstWidget(themeProviderFinder) as ThemeProvider;

          themeProvider.toggleTheme();
          await tester.pump();
          themeProvider = getProvider(tester);
          expect(
            themeProvider.state,
            equals(ThemeMode.light),
          );

          themeProvider.toggleTheme();
          await tester.pump();
          themeProvider = getProvider(tester);
          expect(
            themeProvider.state,
            equals(ThemeMode.dark),
          );

          themeProvider.toggleTheme();
          await tester.pump();
          themeProvider = getProvider(tester);
          expect(
            themeProvider.state,
            equals(ThemeMode.light),
          );
        },
      );

      testWidgets(
        '.of returns $ThemeProvider instance',
        (WidgetTester tester) async {
          await tester.pumpWidgetWithMaterialApp(
            ThemeBuilder(
              child: Container(),
            ),
          );

          final BuildContext context = tester.element(find.byType(Container));
          var themeProvider = ThemeProvider.of(context);
          expect(
            themeProvider,
            isNot(null),
          );
        },
      );

      testWidgets(
        '.state defaults to ${ThemeMode.dark}',
        (WidgetTester tester) async {
          await tester.pumpWidgetWithMaterialApp(
            ThemeBuilder(
              child: Container(),
            ),
          );

          var themeProviderFinder = find.byType(ThemeProvider);
          expect(themeProviderFinder, findsOneWidget);

          var themeProvider =
              tester.firstWidget(themeProviderFinder) as ThemeProvider;

          expect(
            themeProvider.state,
            equals(ThemeMode.dark),
          );
        },
      );
    },
  );
}
