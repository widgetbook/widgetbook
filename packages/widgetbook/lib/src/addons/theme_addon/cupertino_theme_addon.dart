import 'package:flutter/cupertino.dart';

import '../../core/core.dart';
import 'theme_addon.dart';

// We extend [Mode] not [ThemeMode] as the [Mode.addon] runtime type
// needs to be `CupertinoThemeAddon` for proper substitution in [Scenario].
class CupertinoThemeMode extends Mode<CupertinoThemeData> {
  CupertinoThemeMode(
    String name,
    CupertinoThemeData theme,
  ) : super(
        theme,
        CupertinoThemeAddon({name: theme}),
      );
}

/// An [Addon] for changing the active [CupertinoThemeData] via
/// [CupertinoTheme].
class CupertinoThemeAddon extends ThemeAddon<CupertinoThemeData> {
  CupertinoThemeAddon(Map<String, CupertinoThemeData> themes)
    : super(
        themes,
        (context, theme, child) {
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
