import 'package:flutter/material.dart';

import 'theme_addon.dart';

/// A [ThemeAddon] for changing the active [ThemeData] via [Theme].
class MaterialThemeAddon extends ThemeAddon<ThemeData> {
  MaterialThemeAddon({
    required super.themes,
    super.initialTheme,
  }) : super(
          themeBuilder: (context, theme, child) {
            return Theme(
              data: theme,
              child: ColoredBox(
                color: theme.scaffoldBackgroundColor,
                child: DefaultTextStyle(
                  style: theme.textTheme.bodyMedium!,
                  child: child,
                ),
              ),
            );
          },
        );
}
