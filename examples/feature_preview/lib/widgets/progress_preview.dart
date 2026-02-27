import 'package:flutter/material.dart';

class ProgressPreview extends StatelessWidget {
  const ProgressPreview({super.key, this.progress});

  final double? progress;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      value: progress,
    );
  }
}
