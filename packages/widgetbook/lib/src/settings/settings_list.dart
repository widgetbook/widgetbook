import 'package:flutter/material.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({
    super.key,
    required this.name,
    required this.builder,
  });

  final String name;
  final List<Widget> Function(BuildContext context) builder;

  @override
  Widget build(BuildContext context) {
    // A fresh context is used to keep the lists
    // up-to-date when the settings change.
    final children = builder(context);

    if (children.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text('No $name available'),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
      ),
      itemCount: children.length,
      itemBuilder: (context, index) => children[index],
    );
  }
}
