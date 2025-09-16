import 'package:flutter/cupertino.dart';

import '../core/addon.dart';
import '../core/mode.dart';
import '../core/mode_addon.dart';
import '../fields/fields.dart';

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

/// An [Addon] for changing the active [CupertinoThemeData] via
/// [CupertinoTheme].
class CupertinoThemeAddon extends ModeAddon<CupertinoThemeData> {
  CupertinoThemeAddon(this.themes)
    : super(
        name: 'Cupertino Theme',
        modeBuilder: CupertinoThemeMode.new,
      );

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
}
