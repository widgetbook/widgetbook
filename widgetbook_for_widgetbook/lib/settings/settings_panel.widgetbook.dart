import 'package:flutter/material.dart';
import 'package:widgetbook/src/settings/settings.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

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
