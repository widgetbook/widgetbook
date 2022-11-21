import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/theme_addon/theme_provider.dart';
import 'package:widgetbook/widgetbook.dart';

class CustomThemeAddon<T> extends ThemeAddon<T> {
  CustomThemeAddon({
    required CustomThemeSetting<T> themeSetting,
  }) : super(setting: themeSetting);
}

extension CustomThemeExtension on BuildContext {
  T theme<T>() => watch<ThemeProvider<T>>().value.data;
}
