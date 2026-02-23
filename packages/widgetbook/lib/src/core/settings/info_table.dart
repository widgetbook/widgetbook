import 'package:flutter/material.dart';

import '../theme/widgetbook_theme.dart';

class InfoTable extends StatelessWidget {
  const InfoTable({
    super.key,
    required this.title,
    required this.data,
  });

  final String title;
  final Map<String, String?> data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text(
            title,
            style: WidgetbookTheme.of(context).textTheme.headlineMedium,
          ),
          Table(
            children: data.entries.map((entry) {
              return TableRow(
                children: [
                  Text(
                    entry.key,
                    style: WidgetbookTheme.of(context).textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    entry.value ?? '',
                    style: WidgetbookTheme.of(context).textTheme.bodyMedium,
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
