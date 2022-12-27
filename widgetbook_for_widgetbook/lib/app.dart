import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

@WidgetbookApp.material(
  name: 'Widgetbook',
  foldersExpanded: true,
)
const int notUsed = 0;

@WidgetbookTheme(name: 'Dark')
ThemeData theme() => Themes.dark;
