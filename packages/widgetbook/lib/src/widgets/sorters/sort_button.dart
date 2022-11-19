import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:widgetbook/src/models/models.dart';
import 'package:widgetbook/src/navigation/organizer_provider.dart';
import 'package:widgetbook/src/workbench/workbench_button.dart';

class SortButton extends StatelessWidget {
  const SortButton({
    Key? key,
    required this.activeSorting,
    this.height = 17.0,
  }) : super(key: key);

  final Sorting? activeSorting;
  final double height;

  String _getTooltip() {
    if (activeSorting == null) {
      return 'Sort by name ascending';
    }

    switch (activeSorting!) {
      case Sorting.asc:
        return 'Sort by name descending';
      case Sorting.desc:
        return 'Sort by name ascending';
    }
  }

  String _getLabel() {
    if (activeSorting == null) {
      return 'A->Z';
    }

    switch (activeSorting!) {
      case Sorting.asc:
        return 'Z->A';
      case Sorting.desc:
        return 'A->Z';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: _getTooltip(),
      child: WorkbenchButton.text(
        onPressed: activeSorting == null || activeSorting == Sorting.desc
            ? () => context.read<OrganizerProvider>().sort(Sorting.asc)
            : () => context.read<OrganizerProvider>().sort(Sorting.desc),
        child: Text(
          _getLabel(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: height,
            height: 1,
          ),
        ),
      ),
    );
  }
}
