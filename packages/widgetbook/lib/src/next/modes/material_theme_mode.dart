import 'package:flutter/material.dart' hide ThemeMode;

import '../../addons/addons.dart';
import 'mode.dart';
import 'theme_mode.dart';

class MaterialThemeMode extends MaterialThemeAddon
    with Mode<WidgetbookTheme<ThemeData>>
    implements ThemeMode<ThemeData> {
  MaterialThemeMode({
    required Map<String, ThemeData> themes,
    ThemeData? initialTheme,
  }) : super(
          themes: [
            for (final entry in themes.entries)
              WidgetbookTheme<ThemeData>(
                name: entry.key,
                data: entry.value,
              ),
          ],
          initialTheme: !themes.containsValue(initialTheme)
              ? null
              : WidgetbookTheme<ThemeData>(
                  name: themes.entries
                      .firstWhere((entry) => entry.value == initialTheme)
                      .key,
                  data: initialTheme!,
                ),
        );
}
