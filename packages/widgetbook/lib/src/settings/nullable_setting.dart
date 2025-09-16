import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'setting.dart';

/// A widget that represents a nullable configuration option in Widgetbook.
@internal
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
