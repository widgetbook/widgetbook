import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:widgetbook/src/knobs/knobs.dart';

class NullableCheckbox<T> extends StatelessWidget {
  const NullableCheckbox({
    Key? key,
    required this.cachedValue,
    required this.value,
    required this.label,
  }) : super(key: key);

  final String label;
  final T cachedValue;
  final T? value;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
    key: Key('$label-nullableCheckbox'),
      value: value == null,
      onChanged: (v) {
        T? newValue;
        switch (v) {
          case null:
          case true:
            newValue = null;
            break;
          case false:
            newValue = cachedValue;
        }
        context.read<KnobsNotifier>().update(label, newValue);
      },
    );
  }
}
