import 'package:flutter/material.dart';
import 'package:widgetbook/src/utils/extensions.dart';

class SelectionItem<T> extends StatelessWidget {
  const SelectionItem({
    Key? key,
    required this.iconData,
    required this.tooltip,
    required this.selectedItem,
    required this.item,
    required this.onPressed,
  }) : super(key: key);

  final IconData iconData;
  final String tooltip;
  final T? selectedItem;
  final T item;
  final VoidCallback onPressed;

  bool get _areEqual => selectedItem == item;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          iconData,
          color:
              _areEqual ? context.colorScheme.primary : context.theme.hintColor,
        ),
      ),
    );
  }
}
