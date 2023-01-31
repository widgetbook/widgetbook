import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

@WidgetbookUseCase(name: 'Default', type: SettingsPanel)
Widget settingsPanel(BuildContext context) {
  return SettingsPanel(
    settings: [
      SettingsPanelData(
        name: 'Properties',
        settings: [],
      ),
      SettingsPanelData(
        name: 'Knobs',
        settings: [
          const BoolKnob(
            name: 'Bool Knob',
            value: true,
          ),
          const ColorKnob(
            name: 'Color Knob',
            value: Colors.yellow,
          ),
          const NumberKnob(
            name: 'Number Knob',
            value: 10,
          ),
          const OptionKnob(
            name: 'Option Knob',
            value: Orientation.landscape,
            values: Orientation.values,
          ),
          const SliderKnob(
            name: 'Slider Knob',
            value: 0.5,
          ),
          const TextKnob(
            name: 'Text Knob',
            value: 'This is a test',
          ),
        ],
      ),
    ],
  );
}
