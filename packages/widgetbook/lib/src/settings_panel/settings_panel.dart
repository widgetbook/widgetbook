import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/state/state.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_core/widgetbook_core.dart' as core;

class SettingsPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final panels = WidgetbookScope.of(context).panels;
    final addons = WidgetbookScope.of(context).addons;
    final knobs = context.watch<KnobsNotifier>().all();

    return Card(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: core.SettingsPanel(
                settings: [
                  if (panels.contains(WidgetbookPanel.addons)) ...{
                    core.SettingsPanelData(
                      name: 'Properties',
                      settings: addons.map(
                        (addon) {
                          return core.Setting(
                            name: addon.name,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: addon.fields
                                  .map((field) => field.build(context))
                                  .toList(),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  },
                  if (panels.contains(WidgetbookPanel.knobs)) ...{
                    core.SettingsPanelData(
                      name: 'Knobs',
                      settings: knobs.map((e) => e.build(context)).toList(),
                    ),
                  },
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
