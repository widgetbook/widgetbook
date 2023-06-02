import 'package:flutter/material.dart';

import '../../fields/fields.dart';
import '../common/common.dart';
import 'widgetbook_theme.dart';

typedef ThemeBuilder<T> = Widget Function(
  BuildContext context,
  T theme,
  Widget child,
);

/// A [WidgetbookAddon] for changing the active custom theme. A [themeBuilder]
/// must be provided that returns an [InheritedWidget] or similar [Widget]s.
class ThemeAddon<T> extends WidgetbookAddon<WidgetbookTheme<T>> {
  ThemeAddon({
    required this.themes,
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
          initialSetting: initialTheme ?? themes.first,
        );

  final List<WidgetbookTheme<T>> themes;
  final ThemeBuilder<T> themeBuilder;

  @override
  List<Field> get fields {
    return [
      ListField<WidgetbookTheme<T>>(
        group: slugName,
        name: 'name',
        values: themes,
        initialValue: initialSetting,
        labelBuilder: (theme) => theme.name,
      ),
    ];
  }

  @override
  WidgetbookTheme<T> settingFromQueryGroup(Map<String, String> group) {
    return themes.firstWhere(
      (theme) => theme.name == group['name'],
      orElse: () => initialSetting,
    );
  }

  @override
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    WidgetbookTheme<T> setting,
  ) {
    return themeBuilder(
      context,
      setting.data,
      child,
    );
  }
}
