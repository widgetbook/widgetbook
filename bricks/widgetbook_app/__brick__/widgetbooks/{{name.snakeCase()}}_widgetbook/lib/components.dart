import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@WidgetbookUseCase(name: 'Default', type: FloatingActionButton)
Widget buildFab(BuildContext context) {
  return FloatingActionButton(
    onPressed: () {},
    child: const Icon(Icons.add),
  );
}
