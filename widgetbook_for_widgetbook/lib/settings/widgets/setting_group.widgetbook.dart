import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

import 'helper.dart';

@UseCase(
  name: 'default',
  type: SettingGroup,
)
Widget settingGroupUseCase(BuildContext context) {
  return SettingGroup(
    settings: [
      complexSetting(context),
      Setting(
        name: 'Text Scale 1',
        child: DropdownSetting(
          onSelected: (p0) {},
          options: const [
            1,
            2,
          ],
          optionValueBuilder: (option) => option.toStringAsFixed(2),
        ),
      ),
      Setting(
        name: 'Text Scale 2',
        child: DropdownSetting(
          onSelected: (p0) {},
          options: const [
            1,
            2,
          ],
          optionValueBuilder: (option) => option.toStringAsFixed(2),
        ),
      ),
    ],
  );
}
