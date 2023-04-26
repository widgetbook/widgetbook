import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

abstract class ThemeAddon<T> extends WidgetbookAddOn<ThemeSetting<T>> {
  ThemeAddon({
    required List<WidgetbookTheme<T>> themes,
    WidgetbookTheme<T>? initialTheme,
  })  : assert(
          themes.isNotEmpty,
          'themes cannot be empty',
        ),
        assert(
          initialTheme == null || themes.contains(initialTheme),
          'initialTheme must be in themes',
        ),
        super(
          initialSetting: ThemeSetting(
            themes: themes,
            activeTheme: initialTheme ?? themes.first,
          ),
        );

  @override
  Widget buildSetting(BuildContext context) {
    return Setting(
      name: 'Theme',
      child: DropdownSetting<WidgetbookTheme<T>>(
        options: initialSetting.themes,
        initialSelection: initialSetting.activeTheme,
        optionValueBuilder: (theme) => theme.name,
        onSelected: (theme) {
          onChanged(
            setting.copyWith(
              activeTheme: theme,
            ),
          );
        },
      ),
    );
  }
}
