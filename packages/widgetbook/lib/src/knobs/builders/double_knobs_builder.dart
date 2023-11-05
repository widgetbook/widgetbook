import '../double_input_knob.dart';
import '../double_slider_knob.dart';
import 'knobs_builder.dart';

class DoubleKnobsBuilder {
  DoubleKnobsBuilder(this.onKnobAdded);

  final KnobAdded onKnobAdded;

  /// Creates a slider that can be slid to specific double values. You can use
  /// the `num.toInt()` function to make this into an integer
  double slider({
    required String label,
    String? description,
    double initialValue = 0,
    double min = 0,
    double max = 20,
    int? divisions,
  }) {
    return onKnobAdded(
      DoubleSliderKnob(
        label: label,
        initialValue: initialValue,
        description: description,
        min: min,
        max: max,
        divisions: divisions,
      ),
    )!;
  }

  /// Creates a textfield which users can type double values into. You can use
  /// the `num?.toInt()` function to turn this into an integer
  double input({
    required String label,
    String? description,
    double initialValue = 0,
  }) {
    return onKnobAdded(
      DoubleInputKnob(
        label: label,
        initialValue: initialValue,
        description: description,
      ),
    )!;
  }
}

class DoubleOrNullKnobsBuilder {
  DoubleOrNullKnobsBuilder(
    KnobAdded onKnobAdded,
  ) : this.onKnobAdded = onKnobAdded;

  final KnobAdded onKnobAdded;

  /// Creates a slider that can be slid to specific double values. You can use
  /// the `num?.toInt()` function to make this into an integer.
  /// Can optionally hold a null value
  double? slider({
    required String label,
    String? description,
    double? initialValue,
    double min = 0,
    double max = 20,
    int? divisions,
  }) {
    return onKnobAdded(
      DoubleSliderKnob.nullable(
        label: label,
        initialValue: initialValue,
        description: description,
        min: min,
        max: max,
        divisions: divisions,
      ),
    );
  }

  /// Creates a textfield which users can type double values into. You can use
  /// the `num?.toInt()` function to turn this into an integer
  /// Can optionally hold a null value
  double? input({
    required String label,
    String? description,
    double? initialValue,
  }) {
    return onKnobAdded(
      DoubleInputKnob.nullable(
        label: label,
        initialValue: initialValue,
        description: description,
      ),
    );
  }
}
