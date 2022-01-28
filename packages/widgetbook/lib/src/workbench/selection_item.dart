import 'package:flutter/material.dart';
import 'package:widgetbook/src/constants/radii.dart';
import 'package:widgetbook/src/utils/extensions.dart';
import 'package:widgetbook/src/workbench/workbench_button.dart';

class SelectionItem<T> extends StatelessWidget {
  const SelectionItem({
    Key? key,
    required this.name,
    required this.selectedItem,
    required this.item,
    required this.onPressed,
  }) : super(key: key);

  final String name;
  final T? selectedItem;
  final T item;
  final VoidCallback onPressed;

  bool get _areEqual => selectedItem == item;

  @override
  Widget build(BuildContext context) {
    return WorkbenchButton.text(
      onPressed: onPressed,
      color: _areEqual
          ? Theme.of(context).colorScheme.primary
          : Colors.transparent,
      child: Text(
        name,
      ),
    );
  }
}
