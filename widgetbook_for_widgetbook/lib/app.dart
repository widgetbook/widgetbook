import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:widgetbook_core/widgetbook_core.dart';

@widgetbook.App.material(
  devices: [
    Apple.iPhone11,
    Apple.iPhone12,
    Apple.iPhone13,
  ],
  textScaleFactors: [
    1,
    2,
  ],
)
const int notUsed = 0;

@widgetbook.Theme(name: 'Dark', isDefault: true)
ThemeData themeDark() => Themes.dark;

@widgetbook.Theme(name: 'Light')
ThemeData themeLight() => Themes.light;
