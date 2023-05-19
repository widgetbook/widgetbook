import '../fields/fields.dart';
import '../state/state.dart';
import 'knob.dart';

class TextKnob extends Knob<String> {
  TextKnob({
    required super.label,
    required super.value,
    super.description,
    this.maxLines,
  });

  final int? maxLines;

  @override
  List<Field> get fields {
    return [
      StringField(
        group: 'knobs',
        name: label,
        initialValue: value,
        maxLines: maxLines,
        onChanged: (context, String? value) {
          if (value == null) return;
          WidgetbookState.of(context).updateKnobValue(label, value);
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
    this.maxLines,
  });

  final int? maxLines;

  @override
  List<Field> get fields {
    return [
      StringField(
        group: 'knobs',
        name: label,
        initialValue: value,
        maxLines: maxLines,
        onChanged: (context, String? value) {
          if (value == null) return;
          WidgetbookState.of(context).updateKnobValue(label, value);
        },
      ),
    ];
  }
}
