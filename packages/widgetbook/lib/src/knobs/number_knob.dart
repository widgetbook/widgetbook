import 'package:provider/provider.dart';
import 'package:widgetbook/src/fields/fields.dart';
import 'package:widgetbook/src/knobs/knobs.dart';

class NumberKnob extends Knob<num> {
  NumberKnob({
    required super.label,
    required super.value,
    super.description,
  });

  @override
  List<Field> get fields {
    return [
      NumberField(
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

class NullableNumberKnob extends Knob<num?> {
  NullableNumberKnob({
    required super.label,
    required super.value,
    super.description,
  });

  @override
  List<Field> get fields {
    return [
      NumberField(
        group: 'knobs',
        name: label,
        initialValue: value ?? 0, // TODO: allow nullable
        onChanged: (context, num? value) {
          if (value == null) return;
          context.read<KnobsNotifier>().update(label, value);
        },
      ),
    ];
  }
}
