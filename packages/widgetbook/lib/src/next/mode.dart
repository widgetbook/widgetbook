import 'package:flutter/material.dart';

import '../../widgetbook.dart';
import '../settings/setting.dart';
import 'experimental_badge.dart';

abstract class Mode<T> extends WidgetbookAddon<T> {
  Mode({required super.name});

  @override
  String get groupName {
    // To temporarily avoid conflicts with other addons.
    return super.groupName + '-mode';
  }

  @override
  Widget buildFields(BuildContext context) {
    return Setting(
      name: name,
      trailing: const ExperimentalBadge(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: fields
            .map(
              (field) => Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 4.0,
                ),
                child: field.build(context, groupName),
              ),
            )
            .toList(),
      ),
    );
  }
}

class MaterialThemeMode extends Mode<ThemeData> {
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
