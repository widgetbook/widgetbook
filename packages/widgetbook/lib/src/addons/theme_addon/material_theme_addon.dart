import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

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
