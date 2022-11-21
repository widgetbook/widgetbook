import 'package:widgetbook/widgetbook.dart';

class CustomThemeSetting<T> extends ThemeSetting<T> {
  CustomThemeSetting({
    required super.themes,
    required super.activeThemes,
  });

  /// Sets the first theme within `themes` as the active theme on
  /// startup
  factory CustomThemeSetting.firstAsSelected({
    required List<WidgetbookTheme<T>> themes,
  }) {
    return CustomThemeSetting(
      activeThemes: themes.take(1).toSet(),
      themes: themes,
    );
  }

  /// Sets all `themes` as the active themes on
  /// startup
  factory CustomThemeSetting.allAsSelected({
    required List<WidgetbookTheme<T>> themes,
  }) {
    return CustomThemeSetting(
      activeThemes: themes.toSet(),
      themes: themes,
    );
  }
}
