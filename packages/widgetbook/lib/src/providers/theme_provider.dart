import 'package:flutter/material.dart';
import 'package:widgetbook/src/providers/provider.dart';

class ThemeProvider extends Provider<ThemeMode> {
  const ThemeProvider({
    required ThemeMode state,
    required ValueChanged<ThemeMode> onStateChanged,
    required Widget child,
    Key? key,
  }) : super(
            state: state,
            onStateChanged: onStateChanged,
            child: child,
            key: key);

  static ThemeProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeProvider>();
  }

  void toggleTheme() {
    switch (state) {
      case ThemeMode.light:
        emit(ThemeMode.dark);
        break;
      default:
        emit(ThemeMode.light);
    }
  }
}
