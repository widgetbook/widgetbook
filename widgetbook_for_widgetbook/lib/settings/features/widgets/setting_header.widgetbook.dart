import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart' show Knobs;
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_core/widgetbook_core.dart';

@WidgetbookUseCase(name: 'Text only', type: SettingHeader)
Widget textOnly(BuildContext context) {
  return SettingHeader(
    content: context.knobs.text(label: 'Content', initialValue: 'Frames'),
  );
}

@WidgetbookUseCase(name: 'with Trailing', type: SettingHeader)
Widget trailing(BuildContext context) {
  return SettingHeader(
    content: context.knobs.text(label: 'Content', initialValue: 'Frames'),
    trailing: Switch(
      value: context.knobs.boolean(label: 'Trailing'),
      onChanged: (_) {},
    ),
  );
}
