import '../int_input_knob.dart';
import '../int_slider_knob.dart';
import '../knob.dart';
import 'knobs_builder.dart';

/// A [KnobsBuilder] for integer knobs.
class IntKnobsBuilder {
  /// Creates a [IntKnobsBuilder] with the provided [onKnobAdded] callback.
  IntKnobsBuilder(this.onKnobAdded);

  /// The callback that is used to add a knob.
  final KnobAdded onKnobAdded;

  /// A [Knob] that holds an [int] value with an input field.
  /// Learn more: https://docs.widgetbook.io/knobs/integer/input
  int input({
    required String label,
    String? description,
    int initialValue = 0,
  }) {
    return onKnobAdded(
      IntInputKnob(
        label: label,
        initialValue: initialValue,
        description: description,
      ),
    )!;
  }

  /// A [Knob] that holds an [int] value with a slider.
  /// Learn more: https://docs.widgetbook.io/knobs/integer/slider
  int slider({
    required String label,
    String? description,
    int initialValue = 0,
    int min = 0,
    int max = 20,
    int? divisions,
  }) {
    return onKnobAdded(
      IntSliderKnob(
        label: label,
        initialValue: initialValue,
        description: description,
        min: min,
        max: max,
        divisions: divisions,
      ),
    )!;
  }
}

/// Same as [IntKnobsBuilder] but allows the knob to hold a null value.
class IntOrNullKnobsBuilder {
  /// Creates a [IntOrNullKnobsBuilder] with the provided [onKnobAdded] callback.
  IntOrNullKnobsBuilder(
    KnobAdded onKnobAdded,
  ) : this.onKnobAdded = onKnobAdded;

  /// The callback that is used to add a knob.
  final KnobAdded onKnobAdded;

  /// A [Knob] that holds an [int] value with an input field that can be null.
  /// Learn more: https://docs.widgetbook.io/knobs/integer/input
  int? input({
    required String label,
    String? description,
    int? initialValue,
  }) {
    return onKnobAdded(
      IntInputKnob.nullable(
        label: label,
        initialValue: initialValue,
        description: description,
      ),
    );
  }

  /// A [Knob] that holds an [int] value with a slider that can be null.
  /// Learn more: https://docs.widgetbook.io/knobs/integer/slider
  int? slider({
    required String label,
    String? description,
    int? initialValue,
    int min = 0,
    int max = 20,
    int? divisions,
  }) {
    return onKnobAdded(
      IntSliderKnob.nullable(
        label: label,
        initialValue: initialValue,
        description: description,
        min: min,
        max: max,
        divisions: divisions,
      ),
    );
  }
}
