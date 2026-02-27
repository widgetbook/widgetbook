import 'package:flutter/material.dart';

class BoolPreview extends StatelessWidget {
  const BoolPreview({super.key, this.isEnabled});

  final bool? isEnabled;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isEnabled,
      onChanged: null,
      tristate: true,
    );
  }
}
