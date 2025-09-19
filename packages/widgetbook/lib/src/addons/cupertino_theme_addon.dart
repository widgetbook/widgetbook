import 'package:flutter/cupertino.dart';

import '../core/core.dart';
import '../fields/fields.dart';

class CupertinoThemeMode extends Mode<CupertinoThemeData> {
  CupertinoThemeMode(String name, CupertinoThemeData value)
    : super(value, CupertinoThemeAddon({name: value}));
}

/// An [Addon] for changing the active [CupertinoThemeData] via
/// [CupertinoTheme].
class CupertinoThemeAddon extends Addon<CupertinoThemeData> {
  CupertinoThemeAddon(this.themes) : super(name: 'Cupertino Theme');

  final Map<String, CupertinoThemeData> themes;

  @override
  List<Field> get fields {
    return [
      ObjectDropdownField<CupertinoThemeData>(
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
  CupertinoThemeData valueFromQueryGroup(Map<String, String> group) {
    return valueOf('name', group)!;
  }

  @override
  Map<String, String> valueToQueryGroup(CupertinoThemeData value) {
    return {'name': paramOf('name', value)};
  }

  @override
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    CupertinoThemeData setting,
  ) {
    return CupertinoTheme(
      data: setting,
      child: ColoredBox(
        color: setting.scaffoldBackgroundColor,
        child: DefaultTextStyle(
          style: setting.textTheme.textStyle,
          child: child,
        ),
      ),
    );
  }
}
