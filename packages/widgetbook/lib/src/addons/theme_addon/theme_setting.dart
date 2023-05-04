import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:widgetbook/widgetbook.dart';

@immutable
class ThemeSetting<T> {
  ThemeSetting({
    required this.themes,
    required this.activeTheme,
  });

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
