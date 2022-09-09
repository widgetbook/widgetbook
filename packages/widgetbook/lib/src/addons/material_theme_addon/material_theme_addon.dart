import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/theme_addon/theme_provider.dart';
import 'package:widgetbook/widgetbook.dart';

class MaterialThemeAddon extends ThemeAddon<ThemeData> {
  MaterialThemeAddon({
    required MaterialThemeSetting themeSetting,
  }) : super(setting: themeSetting);
}

extension MaterialThemeExtension on BuildContext {
  ThemeData get materialTheme => watch<ThemeProvider<ThemeData>>().value.data;
}
