import 'package:custom_theme_example/app_theme.dart';
import 'package:flutter/material.dart';

class AwesomeWidget extends StatelessWidget {
  const AwesomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // AppTheme.of(context).typography.parameter1;
    return ColoredBox(
      color: AppTheme.of(context).color,
    );
  }
}
