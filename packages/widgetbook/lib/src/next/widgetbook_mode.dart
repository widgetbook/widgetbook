import 'package:flutter/material.dart';

import '../../widgetbook.dart';

abstract class WidgetbookMode<T> extends WidgetbookAddon<T> {
  WidgetbookMode({required super.name});

  @override
  String get groupName {
    // To temporarily avoid conflicts with other addons.
    return super.groupName + '-mode';
  }
}

class MaterialThemeMode extends WidgetbookMode<ThemeData> {
  MaterialThemeMode({
    required this.initialTheme,
    required this.themes,
  }) : super(
          name: 'Theme',
        );

  final ThemeData? initialTheme;
  final Map<String, ThemeData> themes;

  @override
  List<Field> get fields {
    return [
      ListField<ThemeData>(
        name: 'name',
        values: themes.values.toList(),
        initialValue: initialTheme,
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

  @override
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    ThemeData setting,
  ) {
    // Copied from [MaterialThemeAddon]
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
