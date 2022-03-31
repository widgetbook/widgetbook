import 'package:flutter/material.dart';
import 'package:widgetbook/src/workbench/comparison_button.dart';
import 'package:widgetbook/src/workbench/comparison_setting.dart';
import 'package:widgetbook/src/workbench/iteration_button.dart';
import 'package:widgetbook/src/workbench/selection_item.dart';

/// The [ComparisonHandle] allows users to preview one specific setting of a
/// collection or the whole collection at once.
class ComparisonHandle<T, CustomTheme> extends StatelessWidget {
  const ComparisonHandle({
    Key? key,
    required this.name,
    required this.multiRender,
    required this.items,
    required this.buildItem,
    required this.onPreviousPressed,
    required this.onNextPressed,
  }) : super(key: key);

  final String name;
  final ComparisonSetting multiRender;
  final List<T> items;
  final SelectionItem<T> Function(T item) buildItem;
  final VoidCallback onPreviousPressed;
  final VoidCallback onNextPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Expanded(child: Container()),
            ComparisonButton<CustomTheme>(
              value: multiRender,
            ),
            IterationButton.previous(onPressed: onPreviousPressed),
            IterationButton.next(onPressed: onNextPressed),
          ],
        ),
        Wrap(
          runSpacing: 6,
          children: items.map(buildItem).toList(),
        )
      ],
    );
  }
}
