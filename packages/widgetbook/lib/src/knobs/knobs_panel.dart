import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/constants/radii.dart';

import 'knobs.dart';

class KnobsPanel extends StatelessWidget {
  const KnobsPanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Knobs',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        ...context.watch<KnobsNotifier>().all().map((e) => e.build())
      ],
    );
  }
}
