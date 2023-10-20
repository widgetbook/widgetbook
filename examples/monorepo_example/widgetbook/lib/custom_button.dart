import 'package:flutter/material.dart';
import 'package:shared_ui/shared_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'with green color',
  type: CustomButton,
)
Widget greenContainerUseCase(BuildContext context) {
  return Center(
    child: CustomButton(
      text: 'Text',
      onPressed: () {},
      color: Colors.green,
    ),
  );
}

@widgetbook.UseCase(
  name: 'with red color',
  type: CustomButton,
)
Widget redContainerUseCase(BuildContext context) {
  return Center(
    child: CustomButton(
      text: 'Text',
      onPressed: () {},
      color: Colors.red,
    ),
  );
}
