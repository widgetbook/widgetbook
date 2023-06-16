import 'package:flutter/material.dart';

import 'theme_addon.dart';
import 'widgetbook_theme.dart';

/// A [ThemeAddon] for changing the active [ThemeData] via [Theme].
class MaterialThemeAddon extends ThemeAddon<ThemeData> {
  MaterialThemeAddon({
    required List<WidgetbookTheme<ThemeData>> themes,
    WidgetbookTheme<ThemeData>? initialTheme,
  }) : super(
          themes: themes,
          initialTheme: initialTheme,
          themeBuilder: (context, theme, child) {
            return Theme(
              data: theme,
              child: child,
            );
          },
        );
}
