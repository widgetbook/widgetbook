import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

abstract class ThemeAddon<T> extends WidgetbookAddOn<ThemeSetting<T>> {
  ThemeAddon({
    required super.setting,
  }) : super(
          name: 'themes',
        );

  @override
  Widget buildSetting(BuildContext context) {
    return Setting(
      name: 'Theme',
      child: DropdownSetting<WidgetbookTheme<T>>(
        options: setting.themes,
        initialSelection: setting.activeTheme,
        optionValueBuilder: (theme) => theme.name,
        onSelected: (theme) {
          onChanged(
            value.copyWith(
              activeTheme: theme,
            ),
          );
        },
      ),
    );
  }
}
