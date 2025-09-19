import 'package:flutter/widgets.dart';

import '../core/core.dart';
import '../fields/fields.dart';

typedef ThemeBuilder<T> =
    Widget Function(
      BuildContext context,
      T theme,
      Widget child,
    );

class ThemeMode<T> extends Mode<T> {
  ThemeMode(String name, T value, ThemeBuilder<T> builder)
    : super(value, ThemeAddon<T>({name: value}, builder));
}

/// An [Addon] for changing the active custom theme. A [builder] must be
/// provided that returns an [InheritedWidget] or similar [Widget]s.
class ThemeAddon<T> extends Addon<T> {
  ThemeAddon(this.themes, this.builder)
    : super(
        name: 'Theme',
      );

  final Map<String, T> themes;
  final ThemeBuilder<T> builder;

  @override
  List<Field> get fields {
    return [
      ObjectDropdownField<T>(
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
  T valueFromQueryGroup(Map<String, String> group) {
    return valueOf<T>('name', group)!;
  }

  @override
  Map<String, String> valueToQueryGroup(T value) {
    return {'name': paramOf('name', value)};
  }

  @override
  Widget buildUseCase(BuildContext context, Widget child, T setting) {
    return builder(context, setting, child);
  }
}
