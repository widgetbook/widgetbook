import '../../fields/fields.dart';
import '../iterable_segmented_knob.dart';
import '../knob.dart';
import 'knobs_builder.dart';

/// A [KnobsBuilder] for iterable knobs.
class IterableKnobsBuilder {
  /// Creates a [IterableKnobsBuilder] with the provided [onKnobAdded] callback.
  IterableKnobsBuilder(this.onKnobAdded);

  /// The callback that is used to add a knob.
  final KnobAdded onKnobAdded;

  /// A [Knob] that holds an [Iterable<T>] value with a segmented control.
  /// Learn more: https://docs.widgetbook.io/knobs/iterable/segmented
  Iterable<T> segmented<T>({
    required String label,
    required Iterable<T> options,
    Iterable<T>? initialOption,
    String? description,
    LabelBuilder<T>? labelBuilder,
    bool emptySelectionAllowed = true,
  }) {
    assert(options.isNotEmpty, 'Must specify at least one option');
    return onKnobAdded(
      IterableSegmentedKnob<T>(
        label: label,
        initialValue:
            initialOption ?? {if (!emptySelectionAllowed) options.first},
        description: description,
        options: options,
        labelBuilder: labelBuilder,
        emptySelectionAllowed: emptySelectionAllowed,
      ),
    )!;
  }
}

/// Same as [IterableKnobsBuilder] but allows the knob to hold a null value.
class IterableOrNullKnobsBuilder {
  /// Creates a [IterableOrNullKnobsBuilder] with the provided [onKnobAdded] callback.
  IterableOrNullKnobsBuilder(
    KnobAdded onKnobAdded,
  ) : this.onKnobAdded = onKnobAdded;

  /// The callback that is used to add a knob.
  final KnobAdded onKnobAdded;

  /// A [Knob] that holds an [Iterable<T>] value with a segmented control that can be null.
  /// Learn more: https://docs.widgetbook.io/knobs/iterable/segmented
  Iterable<T>? segmented<T>({
    required String label,
    required Iterable<T> options,
    Iterable<T>? initialOption,
    String? description,
    LabelBuilder<T>? labelBuilder,
    bool emptySelectionAllowed = true,
  }) {
    assert(options.isNotEmpty, 'Must specify at least one option');
    return onKnobAdded(
      IterableSegmentedKnob<T>.nullable(
        label: label,
        initialValue: initialOption,
        description: description,
        options: options,
        labelBuilder: labelBuilder,
        emptySelectionAllowed: emptySelectionAllowed,
      ),
    );
  }
}
