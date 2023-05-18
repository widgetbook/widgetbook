import 'package:provider/provider.dart';

import '../fields/fields.dart';
import 'knob.dart';
import 'knobs_notifier.dart';

class BoolKnob extends Knob<bool> {
  BoolKnob({
    required super.label,
    required super.value,
    super.description,
  });

  @override
  List<Field> get fields {
    return [
      BooleanField(
        group: 'knobs',
        name: label,
        initialValue: value,
        onChanged: (context, bool? value) {
          if (value == null) return;
          context.read<KnobsNotifier>().update(label, value);
        },
      ),
    ];
  }
}

class NullableBoolKnob extends Knob<bool?> {
  NullableBoolKnob({
    required super.label,
    required super.value,
    super.description,
  });

  @override
  List<Field> get fields {
    return [
      BooleanField(
        group: 'knobs',
        name: label,
        initialValue: value,
        onChanged: (context, bool? value) {
          if (value == null) return;
          context.read<KnobsNotifier>().update(label, value);
        },
      ),
    ];
  }
}
