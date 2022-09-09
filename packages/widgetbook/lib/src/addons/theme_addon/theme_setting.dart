import 'package:collection/collection.dart';
import 'package:widgetbook/widgetbook.dart';

class ThemeSetting<T> {
  ThemeSetting({
    required this.themes,
    required this.activeThemes,
  });

  final List<WidgetbookTheme<T>> themes;
  final Set<WidgetbookTheme<T>> activeThemes;

  ThemeSetting<T> copyWith({
    List<WidgetbookTheme<T>>? themes,
    Set<WidgetbookTheme<T>>? activeThemes,
  }) {
    return ThemeSetting<T>(
      themes: themes ?? this.themes,
      activeThemes: activeThemes ?? this.activeThemes,
    );
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ThemeSetting<T> &&
            const DeepCollectionEquality()
                .equals(other.activeThemes, activeThemes) &&
            const DeepCollectionEquality().equals(other.themes, themes));
  }

  @override
  String toString() {
    return '$ThemeSetting(activeThemes: $activeThemes, themes: $themes)';
  }

  @override
  int get hashCode => Object.hash(
        runtimeType,
        const DeepCollectionEquality().hash(activeThemes),
        const DeepCollectionEquality().hash(themes),
      );
}
