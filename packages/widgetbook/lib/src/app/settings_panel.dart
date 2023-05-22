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
                  if (state.addons != null) ...{
                    core.SettingsPanelData(
                      name: 'Properties',
                      settings: state.addons!
                          .map((addon) => addon.buildSetting(context))
                          .toList(),
                    ),
                  },
                  core.SettingsPanelData(
                    name: 'Knobs',
                    settings: state.knobs.values
                        .map((knob) => knob.build(context))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
