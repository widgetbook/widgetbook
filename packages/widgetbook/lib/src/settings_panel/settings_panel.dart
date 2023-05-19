import 'package:flutter/material.dart';
import 'package:widgetbook_core/widgetbook_core.dart' as core;

import '../state/state.dart';

class SettingsPanel extends StatelessWidget {
  const SettingsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final state = WidgetbookState.of(context);

    return Card(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: core.SettingsPanel(
                settings: [
                  if (state.panels.contains(WidgetbookPanel.addons)) ...{
                    core.SettingsPanelData(
                      name: 'Properties',
                      settings: state.addons.map(
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
                  if (state.panels.contains(WidgetbookPanel.knobs)) ...{
                    core.SettingsPanelData(
                      name: 'Knobs',
                      settings: state.knobs.values.map((knob) {
                        return core.KnobProperty(
                          name: knob.label,
                          description: knob.description,
                          value: knob.value,
                          isNullable: knob.isNullable,
                          changedNullable: (isEnabled) {
                            state.updateKnobNullability(knob.label, !isEnabled);
                          },
                          child: Column(
                            children: knob.fields
                                .map((field) => field.build(context))
                                .toList(),
                          ),
                        );
                      }).toList(),
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
