import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@WidgetbookTheme(name: 'Light')
ThemeData lightTheme() {
  return ThemeData.light();
}

@WidgetbookTheme(name: 'Dark')
ThemeData darkTheme() {
  return ThemeData.dark();
}

@WidgetbookApp.material(
  name: '{{package.pascalCase()}}',
)
int? notUsed;
