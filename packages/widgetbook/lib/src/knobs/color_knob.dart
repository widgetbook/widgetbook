import 'dart:ui';

import 'package:provider/provider.dart';

import '../fields/fields.dart';
import 'knob.dart';
import 'knobs_notifier.dart';

class ColorKnob extends Knob<Color> {
  ColorKnob({
    required super.label,
    required super.value,
    super.description,
  });

  @override
  List<Field> get fields {
    return [
      ColorField(
        group: 'knobs',
        name: label,
        initialValue: value,
        onChanged: (context, Color? value) {
          if (value == null) return;
          context.read<KnobsNotifier>().update(label, value);
        },
      ),
    ];
  }
}
