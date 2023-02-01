import 'package:custom_theme_example/themes/app_theme.dart';
import 'package:flutter/material.dart';

class AwesomeWidget extends StatelessWidget {
  const AwesomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppTheme.of(context).color,
    );
  }
}
