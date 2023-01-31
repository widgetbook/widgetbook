import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart' show Knobs;
import 'package:widgetbook_core/widgetbook_core.dart';

Widget complexSetting(BuildContext context) {
  return ComplexSetting(
    name: 'Frame',
    setting: frameDropdownSetting(context),
    sections: [
      frameSettingSectionData(context),
      sizeSettingData(context),
    ],
  );
}

Widget frameDropdownSetting(BuildContext context) {
  return DropdownSetting(
    options: const [
      'No Frame',
      'Widgetbook Frame',
      'Device Frame',
    ],
    optionValueBuilder: (value) => value,
    onSelected: (_) {},
  );
}

SettingSectionData sizeSettingData(BuildContext context) {
  return SettingSectionData(
    name: 'Size',
    settings: [
      SubSetting(
        name: 'Width',
        child: Text(
          context.knobs
              .slider(
                label: 'Width',
                min: 1,
                max: 300,
              )
              .toStringAsFixed(2),
        ),
      ),
      SubSetting(
        name: 'Height',
        child: Text(
          context.knobs
              .slider(
                label: 'Height',
                min: 1,
                max: 300,
              )
              .toStringAsFixed(2),
        ),
      ),
    ],
  );
}

SettingSectionData frameSettingSectionData(BuildContext context) {
  return SettingSectionData(
    name: 'Properties',
    settings: [
      SubSetting(
        name: 'Device',
        child: DropdownSetting(
          options: const ['A', 'B', 'C'],
          optionValueBuilder: (value) => value,
          onSelected: (v) {},
        ),
      ),
      SubSetting(
        name: 'Orientation',
        child: DropdownSetting(
          options: Orientation.values,
          optionValueBuilder: (value) => value.name,
          onSelected: (v) {},
        ),
      ),
    ],
  );
}

Widget frameSettingSection(BuildContext context) {
  return SettingSection(
    data: frameSettingSectionData(context),
  );
}
