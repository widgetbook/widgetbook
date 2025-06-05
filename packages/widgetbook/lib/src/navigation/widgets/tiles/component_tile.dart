import 'package:flutter/material.dart';

import '../../../../widgetbook.dart';

class ComponentTile extends StatelessWidget {
  const ComponentTile({
    super.key,
    required this.node,
    required this.isSelected,
  });

  final WidgetbookNode node;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: TextButton(
        style: ButtonStyle(
          alignment: Alignment.centerLeft,
          backgroundColor: WidgetStateProperty.all(
            isSelected
                ? Theme.of(context).colorScheme.primaryContainer
                : Colors.transparent,
          ),
          minimumSize: WidgetStateProperty.all(
            const Size(double.infinity, 55),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        onPressed: () {
          if (isSelected) {
            return;
          }

          WidgetbookState.of(context).open(node.path);
        },
        child: Text(
          node.name,
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
