import 'package:flutter/material.dart';

import '../themes/app_theme.dart';

class AwesomeWidget extends StatelessWidget {
  const AwesomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppTheme.of(context).color,
    );
  }
}
