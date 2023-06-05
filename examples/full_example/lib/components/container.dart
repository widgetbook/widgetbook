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
