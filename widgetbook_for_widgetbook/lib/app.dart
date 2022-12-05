import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

@WidgetbookApp.material(name: 'Widgetbook')
const int notUsed = 0;

@WidgetbookTheme(name: 'Dark')
ThemeData theme() => ThemeData.dark();

@WidgetbookUseCase(name: 'ContainerAlternative', type: ContainerAlternative)
Widget buildContainer(BuildContext context) {
  return ContainerAlternative();
}
