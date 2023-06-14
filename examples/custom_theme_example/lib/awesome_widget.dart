import 'package:flutter/material.dart';

import 'app_theme.dart';

class AwesomeWidget extends StatelessWidget {
  const AwesomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppTheme.of(context).color,
      child: Center(
        child: Text(
          '$AwesomeWidget',
          style: TextStyle(
            color: AppTheme.of(context).color.computeLuminance() > 0.5
                ? Colors.black
                : Colors.white,
          ),
        ),
      ),
    );
  }
}
