import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:widgetbook/src/knobs/knobs.dart';

class KnobsPanel extends StatelessWidget {
  const KnobsPanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final knobs = context.watch<KnobsNotifier>().all();
    final noKnobs = knobs.isEmpty;
    final title = noKnobs ? 'No knobs to dispaly' : 'Knobs';
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          ...knobs.map((e) => e.build())
        ],
      ),
    );
  }
}
