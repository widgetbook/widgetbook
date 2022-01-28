import 'package:flutter/material.dart';
import 'package:widgetbook/src/constants/radii.dart';
import 'package:widgetbook/src/utils/extensions.dart';

class SelectionItem<T> extends StatelessWidget {
  const SelectionItem({
    Key? key,
    required this.tooltip,
    required this.selectedItem,
    required this.item,
    required this.onPressed,
  }) : super(key: key);

  final String tooltip;
  final T? selectedItem;
  final T item;
  final VoidCallback onPressed;

  bool get _areEqual => selectedItem == item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        customBorder: const RoundedRectangleBorder(
          borderRadius: Radii.defaultRadius,
        ),
        hoverColor: Theme.of(context).cardColor,
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            borderRadius: Radii.defaultRadius,
            color: _areEqual
                ? Theme.of(context).colorScheme.primary
                : Colors.transparent,
          ),
          child: Text(
            tooltip,
          ),
        ),
      ),
    );
  }
}
