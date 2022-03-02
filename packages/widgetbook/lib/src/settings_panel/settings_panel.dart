import 'package:flutter/material.dart';
import 'package:widgetbook/src/constants/constants.dart';
import 'package:widgetbook/src/constants/radii.dart';
import 'package:widgetbook/src/knobs/knobs_panel.dart';

class SettingsPanel extends StatelessWidget {
  const SettingsPanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Column(children: [
        SizedBox(
          height: Constants.controlBarHeight,
          child: TabBar(
            indicatorColor: Theme.of(context).colorScheme.primary,
            tabs: const [
              Tab(
                key: Key('knobsTab'),
                icon: Icon(
                  Icons.build,
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: Radii.defaultRadius,
            ),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: TabBarView(
                children: [
                  KnobsPanel(),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
