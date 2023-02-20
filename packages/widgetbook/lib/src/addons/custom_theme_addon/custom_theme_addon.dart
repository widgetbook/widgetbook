import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';

class CustomThemeAddon<T> extends ThemeAddon<T> {
  CustomThemeAddon({
    required super.setting,
  });
}

extension CustomThemeExtension on BuildContext {
  T? theme<T>() => getAddonValue<ThemeSetting<T>>()?.activeTheme.data;
}
