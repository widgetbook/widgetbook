import '../double_input_knob.dart';
import '../double_slider_knob.dart';
import 'knobs_builder.dart';

class DoubleKnobsBuilder {
  DoubleKnobsBuilder(
    KnobAdded onKnobAdded,
  ) : this._onKnobAdded = onKnobAdded;

  final KnobAdded _onKnobAdded;

  /// Creates a slider that can be slid to specific double values. You can use
  /// the `num.toInt()` function to make this into an integer
  double slider({
    required String label,
    String? description,
    double? initialValue,
    double? max,
    double? min,
    int? divisions,
  }) {
    initialValue ??= max ?? min ?? 10;
    return _onKnobAdded(
      DoubleSliderKnob(
        label: label,
        value: initialValue,
        description: description,
        min: min ?? initialValue - 10,
        max: max ?? initialValue + 10,
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
    return _onKnobAdded(
      DoubleInputKnob(
        label: label,
        value: initialValue,
        description: description,
      ),
    )!;
  }
}

class DoubleOrNullKnobsBuilder {
  DoubleOrNullKnobsBuilder(
    KnobAdded onKnobAdded,
  ) : this._onKnobAdded = onKnobAdded;

  final KnobAdded _onKnobAdded;

  /// Creates a slider that can be slid to specific double values. You can use
  /// the `num?.toInt()` function to make this into an integer.
  /// Can optionally hold a null value
  double? slider({
    required String label,
    String? description,
    double? initialValue,
    double? max,
    double? min,
    int? divisions,
  }) {
    initialValue ??= max ?? min ?? 10;
    return _onKnobAdded<double?>(
      DoubleOrNullSliderKnob(
        label: label,
        value: initialValue,
        description: description,
        min: min ?? initialValue - 10,
        max: max ?? initialValue + 10,
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
    return _onKnobAdded<double?>(
      DoubleOrNullInputKnob(
        label: label,
        value: initialValue,
        description: description,
      ),
    );
  }
}
