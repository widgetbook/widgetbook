import 'package:flutter/material.dart';

class InjectedThemeState {
  InjectedThemeState({
    this.lightTheme,
    this.darkTheme,
  });

  final ThemeData? lightTheme;
  final ThemeData? darkTheme;

  bool get isLightThemeDefined => lightTheme != null;
  bool get isDarkThemeDefined => darkTheme != null;
  bool get areBothThemesDefined => isLightThemeDefined && isDarkThemeDefined;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InjectedThemeState &&
        other.lightTheme == lightTheme &&
        other.darkTheme == darkTheme;
  }

  @override
  int get hashCode => lightTheme.hashCode ^ darkTheme.hashCode;
}
