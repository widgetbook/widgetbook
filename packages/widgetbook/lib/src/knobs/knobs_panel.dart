import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:widgetbook/src/knobs/knobs.dart';

/// The panel containing the knobs for a usecase
class KnobsPanel extends StatelessWidget {
  const KnobsPanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final knobs = context.watch<KnobsNotifier>().all();
    if (knobs.isEmpty) {
      return const Center(
        child: Text(
          'No knobs to display',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      );
    }
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return Divider(
            thickness: 4,
            color: Theme.of(context).scaffoldBackgroundColor,
          );
        },
        physics: const NeverScrollableScrollPhysics(),
        itemCount: knobs.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(12),
          child: knobs[index].build(),
        ),
      ),
    );
  }
}
