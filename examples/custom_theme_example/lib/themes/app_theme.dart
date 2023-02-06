import 'package:flutter/material.dart';

class AppThemeData {
  final Color color;

  AppThemeData({
    required this.color,
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

AppThemeData themeDataBlue = AppThemeData(
  color: Colors.blue,
);

AppThemeData themeDataYellow = AppThemeData(
  color: Colors.yellow,
);
