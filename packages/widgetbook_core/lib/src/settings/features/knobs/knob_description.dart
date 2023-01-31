import 'package:flutter/material.dart';

class KnobDescription extends StatelessWidget {
  const KnobDescription({
    super.key,
    this.description,
  });

  final String? description;

  @override
  Widget build(BuildContext context) {
    final desc = description;
    return desc != null
        ? Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Text(
              desc,
            ),
          )
        : Container();
  }
}
