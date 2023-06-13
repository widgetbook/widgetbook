import 'package:flutter/material.dart';
import 'package:widgetbook/src/settings/settings.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Test', type: DropdownSetting)
Widget test(BuildContext context) {
  return DropdownSetting(
    onSelected: (p0) {},
    options: [
      WidgetbookTheme(name: 'Light', data: ThemeData.light()),
      WidgetbookTheme(name: 'Dark', data: ThemeData.dark()),
    ],
    optionValueBuilder: (option) => option.name,
  );
}
