import '../int_input_knob.dart';
import '../int_slider_knob.dart';
import 'knobs_builder.dart';

class IntKnobsBuilder {
  IntKnobsBuilder(this.onKnobAdded);

  final KnobAdded onKnobAdded;

  /// Creates a textfield which users can type integer values into.
  int input({
    required String label,
    String? description,
    int initialValue = 0,
  }) {
    return onKnobAdded(
      IntInputKnob(
        label: label,
        value: initialValue,
        description: description,
      ),
    )!;
  }

  /// Creates a slider that can be slid to specific int values.
  int slider({
    required String label,
    String? description,
    int? initialValue,
    int? max,
    int? min,
    int? divisions,
  }) {
    initialValue ??= max ?? min ?? 10;
    return onKnobAdded(
      IntSliderKnob(
        label: label,
        value: initialValue,
        description: description,
        min: min ?? initialValue - 10,
        max: max ?? initialValue + 10,
        divisions: divisions,
      ),
    )!;
  }
}

class IntOrNullKnobsBuilder {
  IntOrNullKnobsBuilder(
    KnobAdded onKnobAdded,
  ) : this.onKnobAdded = onKnobAdded;

  final KnobAdded onKnobAdded;

  /// Creates a textfield which users can type integer values into.
  /// Can optionally hold a null value.
  int? input({
    required String label,
    String? description,
    int? initialValue,
  }) {
    return onKnobAdded(
      IntInputKnob.nullable(
        label: label,
        value: initialValue,
        description: description,
      ),
    );
  }

  /// Creates a slider that can be slid to specific double values.
  /// Can optionally hold a null value
  int? slider({
    required String label,
    String? description,
    int? initialValue,
    int? max,
    int? min,
    int? divisions,
  }) {
    initialValue ??= max ?? min ?? 10;
    return onKnobAdded(
      IntSliderKnob.nullable(
        label: label,
        value: initialValue,
        description: description,
        min: min ?? initialValue - 10,
        max: max ?? initialValue + 10,
        divisions: divisions,
      ),
    );
  }
}
