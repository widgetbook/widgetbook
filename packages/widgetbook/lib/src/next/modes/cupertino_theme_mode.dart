import 'package:flutter/cupertino.dart';

import '../../addons/addons.dart';
import 'mode.dart';
import 'theme_mode.dart';

class CupertinoThemeMode extends CupertinoThemeAddon
    with Mode<WidgetbookTheme<CupertinoThemeData>>
    implements ThemeMode<CupertinoThemeData> {
  CupertinoThemeMode({
    required Map<String, CupertinoThemeData> themes,
    CupertinoThemeData? initialTheme,
  }) : super(
          themes: [
            for (final entry in themes.entries)
              WidgetbookTheme<CupertinoThemeData>(
                name: entry.key,
                data: entry.value,
              ),
          ],
          initialTheme: !themes.containsValue(initialTheme)
              ? null
              : WidgetbookTheme<CupertinoThemeData>(
                  name: themes.entries
                      .firstWhere((entry) => entry.value == initialTheme)
                      .key,
                  data: initialTheme!,
                ),
        );
}
