import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/providers/theme_provider.dart';

import '../../helper.dart';

void main() {
  group(
    '$ThemeProvider',
    () {
      testWidgets(
        'emits [${ThemeMode.light}, ${ThemeMode.dark}, ${ThemeMode.light}] when toggleTheme is called',
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

          Future invokeToggle() async {
            themeProvider = await tester.invokeAndPumpProvider(() {
              themeProvider.toggleTheme();
            });
          }

          await invokeToggle();
          expect(
            themeProvider.state,
            equals(ThemeMode.light),
          );

          await invokeToggle();
          expect(
            themeProvider.state,
            equals(ThemeMode.dark),
          );

          await invokeToggle();
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
