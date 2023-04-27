import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_addon/widgetbook_addon.dart';

@immutable
class ThemeSetting<T> extends WidgetbookAddOnModel<ThemeSetting<T>> {
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
  Map<String, String> toQueryParameter() {
    return {
      'theme': activeTheme.name,
    };
  }

  @override
  ThemeSetting<T>? fromQueryParameter(Map<String, String> queryParameters) {
    return queryParameters.containsKey('theme')
        ? this.copyWith(
            activeTheme: themes.firstWhere(
              (theme) => theme.name == queryParameters['theme']!,
            ),
          )
        : null;
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
