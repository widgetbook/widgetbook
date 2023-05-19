import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

@UseCase(name: 'Default', type: SettingsPanel)
Widget settingsPanel(BuildContext context) {
  return const SettingsPanel(
    settings: [
      SettingsPanelData(
        name: 'Properties',
        settings: [],
      ),
      SettingsPanelData(
        name: 'Knobs',
        settings: [],
      ),
    ],
  );
}
