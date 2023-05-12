import 'package:provider/provider.dart';
import 'package:widgetbook/src/fields/fields.dart';
import 'package:widgetbook/src/knobs/knobs.dart';

class BoolKnob extends Knob<bool> {
  BoolKnob({
    required super.label,
    required super.value,
    super.description,
  });

  @override
  List<Field> get fields {
    return [
      ToggleField(
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
  }) : super(
          isNullable: true,
        );

  @override
  List<Field> get fields {
    return [
      ToggleField(
        group: 'knobs',
        name: label,
        initialValue: value ?? true, // TODO: allow nullable
        onChanged: (context, bool? value) {
          if (value == null) return;
          context.read<KnobsNotifier>().update(label, value);
        },
      ),
    ];
  }
}
