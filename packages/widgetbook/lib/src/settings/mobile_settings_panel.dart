import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@internal
class MobileSettingsPanel extends StatelessWidget {
  const MobileSettingsPanel({
    super.key,
    required this.name,
    required this.builder,
  });

  final String name;
  final List<Widget> Function(BuildContext context) builder;

  @override
  Widget build(BuildContext context) {
    final items = builder(context);

    if (items.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Text('No $name available'),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 16),
      itemCount: items.length,
      itemBuilder: (context, index) => items[index],
    );
  }
}
