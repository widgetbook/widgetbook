import 'package:flutter/material.dart';

import '../core/addon.dart';
import '../core/mode.dart';
import '../core/mode_addon.dart';
import '../fields/fields.dart';

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

/// An [Addon] for changing the active [ThemeData] via [Theme].
class MaterialThemeAddon extends ModeAddon<ThemeData> {
  MaterialThemeAddon(this.themes)
      : super(
          name: 'Material Theme',
          modeBuilder: MaterialThemeMode.new,
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
  ThemeData valueFromQueryGroup(Map<String, String> group) {
    return valueOf('name', group)!;
  }
}
