import 'package:widgetbook/widgetbook.dart';

class CustomThemeSetting<T> extends ThemeSetting<T> {
  CustomThemeSetting({
    required super.themes,
    required super.activeTheme,
  });

  /// Sets the first theme within `themes` as the active theme on
  /// startup
  factory CustomThemeSetting.firstAsSelected({
    required List<WidgetbookTheme<T>> themes,
  }) {
    return CustomThemeSetting(
      activeTheme: themes.first,
      themes: themes,
    );
  }
}
