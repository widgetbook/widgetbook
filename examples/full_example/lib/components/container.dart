import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

part 'container.builder.dart';

@widgetbook.UseCase(
  name: 'Component',
  type: Container,
  path: '[widgets]/containers',
)
Widget myWidget(BuildContext context) {
  return Column(
    children: [
      Container(color: Colors.blue),
      ComponentInfo(
        componentName: 'Container',
        description: 'A container with a red color',
        component: Container(color: Colors.red),
      ),
    ],
  );
}
