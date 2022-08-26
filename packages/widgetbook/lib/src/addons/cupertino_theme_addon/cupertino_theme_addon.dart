import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/theme_addon/theme_provider.dart';
import 'package:widgetbook/widgetbook.dart';

class CupertinoThemeAddon extends ThemeAddon<CupertinoThemeData> {
  CupertinoThemeAddon({
    required List<WidgetbookTheme<CupertinoThemeData>> themes,
  }) : super(themes: themes);
}

extension CupertinoThemeExtension on BuildContext {
  CupertinoThemeData get cupertinoTheme =>
      watch<ThemeProvider<CupertinoThemeData>>().value.data;
}
