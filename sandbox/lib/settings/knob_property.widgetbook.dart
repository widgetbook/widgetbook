import 'package:flutter/material.dart';
import 'package:widgetbook/src/settings/settings.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'default', type: KnobProperty)
Widget knobPropertyUseCase(BuildContext context) {
  return KnobProperty(
    name: context.knobs.string(
      label: 'Name',
      initialValue: 'Knob',
    ),
    value: true,
    description: context.knobs.stringOrNull(
      label: 'Description',
    ),
    isNullable: context.knobs.boolean(
      label: 'Is Nullable',
    ),
    child: const Placeholder(),
  );
}
