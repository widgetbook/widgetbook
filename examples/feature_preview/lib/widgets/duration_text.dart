import 'package:flutter/material.dart';

class DurationText extends StatelessWidget {
  const DurationText({super.key, required this.duration});

  final Duration? duration;

  @override
  Widget build(BuildContext context) {
    return Text(
      duration == null
          ? 'You selected no duration'
          : 'You selected ${duration!.inMilliseconds}ms',
    );
  }
}
