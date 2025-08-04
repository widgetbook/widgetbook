import 'package:flutter/cupertino.dart';

import 'theme_addon.dart';

/// A [ThemeAddon] for changing the active [CupertinoThemeData] via
/// [CupertinoTheme].
///
/// Learn more: https://docs.widgetbook.io/addons/theme-addon#cupertino-theme
class CupertinoThemeAddon extends ThemeAddon<CupertinoThemeData> {
  /// Creates a new instance of [CupertinoThemeAddon].
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
