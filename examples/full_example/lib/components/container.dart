import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'with green color',
  type: Container,
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

@widgetbook.UseCase(
  name: 'with custom color',
  type: Container,
)
Widget colorKnobUseCase(BuildContext context, Color color) {
  return Column(
    children: [
      Container(
        width: 100,
        height: 100,
        color: color,
      ),
    ],
  );
}
