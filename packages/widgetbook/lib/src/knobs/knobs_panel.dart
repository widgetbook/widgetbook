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
    final noKnobs = knobs.isEmpty;
    final title = noKnobs ? 'No knobs to dispaly' : 'Knobs';
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return Divider(
                thickness: 4,
                color: Theme.of(context).scaffoldBackgroundColor,
              );
            },
            physics: const NeverScrollableScrollPhysics(),
            itemCount: knobs.length,
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: EdgeInsets.all(10),
                title: knobs[index].build(),
              );
            },
          )
          /* ...knobs.map((e) => ListTile( */
          /*       title: e.build(), */
          /*       contentPadding: EdgeInsets.zero, */
          /*     )) */
        ],
      ),
    );
  }
}
