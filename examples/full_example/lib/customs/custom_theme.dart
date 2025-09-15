import 'package:flutter/material.dart';

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

class AwesomeWidget extends StatelessWidget {
  const AwesomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppTheme.of(context).color,
      child: Center(
        child: Text(
          '$AwesomeWidget',
          style: TextStyle(
            color: AppTheme.of(context).color.computeLuminance() > 0.5
                ? Colors.black
                : Colors.white,
          ),
        ),
      ),
    );
  }
}

// Now check widgetbook.theme.dart
