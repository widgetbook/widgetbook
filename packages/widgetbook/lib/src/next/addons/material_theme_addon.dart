// next version of Widgetbook doesn't have api docs yet
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

import '../../fields/fields.dart';
import 'base/mode.dart';
import 'base/mode_addon.dart';

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
}
