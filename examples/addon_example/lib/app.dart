import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@WidgetbookApp.material(
  devices: [
    Apple.iPhone12,
    Apple.iPhone13,
    Apple.iPadMini,
    Desktop.desktop1080p,
  ],
)
late int notUsed;

@WidgetbookTheme(name: 'Light', isDefault: true)
ThemeData getLightTheme() => ThemeData.light();

/// Retrieves Dark Theme
@WidgetbookTheme(name: 'Dark', isDefault: true)
ThemeData getDarkTheme() => ThemeData.dark();
