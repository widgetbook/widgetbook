import 'package:flutter/material.dart';
import 'package:widgetbook/src/constants/constants.dart';
import 'package:widgetbook/src/constants/radii.dart';
import 'package:widgetbook/src/knobs/knobs_panel.dart';
import 'package:widgetbook/src/properties/property_panel.dart';

class SettingsPanel<CustomTheme> extends StatelessWidget {
  const SettingsPanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(children: [
        SizedBox(
          height: Constants.controlBarHeight,
          child: TabBar(
            indicatorColor: Theme.of(context).colorScheme.primary,
            tabs: const [
              Tab(
                key: Key('knobsTab'),
                icon: Text('Knobs'),
              ),
              Tab(
                key: Key('propertiesTab'),
                icon: Text('Properties'),
              ),
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
            child: TabBarView(
              children: [
                const KnobsPanel(),
                PropertyPanel<CustomTheme>(),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
