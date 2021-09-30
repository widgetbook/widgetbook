import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/providers/theme_provider.dart';

main() {
  group('$ThemeProvider', () {
    test('emits ${ThemeMode.dark} when called on ${ThemeMode.light}', () {
      var state = ThemeMode.light;
      var provider = ThemeProvider(
        state: state,
        onStateChanged: (ThemeMode mode) {
          state = mode;
        },
        child: Text(''),
      );

      provider.toggleTheme();
      expect(
        state,
        equals(ThemeMode.dark),
      );
    });

    test('emits ${ThemeMode.light} when called on ${ThemeMode.dark}', () {
      var state = ThemeMode.dark;
      var provider = ThemeProvider(
        state: state,
        onStateChanged: (ThemeMode mode) {
          state = mode;
        },
        child: Text(''),
      );

      provider.toggleTheme();
      expect(
        state,
        equals(
          ThemeMode.light,
        ),
      );
    });
  });
}
