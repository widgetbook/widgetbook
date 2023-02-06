import 'package:collection/collection.dart';
import 'package:widgetbook/widgetbook.dart';

class ThemeSetting<T> {
  ThemeSetting({
    required this.themes,
    required this.activeTheme,
  }) : assert(
          themes.isNotEmpty,
          'themes cannot be empty',
        );

  /// Sets the first theme within `themes` as the active theme on
  /// startup
  factory ThemeSetting.firstAsSelected({
    required List<WidgetbookTheme<T>> themes,
  }) {
    return ThemeSetting(
      activeTheme: themes.first,
      themes: themes,
    );
  }

  final List<WidgetbookTheme<T>> themes;
  final WidgetbookTheme<T> activeTheme;

  ThemeSetting<T> copyWith({
    List<WidgetbookTheme<T>>? themes,
    WidgetbookTheme<T>? activeTheme,
  }) {
    return ThemeSetting<T>(
      themes: themes ?? this.themes,
      activeTheme: activeTheme ?? this.activeTheme,
    );
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ThemeSetting<T> &&
            const DeepCollectionEquality()
                .equals(other.activeTheme, activeTheme) &&
            const DeepCollectionEquality().equals(other.themes, themes));
  }

  @override
  String toString() {
    return '$ThemeSetting(activeTheme: $activeTheme, themes: $themes)';
  }

  @override
  int get hashCode => Object.hash(
        runtimeType,
        const DeepCollectionEquality().hash(activeTheme),
        const DeepCollectionEquality().hash(themes),
      );
}
