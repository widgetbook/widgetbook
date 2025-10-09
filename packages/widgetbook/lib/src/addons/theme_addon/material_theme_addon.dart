import 'package:flutter/material.dart';

import '../../core/core.dart';
import 'theme_addon.dart';

// We extend [Mode] not [ThemeMode] as the [Mode.addon] runtime type
// needs to be `MaterialThemeAddon` for proper substitution in [Scenario].
class MaterialThemeMode extends Mode<ThemeData> {
  MaterialThemeMode(
    String name,
    ThemeData theme,
  ) : super(
        theme,
        MaterialThemeAddon({name: theme}),
      );
}

/// An [Addon] for changing the active [ThemeData] via [Theme].
class MaterialThemeAddon extends ThemeAddon<ThemeData> {
  MaterialThemeAddon(Map<String, ThemeData> themes)
    : super(
        themes,
        (context, theme, child) {
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
