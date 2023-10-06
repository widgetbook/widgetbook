import '../int_knob.dart';
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
      IntKnob(
        label: label,
        value: initialValue,
        description: description,
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
      IntKnob.nullable(
        label: label,
        value: initialValue,
        description: description,
      ),
    );
  }
}
