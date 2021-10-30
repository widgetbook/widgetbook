import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/providers/injected_theme_state.dart';

import '../../helper/model_helper.dart';

void main() {
  group(
    '$InjectedThemeState',
    () {
      test(
        'returns true when instance is the same',
        () {
          final instance = InjectedThemeState(
            lightTheme: ThemeData(),
            darkTheme: ThemeData(),
          );

          expect(
            instance == instance,
            equals(true),
          );
        },
      );

      group('.isLightThemeDefined returns', () {
        test('true when theme is defined', () {
          final instance = InjectedThemeState(lightTheme: ThemeData());
          expect(instance.isLightThemeDefined, isTrue);
        });

        test('false when theme is defined', () {
          final instance = InjectedThemeState();
          expect(instance.isLightThemeDefined, isFalse);
        });
      });

      group('.isDarkThemeDefined returns', () {
        test('true when theme is defined', () {
          final instance = InjectedThemeState(darkTheme: ThemeData());
          expect(instance.isDarkThemeDefined, isTrue);
        });

        test('false when theme is defined', () {
          final instance = InjectedThemeState();
          expect(instance.isDarkThemeDefined, isFalse);
        });
      });

      group('.areBothThemesDefined returns', () {
        test('true when theme is defined', () {
          final instance = InjectedThemeState(
            darkTheme: ThemeData(),
            lightTheme: ThemeData(),
          );
          expect(instance.areBothThemesDefined, isTrue);
        });

        test('false when theme is defined', () {
          final instance = InjectedThemeState();
          expect(instance.areBothThemesDefined, isFalse);
        });
      });

      group(
        'returns true when',
        () {
          test(
            'two instances with the same values are compared',
            () {
              final instance1 = InjectedThemeState(
                lightTheme: ThemeData(),
                darkTheme: ThemeData(),
              );

              final instance2 = InjectedThemeState(
                lightTheme: ThemeData(),
                darkTheme: ThemeData(),
              );

              expect(
                instance1 == instance2,
                equals(true),
              );
            },
          );

          test(
            'the hashCodes of two instances with the same values are compared',
            () {
              final instance1 = InjectedThemeState(
                lightTheme: ThemeData(),
                darkTheme: ThemeData(),
              );

              final instance2 = InjectedThemeState(
                lightTheme: ThemeData(),
                darkTheme: ThemeData(),
              );

              expectEqualHashCodes(instance1, instance2);
            },
          );
        },
      );
    },
  );
}
