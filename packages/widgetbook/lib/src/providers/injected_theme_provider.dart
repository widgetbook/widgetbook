import 'package:flutter/material.dart';
import 'package:widgetbook/src/providers/injected_theme_state.dart';
import 'package:widgetbook/src/providers/provider.dart';

class InjectedThemeProvider extends Provider<InjectedThemeState> {
  const InjectedThemeProvider({
    required InjectedThemeState state,
    required ValueChanged<InjectedThemeState> onStateChanged,
    required Widget child,
    Key? key,
  }) : super(
          state: state,
          onStateChanged: onStateChanged,
          child: child,
          key: key,
        );

  static InjectedThemeProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InjectedThemeProvider>();
  }

  void themesChanged({
    ThemeData? lightTheme,
    ThemeData? darkTheme,
  }) {
    emit(
      InjectedThemeState(
        lightTheme: lightTheme,
        darkTheme: darkTheme,
      ),
    );
  }
}
