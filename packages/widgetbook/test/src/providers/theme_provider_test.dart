import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/providers/theme_provider.dart';

import '../../helper.dart';

extension _WidgetTesterProviderExtension on WidgetTester {
  Future<ThemeProvider> pumpProvider() async {
    ThemeProvider themeProvider = await this.pumpBuilderAndReturnProvider(
      ThemeBuilder(
        child: Container(),
      ),
    );
    return themeProvider;
  }
}

void main() {
  group(
    '$ThemeProvider',
    () {
      testWidgets(
        'emits [${ThemeMode.light}, ${ThemeMode.dark}, ${ThemeMode.light}] when toggleTheme is called',
        (WidgetTester tester) async {
          ThemeProvider provider = await tester.pumpProvider();

          Future invokeToggle() async {
            provider = await tester.invokeMethodAndReturnPumpedProvider(() {
              provider.toggleTheme();
            });
          }

          await invokeToggle();
          expect(
            provider.state,
            equals(ThemeMode.light),
          );

          await invokeToggle();
          expect(
            provider.state,
            equals(ThemeMode.dark),
          );

          await invokeToggle();
          expect(
            provider.state,
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
          ThemeProvider provider = await tester.pumpProvider();

          expect(
            provider.state,
            equals(ThemeMode.dark),
          );
        },
      );
    },
  );
}
