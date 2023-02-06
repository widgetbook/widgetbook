import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as anno;
import 'package:widgetbook_core/widgetbook_core.dart';
import 'package:widgetbook_for_widgetbook/settings/features/widgets/helper.dart';

@anno.WidgetbookUseCase(
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
