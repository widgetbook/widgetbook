import 'package:flutter/material.dart';

import '../../../widgetbook.dart';

/// A [DocBlock] that displays a table of [Arg]s for a [Story], including
/// [Arg.name], [Arg.value], and [Arg.description].
///
/// Used to document the configurable arguments of a story.
class ArgsBlock extends DocBlock {
  const ArgsBlock({super.key, required this.args});

  final List<Arg<dynamic>> args;

  @override
  Widget build(BuildContext context) {
    if (args.isEmpty) {
      return const Text('No args defined for the story.');
    }

    return DataTable(
      columns: const [
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('Value')),
        DataColumn(label: Text('Description'), columnWidth: FlexColumnWidth()),
      ],
      rows: [
        for (final arg in args)
          DataRow(
            cells: [
              DataCell(Text(arg.name)),
              DataCell(Text(arg.value.toString())),
              DataCell(Text(arg.description ?? '')),
            ],
          ),
      ],
    );
  }
}
