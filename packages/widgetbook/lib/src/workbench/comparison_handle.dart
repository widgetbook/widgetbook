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
    required this.multiRender,
    required this.items,
    required this.buildItem,
    required this.onPreviousPressed,
    required this.onNextPressed,
  }) : super(key: key);

  final ComparisonSetting multiRender;
  final List<T> items;
  final SelectionItem<T> Function(T item) buildItem;
  final VoidCallback onPreviousPressed;
  final VoidCallback onNextPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ComparisonButton<CustomTheme>(
          value: multiRender,
        ),
        IterationButton.previous(onPressed: onPreviousPressed),
        ...items.map(buildItem).toList(),
        IterationButton.next(onPressed: onNextPressed),
        const SizedBox(
          width: 8,
        ),
      ],
    );
  }
}
