import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeBuilderFunction<CustomTheme> defaultThemeBuilder<CustomTheme>() => (
      BuildContext context,
      CustomTheme theme,
      Widget child,
    ) {
      if (theme is ThemeData) {
        return Theme(
          data: theme,
          child: child,
        );
      }
      if (theme is CupertinoThemeData) {
        return CupertinoTheme(
          data: theme,
          child: child,
        );
      }

      throw Exception(
        'You are using Widgetbook with custom theme data. '
        'Please provide an implementation for themeBuilder.',
      );
    };

typedef ThemeBuilderFunction<CustomTheme> = Widget Function(
  BuildContext context,
  CustomTheme theme,
  Widget child,
);
