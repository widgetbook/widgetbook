import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class AppThemeData {
  AppThemeData({
    required this.color,
  });
  final Color color;
}

class AppTheme extends InheritedWidget {
  const AppTheme({
    super.key,
    required this.data,
    required super.child,
  });

  final AppThemeData data;

  static AppThemeData of(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<AppTheme>();
    return widget!.data;
  }

  @override
  bool updateShouldNotify(covariant AppTheme oldWidget) {
    return data != oldWidget.data;
  }
}

const colorBlue = Colors.blue;
final customTheme = WidgetbookTheme<AppThemeData>(
  name: 'Blue',
  data: AppThemeData(color: colorBlue),
);

const colorYellow = Colors.yellow;
final customTheme2 = WidgetbookTheme<AppThemeData>(
  name: 'Yellow',
  data: AppThemeData(color: colorYellow),
);
