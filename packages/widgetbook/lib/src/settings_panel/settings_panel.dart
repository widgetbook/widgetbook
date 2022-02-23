import 'package:flutter/material.dart';
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
      child: Scaffold(
        appBar: const TabBar(tabs: [
          Tab(
            icon: Icon(
              Icons.build,
            ),
          )
        ]),
        body: Container(
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
    );
  }
}
