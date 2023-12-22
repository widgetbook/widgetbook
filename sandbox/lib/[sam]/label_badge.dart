import 'package:flutter/material.dart';

class LabelBadge extends StatelessWidget {
  const LabelBadge({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Badge(
      label: Text(text),
    );
  }
}
