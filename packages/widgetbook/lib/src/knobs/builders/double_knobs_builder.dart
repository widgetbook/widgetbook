import '../double_input_knob.dart';
import '../double_slider_knob.dart';
import '../knob.dart';
import 'knobs_builder.dart';

/// A [KnobsBuilder] for double knobs.
class DoubleKnobsBuilder {
  /// Creates a [DoubleKnobsBuilder] with the provided [onKnobAdded] callback.
  DoubleKnobsBuilder(this.onKnobAdded);

  /// The callback that is used to add a knob.
  final KnobAdded onKnobAdded;

  /// A [Knob] that holds an [double] value with a slider.
  /// Learn more: https://docs.widgetbook.io/knobs/double/slider
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

  /// A [Knob] that holds an [double] value with an input field.
  /// Learn more: https://docs.widgetbook.io/knobs/double/input
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

/// Same as [DoubleKnobsBuilder] but allows the knob to hold a null value.
class DoubleOrNullKnobsBuilder {
  /// Creates a [DoubleOrNullKnobsBuilder] with the provided
  /// [onKnobAdded] callback.
  DoubleOrNullKnobsBuilder(
    KnobAdded onKnobAdded,
  ) : this.onKnobAdded = onKnobAdded;

  /// The callback that is used to add a knob.
  final KnobAdded onKnobAdded;

  /// A [Knob] that holds an [double] value with a slider that can be null.
  /// Learn more: https://docs.widgetbook.io/knobs/double/slider
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

  /// A [Knob] that holds an [double] value with an input field that can be null.
  /// Learn more: https://docs.widgetbook.io/knobs/double/input
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
