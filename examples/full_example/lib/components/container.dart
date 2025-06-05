import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Component',
  type: Container,
  path: '[widgets]/containers',
)
Widget myWidget(BuildContext context) {
  return Column(
    children: [
      Container(color: Colors.blue),
      ElevatedButton(
        onPressed: () {
          WidgetbookState.of(context).open(
            'components/customcard/default_style/customcard/default-style',
          );
        },
        child: const Text('Go to Container'),
      ),
      // ComponentInfo(
      //   componentName: 'Container',
      //   description: 'A container with a red color',
      //   component: Container(color: Colors.red),
      // ),
    ],
  );
}
