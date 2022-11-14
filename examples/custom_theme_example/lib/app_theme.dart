import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TypographyData {
  final int parameter1;

  TypographyData(this.parameter1);
}

class AppThemeData {
  final Color color;
  final TypographyData typography;

  AppThemeData({
    required this.color,
    required this.typography,
  });
}

class AppTheme extends InheritedWidget {
  const AppTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(
          key: key,
          child: child,
        );

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
