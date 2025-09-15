import 'package:flutter/material.dart';

import 'knob_entry.dart';

class KnobsTable extends StatelessWidget {
  const KnobsTable({
    super.key,
    required this.entries,
  });

  final List<KnobEntry<dynamic>> entries;

  @override
  Widget build(BuildContext context) {
    const headerStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Table(
        border: TableBorder.all(),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(
            decoration: const BoxDecoration(
              color: Colors.lightBlue,
            ),
            children:
                [
                      const Text(
                        'Type',
                        style: headerStyle,
                      ),
                      const Text(
                        'Regular',
                        style: headerStyle,
                      ),
                      const Text(
                        'Nullable',
                        style: headerStyle,
                      ),
                    ]
                    .map(
                      (cell) => Padding(
                        padding: const EdgeInsets.all(16),
                        child: cell,
                      ),
                    )
                    .toList(),
          ),
          ...entries
              .map(
                (entry) => TableRow(
                  children:
                      [
                            Text(entry.name),
                            entry.toRegularWidget(),
                            entry.toNullableWidget(),
                          ]
                          .map(
                            (cell) => Padding(
                              padding: const EdgeInsets.all(16),
                              child: cell,
                            ),
                          )
                          .toList(),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
