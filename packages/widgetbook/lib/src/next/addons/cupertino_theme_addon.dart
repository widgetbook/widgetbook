import 'package:flutter/cupertino.dart';

import '../../fields/fields.dart';
import 'base/mode.dart';
import 'base/modes_addon.dart';

class CupertinoThemeMode extends Mode<CupertinoThemeData> {
  CupertinoThemeMode(super.value);

  @override
  Widget build(BuildContext context, Widget child) {
    return CupertinoTheme(
      data: value,
      child: ColoredBox(
        color: value.scaffoldBackgroundColor,
        child: DefaultTextStyle(
          style: value.textTheme.textStyle,
          child: child,
        ),
      ),
    );
  }
}

class CupertinoThemeAddon extends ModesAddon<CupertinoThemeMode> {
  CupertinoThemeAddon(this.themes)
      : super(
          name: 'Cupertino Theme',
          modes: themes.entries
              .map((entry) => CupertinoThemeMode(entry.value))
              .toList(),
        );

  final Map<String, CupertinoThemeData> themes;

  @override
  List<Field> get fields {
    return [
      ListField<CupertinoThemeData>(
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
  CupertinoThemeMode valueFromQueryGroup(Map<String, String> group) {
    return CupertinoThemeMode(
      valueOf<CupertinoThemeData>('name', group)!,
    );
  }
}
