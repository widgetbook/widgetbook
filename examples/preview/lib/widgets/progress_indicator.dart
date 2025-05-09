import 'package:flutter/material.dart';

class ProgressIndicator extends StatelessWidget {
  const ProgressIndicator({super.key, this.progress});

  final double? progress;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(value: progress, strokeWidth: 4);
  }
}
