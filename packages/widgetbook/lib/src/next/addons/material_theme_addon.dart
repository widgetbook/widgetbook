import 'package:flutter/material.dart';

import '../../fields/fields.dart';
import 'base/mode.dart';
import 'base/modes_addon.dart';

class MaterialThemeMode extends Mode<ThemeData> {
  MaterialThemeMode(super.value);

  @override
  Widget build(BuildContext context, Widget child) {
    return Theme(
      data: value,
      child: ColoredBox(
        color: value.scaffoldBackgroundColor,
        child: DefaultTextStyle(
          style: value.textTheme.bodyMedium!,
          child: child,
        ),
      ),
    );
  }
}

class MaterialThemeAddon extends ModesAddon<MaterialThemeMode> {
  MaterialThemeAddon(this.themes)
      : super(
          name: 'Material Theme',
          modes: themes.entries
              .map((entry) => MaterialThemeMode(entry.value))
              .toList(),
        );

  final Map<String, ThemeData> themes;

  @override
  List<Field> get fields {
    return [
      ListField<ThemeData>(
        name: 'name',
        values: themes.values.toList(),
        initialValue: themes.values.first,
        labelBuilder: (theme) => themes.keys.firstWhere(
          (key) => themes[key] == theme,
        ),
      ),
    ];
  }

  @override
  MaterialThemeMode valueFromQueryGroup(Map<String, String> group) {
    return MaterialThemeMode(
      valueOf<ThemeData>('name', group)!,
    );
  }
}
