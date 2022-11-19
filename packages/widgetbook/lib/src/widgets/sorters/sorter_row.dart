import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/models/models.dart';
import 'package:widgetbook/src/navigation/organizer_provider.dart';
import 'package:widgetbook/src/widgets/sorters/reset_sort_button.dart';
import 'package:widgetbook/src/widgets/sorters/sort_button.dart';

class SorterRow extends StatelessWidget {
  const SorterRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sorting = context.select<OrganizerProvider, Sorting?>(
      (provider) => provider.state.sorting,
    );
    final canReset = sorting != null;

    return Row(
      children: [
        SortButton(activeSorting: sorting),
        AnimatedOpacity(
          opacity: canReset ? 1 : 0,
          duration: const Duration(milliseconds: 250),
          child: const ResetSortButton(),
        ),
      ],
    );
  }
}
