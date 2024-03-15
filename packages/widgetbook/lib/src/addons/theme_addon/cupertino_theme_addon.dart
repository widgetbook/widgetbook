import 'package:flutter/cupertino.dart';

import 'theme_addon.dart';

/// A [ThemeAddon] for changing the active [CupertinoThemeData] via
/// [CupertinoTheme].
///
/// {@macro ThemeAddon.initialTheme}
class CupertinoThemeAddon extends ThemeAddon<CupertinoThemeData> {
  CupertinoThemeAddon({
    required super.themes,
    super.initialTheme,
  }) : super(
          themeBuilder: (context, theme, child) {
            return CupertinoTheme(
              data: theme,
              child: ColoredBox(
                color: theme.scaffoldBackgroundColor,
                child: DefaultTextStyle(
                  style: theme.textTheme.textStyle,
                  child: child,
                ),
              ),
            );
          },
        );
}
