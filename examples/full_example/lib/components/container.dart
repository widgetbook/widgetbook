import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'with green color',
  type: Container,
  path: '[widgets]/containers',
)
Widget greenContainerUseCase(BuildContext context) {
  return Column(
    children: [
      Container(
        color: Colors.green,
      ),
    ],
  );
}

@widgetbook.UseCase(
  name: 'with different title',
  type: Container,
  path: '[widgets]/containers',
)
Widget myWidget(BuildContext context) {
  return Column(
    children: [
      Container(
        color: Colors.blue,
      ),
    ],
  );
}
