import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/routing/widgetbook_panel.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_core/widgetbook_core.dart' as core;

class SettingsPanel extends StatelessWidget {
  const SettingsPanel({
    required this.panels,
    super.key,
  });

  final Set<WidgetbookPanel> panels;

  @override
  Widget build(BuildContext context) {
    final addons = context.watch<AddOnProvider>().value;
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
