import 'package:provider/provider.dart';
import 'package:widgetbook/src/knobs/knobs.dart';

import '../fields/fields.dart';

class TextKnob extends Knob<String> {
  TextKnob({
    required super.label,
    required super.value,
    super.description,
    this.maxLines = 1,
  });
  final int? maxLines;

  @override
  List<Field> get fields {
    return [
      StringField(
        group: 'knobs',
        name: label,
        initialValue: value,
        onChanged: (context, String? value) {
          if (value == null) return;
          context.read<KnobsNotifier>().update(label, value);
        },
      ),
    ];
  }
}

class NullableTextKnob extends Knob<String?> {
  NullableTextKnob({
    required super.label,
    required super.value,
    super.description,
    this.maxLines = 1,
  });

  final int? maxLines;

  @override
  List<Field> get fields {
    return [
      StringField(
        group: 'knobs',
        name: label,
        initialValue: value ?? '', // TODO: allow nullable
        onChanged: (context, String? value) {
          if (value == null) return;
          context.read<KnobsNotifier>().update(label, value);
        },
      ),
    ];
  }
}
