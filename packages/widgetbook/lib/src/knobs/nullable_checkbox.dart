import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:widgetbook/src/knobs/knobs.dart';

/// Checkbox used within knobs to make the returned value null
class NullableCheckbox<T> extends StatelessWidget {
  const NullableCheckbox({
    Key? key,
    required this.cachedValue,
    required this.value,
    required this.label,
  }) : super(key: key);

  /// The label of the corresponding knob
  final String label;

  /// The value that was used before the knob was turned to null
  final T cachedValue;

  /// The current value of the knob
  final T? value;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'No Value',
      child: Checkbox(
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
      ),
    );
  }
}
