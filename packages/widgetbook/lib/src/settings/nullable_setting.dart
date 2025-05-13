import 'package:flutter/material.dart';

import 'setting.dart';

class NullableSetting extends Setting {
  NullableSetting({
    super.key,
    required super.name,
    super.description,
    required super.child,
    required bool isNullified,
    ValueChanged<bool>? onNullified,
  }) : super(
          trailing: Checkbox(
            // The value is inverted here because the checkbox
            // is unchecked when the value is nullified.
            // And the onChange callback is called with true when
            // the value is unchecked (i.e. nullified).
            value: !isNullified,
            onChanged: (value) => onNullified?.call(!value!),
          ),
        );
}
