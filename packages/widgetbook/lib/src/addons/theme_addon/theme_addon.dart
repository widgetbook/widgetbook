import 'package:flutter/material.dart';

import '../../fields/fields.dart';
import '../common/common.dart';
import 'theme_setting.dart';
import 'widgetbook_theme.dart';

typedef ThemeBuilder<T> = Widget Function(
  BuildContext context,
  T theme,
  Widget child,
);

/// A [WidgetbookAddOn] for changing the active custom theme. A [themeBuilder]
/// must be provided that returns an [InheritedWidget] or similar [Widget]s.
class ThemeAddon<T> extends WidgetbookAddOn<ThemeSetting<T>> {
  ThemeAddon({
    required List<WidgetbookTheme<T>> themes,
    WidgetbookTheme<T>? initialTheme,
    required this.themeBuilder,
  })  : assert(
          themes.isNotEmpty,
          'themes cannot be empty',
        ),
        assert(
          initialTheme == null || themes.contains(initialTheme),
          'initialTheme must be in themes',
        ),
        super(
          name: 'Theme',
          initialSetting: ThemeSetting(
            themes: themes,
            activeTheme: initialTheme ?? themes.first,
          ),
        );

  final ThemeBuilder<T> themeBuilder;

  @override
  List<Field> get fields {
    return [
      ListField<WidgetbookTheme<T>>(
        group: slugName,
        name: 'name',
        values: initialSetting.themes,
        initialValue: initialSetting.activeTheme,
        labelBuilder: (theme) => theme.name,
      ),
    ];
  }

  @override
  ThemeSetting<T> settingFromQueryGroup(Map<String, String> group) {
    return ThemeSetting<T>(
      themes: initialSetting.themes,
      activeTheme: initialSetting.themes.firstWhere(
        (theme) => theme.name == group['name'],
        orElse: () => initialSetting.activeTheme,
      ),
    );
  }

  @override
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    ThemeSetting<T> setting,
  ) {
    return themeBuilder(
      context,
      setting.activeTheme.data,
      child,
    );
  }
}
