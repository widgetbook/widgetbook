import 'package:flutter/material.dart';

class ExperimentalBadge extends StatelessWidget {
  const ExperimentalBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'This feature is only available in the "next" version.\n'
          'It is still in development and might change in the future.',
      child: Container(
        width: 5.0,
        height: 5.0,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
        ),
      ),
    );
  }
}
