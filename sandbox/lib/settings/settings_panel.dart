import 'package:flutter/material.dart';
import 'package:widgetbook/src/settings/settings.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: SettingsPanel)
Widget settingsPanel(BuildContext context) {
  return SettingsPanel(
    settings: [
      SettingsPanelData(
        name: 'Addons',
        builder: (_) => [],
      ),
      SettingsPanelData(
        name: 'Knobs',
        builder: (_) => [],
      ),
    ],
  );
}
