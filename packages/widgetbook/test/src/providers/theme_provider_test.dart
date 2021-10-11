import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/providers/theme_provider.dart';

import '../../helper/provider_helper.dart';
import '../../helper/widget_test_helper.dart';

extension _WidgetTesterProviderExtension on WidgetTester {
  Future<ThemeProvider> pumpProvider() async {
    final provider = await pumpBuilderAndReturnProvider<ThemeProvider>(
      ThemeBuilder(
        child: Container(),
      ),
    );
    return provider;
  }
}

void main() {
  group(
    '$ThemeProvider',
    () {
      testWidgets(
        'emits [${ThemeMode.light}, ${ThemeMode.dark}, ${ThemeMode.light}] when toggleTheme is called',
        (WidgetTester tester) async {
          var provider = await tester.pumpProvider();

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
          final themeProvider = ThemeProvider.of(context);
          expect(
            themeProvider,
            isNot(null),
          );
        },
      );

      testWidgets(
        '.state defaults to ${ThemeMode.dark}',
        (WidgetTester tester) async {
          final provider = await tester.pumpProvider();

          expect(
            provider.state,
            equals(ThemeMode.dark),
          );
        },
      );
    },
  );
}
