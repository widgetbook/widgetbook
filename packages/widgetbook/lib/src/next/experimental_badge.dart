import 'package:flutter/material.dart';

class ExperimentalBadge extends StatelessWidget {
  const ExperimentalBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return const Tooltip(
      message: 'This feature is only available in the "next" version.\n'
          'It is still in development and might change in the future.',
      child: Badge(
        label: Text('experimental'),
        backgroundColor: Colors.red,
        textColor: Colors.white,
      ),
    );
  }
}
