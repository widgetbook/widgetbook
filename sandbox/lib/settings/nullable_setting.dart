import 'package:flutter/material.dart';
import 'package:widgetbook/src/settings/settings.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: NullableSetting)
Widget nullableSettingUseCase(BuildContext context) {
  return NullableSetting(
    name: context.knobs.string(
      label: 'Name',
      initialValue: 'Knob',
    ),
    description: context.knobs.stringOrNull(
      label: 'Description',
    ),
    isNull: context.knobs.boolean(
      label: 'Is Null',
    ),
    isNullable: context.knobs.boolean(
      label: 'Is Nullable',
    ),
    child: const Placeholder(),
  );
}
