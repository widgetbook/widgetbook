import 'package:flutter/widgets.dart';

import '../../fields/fields.dart';
import 'base/mode.dart';
import 'base/mode_addon.dart';

typedef ThemeBuilder<T> = Widget Function(
  BuildContext context,
  T theme,
  Widget child,
);

class ThemeMode<T> extends Mode<T> {
  ThemeMode(super.value, this.builder);

  final ThemeBuilder<T> builder;

  @override
  Widget build(BuildContext context, Widget child) {
    return builder(context, value, child);
  }
}

class ThemeAddon<T> extends ModeAddon<T> {
  ThemeAddon(this.themes, this.builder)
      : super(
          name: 'Theme',
          modeBuilder: (theme) => ThemeMode(theme, builder),
        );

  final Map<String, T> themes;
  final ThemeBuilder<T> builder;

  @override
  List<Field> get fields {
    return [
      ListField<T>(
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
  T valueFromQueryGroup(Map<String, String> group) {
    return valueOf<T>('name', group)!;
  }
}
