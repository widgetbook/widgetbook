import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class MaterialThemeAddon extends ThemeAddon<ThemeData> {
  MaterialThemeAddon({
    required ThemeSetting<ThemeData> themeSetting,
  }) : super(setting: themeSetting);
}

extension MaterialThemeExtension on BuildContext {
  ThemeData get materialTheme => theme<ThemeData>();
}
