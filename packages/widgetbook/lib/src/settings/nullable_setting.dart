import 'package:flutter/material.dart';

import 'setting.dart';

class NullableSetting extends Setting {
  NullableSetting({
    super.key,
    required super.name,
    super.description,
    required super.child,
    required bool isNull,
    bool isNullable = false,
    ValueChanged<bool>? onChangedNullable,
  }) : super(
          trailing: isNullable
              ? Checkbox(
                  value: !isNull,
                  onChanged: (value) => onChangedNullable?.call(value!),
                )
              : null,
        );
}
