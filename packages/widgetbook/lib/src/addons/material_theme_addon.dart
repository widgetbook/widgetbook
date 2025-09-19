import 'package:flutter/material.dart';

import '../core/core.dart';
import '../fields/fields.dart';

class MaterialThemeMode extends Mode<ThemeData> {
  MaterialThemeMode(String name, ThemeData value)
    : super(value, MaterialThemeAddon({name: value}));
}

/// An [Addon] for changing the active [ThemeData] via [Theme].
class MaterialThemeAddon extends Addon<ThemeData> {
  MaterialThemeAddon(this.themes) : super(name: 'Material Theme');

  final Map<String, ThemeData> themes;

  @override
  List<Field> get fields {
    return [
      ObjectDropdownField<ThemeData>(
        name: 'name',
        values: themes.values.toList(),
        initialValue: themes.values.first,
        labelBuilder:
            (theme) => themes.keys.firstWhere(
              (key) => themes[key] == theme,
            ),
      ),
    ];
  }

  @override
  ThemeData valueFromQueryGroup(Map<String, String> group) {
    return valueOf('name', group)!;
  }

  @override
  Map<String, String> valueToQueryGroup(ThemeData value) {
    return {'name': paramOf('name', value)};
  }

  @override
  Widget buildUseCase(BuildContext context, Widget child, ThemeData setting) {
    return Theme(
      data: setting,
      child: ColoredBox(
        color: setting.scaffoldBackgroundColor,
        child: DefaultTextStyle(
          style: setting.textTheme.bodyMedium!,
          child: child,
        ),
      ),
    );
  }
}
