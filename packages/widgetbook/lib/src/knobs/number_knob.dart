import 'package:provider/provider.dart';

import '../fields/fields.dart';
import 'knob.dart';
import 'knobs_notifier.dart';

class NumberKnob extends Knob<double> {
  NumberKnob({
    required super.label,
    required super.value,
    super.description,
  });

  @override
  List<Field> get fields {
    return [
      DoubleInputField(
        group: 'knobs',
        name: label,
        initialValue: value,
        onChanged: (context, num? value) {
          if (value == null) return;
          context.read<KnobsNotifier>().update(label, value);
        },
      ),
    ];
  }
}

class NullableNumberKnob extends Knob<double?> {
  NullableNumberKnob({
    required super.label,
    required super.value,
    super.description,
  });

  @override
  List<Field> get fields {
    return [
      DoubleInputField(
        group: 'knobs',
        name: label,
        initialValue: value,
        onChanged: (context, num? value) {
          if (value == null) return;
          context.read<KnobsNotifier>().update(label, value);
        },
      ),
    ];
  }
}
