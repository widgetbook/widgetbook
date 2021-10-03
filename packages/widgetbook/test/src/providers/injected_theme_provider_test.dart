import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/providers/injected_theme_provider.dart';
import 'package:widgetbook/src/providers/injected_theme_state.dart';

import '../../helper.dart';

extension _WidgetTesterProviderExtension on WidgetTester {
  Future<InjectedThemeProvider> pumpProvider({
    ThemeData? lightTheme,
    ThemeData? darkTheme,
  }) async {
    InjectedThemeProvider themeProvider =
        await this.pumpBuilderAndReturnProvider(
      InjectedThemeBuilder(
        lightTheme: lightTheme,
        darkTheme: darkTheme,
        child: Container(),
      ),
    );
    return themeProvider;
  }
}

void main() {
  group(
    '$InjectedThemeProvider',
    () {
      ThemeData initialLightTheme = ThemeData();
      ThemeData initialDarkTheme = ThemeData();

      testWidgets(
        'emits $InjectedThemeState(newTheme, newTheme) when themesChanged is called',
        (WidgetTester tester) async {
          InjectedThemeProvider provider = await tester.pumpProvider(
            lightTheme: initialLightTheme,
            darkTheme: initialDarkTheme,
          );

          // Setting of any ThemeData property is required because otherwise
          // the onStateChanged provider method is never called
          ThemeData newLightTheme = ThemeData(
            scaffoldBackgroundColor: Colors.yellow,
          );
          ThemeData newDarkTheme = ThemeData(
            scaffoldBackgroundColor: Colors.yellow,
          );

          provider = await tester.invokeMethodAndReturnPumpedProvider(
            () {
              provider.themesChanged(
                lightTheme: newLightTheme,
                darkTheme: newDarkTheme,
              );
            },
          );

          expect(
            provider.state,
            equals(
              InjectedThemeState(
                lightTheme: newLightTheme,
                darkTheme: newDarkTheme,
              ),
            ),
          );
        },
      );

      testWidgets(
        '.of returns $InjectedThemeProvider instance',
        (WidgetTester tester) async {
          await tester.pumpWidgetWithMaterialApp(
            InjectedThemeBuilder(
              child: Container(),
            ),
          );

          final BuildContext context = tester.element(find.byType(Container));
          var provider = InjectedThemeProvider.of(context);
          expect(
            provider,
            isNot(null),
          );
        },
      );

      testWidgets(
        '.state defaults to ${InjectedThemeState()}',
        (WidgetTester tester) async {
          InjectedThemeProvider provider = await tester.pumpProvider();

          expect(
            provider.state,
            equals(InjectedThemeState()),
          );
        },
      );
    },
  );
}
