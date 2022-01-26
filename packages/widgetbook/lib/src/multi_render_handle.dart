import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook/src/workbench/iteration_button.dart';
import 'package:widgetbook/src/workbench/multi_render.dart';
import 'package:widgetbook/src/workbench/multiselect_button.dart';
import 'package:widgetbook/src/workbench/selection_item.dart';

class MultiRenderHandle<T> extends ConsumerWidget {
  const MultiRenderHandle({
    Key? key,
    required this.multiRender,
    required this.items,
    required this.buildItem,
    required this.onPreviousPressed,
    required this.onNextPressed,
  }) : super(key: key);

  final MultiRender multiRender;
  final List<T> items;
  final SelectionItem<T> Function(T item) buildItem;
  final VoidCallback onPreviousPressed;
  final VoidCallback onNextPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        MultiselectButton(
          value: multiRender,
        ),
        IterationButton.left(onPressed: onPreviousPressed),
        ...items.map(buildItem).toList(),
        IterationButton.right(onPressed: onNextPressed),
        const SizedBox(
          width: 8,
        ),
      ],
    );
  }
}
